[Defines]
    PLATFORM_NAME                 = MateusPkg
    PLATFORM_GUID                 = 4beca1b5-f8c4-4966-b01e-57aff8d82577
    PLATFORM_VERSION              = 0.01
    DSC_SPECIFICATION             = 0x00010006
    OUTPUT_DIRECTORY              = Build/MateusPkg
    SUPPORTED_ARCHITECTURES       = IA32|X64|ARM|AARCH64
    BUILD_TARGETS                 = DEBUG|RELEASE|NOOPT
    SKUILD_IDENTIFIER             = DEFAULT


    DEFINE SOURCE_DEBUG_ENABLE      = TRUE
    DEFINE DEBUG_ON_SERIAL_PORT     = TRUE
    DEFINE DEBUG_PRINT_ERROR_LEVEL  = 0x80000040
    DEFINE DEBUG_PROPERTY_MASK      = 0xFF

[LibraryClasses]
    #
    # Entry Point Libraries
    #
    UefiApplicationEntryPoint|MdePkg/Library/UefiApplicationEntryPoint/UefiApplicationEntryPoint.inf
    ShellCEntryLib|ShellPkg/Library/UefiShellCEntryLib/UefiShellCEntryLib.inf
    UefiDriverEntryPoint|MdePkg/Library/UefiDriverEntryPoint/UefiDriverEntryPoint.inf
    #
    # Common Libraries
    #
    BaseLib|MdePkg/Library/BaseLib/BaseLib.inf
    BaseMemoryLib|MdePkg/Library/BaseMemoryLib/BaseMemoryLib.inf
    UefiLib|MdePkg/Library/UefiLib/UefiLib.inf
    PrintLib|MdePkg/Library/BasePrintLib/BasePrintLib.inf
    PcdLib|MdePkg/Library/BasePcdLibNull/BasePcdLibNull.inf
    MemoryAllocationLib|MdePkg/Library/UefiMemoryAllocationLib/UefiMemoryAllocationLib.inf
    UefiBootServicesTableLib|MdePkg/Library/UefiBootServicesTableLib/UefiBootServicesTableLib.inf
    UefiRuntimeServicesTableLib|MdePkg/Library/UefiRuntimeServicesTableLib/UefiRuntimeServicesTableLib.inf

    #
    # Ovmf setup
    #
    TimerLib|OvmfPkg/Library/AcpiTimerLib/DxeAcpiTimerLib.inf
    SerialPortLib|PcAtChipsetPkg/Library/SerialIoLib/SerialIoLib.inf

        !if $(TARGET) == DEBUG
    !if $(DEBUG_ON_SERIAL_PORT)
        DebugLib|MdePkg/Library/BaseDebugLibSerialPort/BaseDebugLibSerialPort.inf
        DebugPrintErrorLevelLib|MdePkg/Library/BaseDebugPrintErrorLevelLib/BaseDebugPrintErrorLevelLib.inf
        !else
        DebugLib|MdePkg/Library/UefiDebugLibConOut/UefiDebugLibConOut.inf
        DebugPrintErrorLevelLib|MdePkg/Library/BaseDebugPrintErrorLevelLib/BaseDebugPrintErrorLevelLib.inf
        !endif
        !else
        DebugLib|MdePkg/Library/BaseDebugLibNull/BaseDebugLibNull.inf
        !endif

    !if $(SOURCE_DEBUG_ENABLE)
        PeCoffExtraActionLib|SourceLevelDebugPkg/Library/PeCoffExtraActionLibDebug/PeCoffExtraActionLibDebug.inf
        DebugCommunicationLib|SourceLevelDebugPkg/Library/DebugCommunicationLibSerialPort/DebugCommunicationLibSerialPort.inf
        !else
        PeCoffExtraActionLib|MdePkg/Library/BasePeCoffExtraActionLibNull/BasePeCoffExtraActionLibNull.inf
        DebugAgentLib|MdeModulePkg/Library/DebugAgentLibNull/DebugAgentLibNull.inf
        !endif

        DevicePathLib|MdePkg/Library/UefiDevicePathLib/UefiDevicePathLib.inf
        PeCoffGetEntryPointLib|MdePkg/Library/BasePeCoffGetEntryPointLib/BasePeCoffGetEntryPointLib.inf
        IoLib|MdePkg/Library/BaseIoLibIntrinsic/BaseIoLibIntrinsic.inf
        PciLib|MdePkg/Library/BasePciLibCf8/BasePciLibCf8.inf
        PciCf8Lib|MdePkg/Library/BasePciCf8Lib/BasePciCf8Lib.inf
        SynchronizationLib|MdePkg/Library/BaseSynchronizationLib/BaseSynchronizationLib.inf
        UefiRuntimeLib|MdePkg/Library/UefiRuntimeLib/UefiRuntimeLib.inf
        HiiLib|MdeModulePkg/Library/UefiHiiLib/UefiHiiLib.inf
        UefiHiiServicesLib|MdeModulePkg/Library/UefiHiiServicesLib/UefiHiiServicesLib.inf
        PerformanceLib|MdeModulePkg/Library/DxePerformanceLib/DxePerformanceLib.inf
        HobLib|MdePkg/Library/DxeHobLib/DxeHobLib.inf
        FileHandleLib|MdePkg/Library/UefiFileHandleLib/UefiFileHandleLib.inf
        SortLib|MdeModulePkg/Library/UefiSortLib/UefiSortLib.inf
        ShellLib|ShellPkg/Library/UefiShellLib/UefiShellLib.inf
        CacheMaintenanceLib|MdePkg/Library/BaseCacheMaintenanceLib/BaseCacheMaintenanceLib.inf
        LibC|StdLib/LibC/LibC.inf

    [Components]
        MateusPkg/Aplications/HelloUefi/HelloUefi.inf    
    
    !include StdLib/StdLib.inc
