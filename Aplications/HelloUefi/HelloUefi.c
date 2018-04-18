#include <Uefi.h>
#include <Library/UefiLib.h>
#include <Library/UefiApplicationEntryPoint.h>


EFI_STATUS
EFIAPI
UefiMain 
(
    IN EFI_HANDLE        ImageHandle,
    IN EFI_SYSTEM_TABLE  *SystemTable
)
{
    Print(L"Hello Uefi! ta OK?\n");

    return EFI_SUCCESS;
}
