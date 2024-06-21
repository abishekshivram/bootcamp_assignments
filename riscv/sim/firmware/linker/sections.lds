MEMORY {
        rom : ORIGIN = 0x00000000, LENGTH = 0x00000c00
        ram : ORIGIN = 0x00000c00, LENGTH = 0x00000400
}

INCLUDE common_linker.lds
