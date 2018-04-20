#include <Uefi.h>
#include <Library/UefiLib.h>
#include <Library/UefiApplicationEntryPoint.h>
#include <Library/UefiBootServicesTableLib.h>
#include <Library/MemoryAllocationLib.h>
#include <Protocol/SimpleTextIn.h>

//Localiza o Handle que tem o protocolo passado como parametro
EFI_STATUS LocateHandlef(EFI_GUID *Protocol, EFI_HANDLE **HandleBuffer){

	UINTN Size = sizeof(EFI_HANDLE);
	EFI_STATUS Status = EFI_SUCCESS;

     Status = gBS->LocateHandle (
            ByProtocol,
            Protocol, //protocolo
            NULL,
            &Size,// Retorna o tamanho necessario para o ponteiro HandleBuffer acessar
            *HandleBuffer
            );
     // checa se o ponteiro passado , HandleBuffer, tem tamanho suficiente para o retorno da LocateHandle
     if(Status == EFI_BUFFER_TOO_SMALL) {
         //Print(L"Error - Status %r\n", Status);
         FreePool(*HandleBuffer);
        // Print(L"Size : %d\n",Size);
         *HandleBuffer = AllocateZeroPool(Size);

         Status = gBS->LocateHandle (
            ByProtocol,
            Protocol, //protocolo
            NULL,
            &Size,// Retorna o tamanho necessario para o ponteiro HandleBuffer acessar
            *HandleBuffer
            );

        if(EFI_ERROR(Status)){
            Print(L"Error - Status %r\n",Status);
            return Status;
        }       

     } 
     else if (EFI_ERROR(Status)) {        
        Print(L"Error - Status %r\n", Status);
        return Status;
    } 
    return Status;
}

EFI_STATUS OpenProtocolf(EFI_GUID *Protocol ,EFI_HANDLE Handle, EFI_HANDLE ImageHandle ,VOID **Interface){

	EFI_STATUS Status = EFI_SUCCESS;
	//Com o vetor de Handle's HandleBuffer vamos fazer a abertura do Protocolo com o OpenProtocol
     Status = gBS->OpenProtocol (
             Handle,//Passado o primeiro Handle do vetor
             Protocol,//Passado a Guid do Protocolo
             Interface,//Retorna o Ponteiro para o Protocolo Pedido
             ImageHandle,
             NULL,
             EFI_OPEN_PROTOCOL_GET_PROTOCOL
             );

     if(EFI_ERROR(Status)) {
         Print(L"ErrorOpenProtocol - Status %r\n",Status);
         return Status;
     }

     return Status;
}

EFI_STATUS
EFIAPI
UefiMain 
(
    IN EFI_HANDLE        ImageHandle,
    IN EFI_SYSTEM_TABLE  *SystemTable
)
{

    EFI_STATUS Status = EFI_SUCCESS;
    UINTN Size = sizeof(EFI_HANDLE);
    EFI_HANDLE* HandleBuffer = AllocateZeroPool(Size);
    EFI_SIMPLE_TEXT_INPUT_PROTOCOL *TextInProtocol = NULL;  
    EFI_INPUT_KEY Key;
    UINTN Event = 0;
    UINTN POSITION = 0;
    CHAR16 *Buffer = AllocateZeroPool(1024*sizeof(CHAR16));


    LocateHandlef(&gEfiSimpleTextInProtocolGuid, &HandleBuffer);

    OpenProtocolf(&gEfiSimpleTextInProtocolGuid, HandleBuffer[0], ImageHandle, (VOID**)&TextInProtocol);


    //Com o vetor de Handle's HandleBuffer vamos fazer a abertura do Protocolo com o OpenProtocol
     Status = gBS->OpenProtocol (
             HandleBuffer[0],//Passado o primeiro Handle do vetor
             &gEfiSimpleTextInProtocolGuid,//Passado a Guid do Protocolo
             (VOID**)&TextInProtocol,//Retorna o Ponteiro para o Protocolo Pedido
             ImageHandle,
             NULL,
             EFI_OPEN_PROTOCOL_GET_PROTOCOL
             );

     if(EFI_ERROR(Status)) {
         Print(L"ErrorOpenProtocol - Status %r\n",Status);
         return Status;
     }

     while(Key.UnicodeChar != SCAN_F3){

         Status = gBS->WaitForEvent(1,&TextInProtocol->WaitForKey,&Event);

         if(EFI_ERROR(Status)) {
             Print(L"ErrorWaitForEvent - Status %r\n",Status);
         }

         Status = TextInProtocol->ReadKeyStroke(TextInProtocol, &Key);

         if(EFI_ERROR(Status)) {
             Print(L"Error - Status %r\n",Status);
             return Status;
         }

         Buffer[POSITION] = Key.UnicodeChar;
         POSITION++;



         Print(L"%c",Key.UnicodeChar);
     }

     Print(L"A Palavra inserida foi : \n");

     Buffer[POSITION - 1] = '\0';
     POSITION = 0;

     while(Buffer[POSITION]!='\0'){

         Print(L"%c",Buffer[POSITION]);
         POSITION++;

     }
     Print(L"\n");

    

    return Status;
}
