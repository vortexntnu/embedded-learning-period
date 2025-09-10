# cmake files support debug production
include("${CMAKE_CURRENT_LIST_DIR}/rule.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/file.cmake")

set(Interrupt_default_library_list )

# Handle files with suffix (s|as|asm|AS|ASM|As|aS|Asm), for group default-AVR-GCC
if(Interrupt_default_default_AVR_GCC_FILE_TYPE_assemble)
add_library(Interrupt_default_default_AVR_GCC_assemble OBJECT ${Interrupt_default_default_AVR_GCC_FILE_TYPE_assemble})
    Interrupt_default_default_AVR_GCC_assemble_rule(Interrupt_default_default_AVR_GCC_assemble)
    list(APPEND Interrupt_default_library_list "$<TARGET_OBJECTS:Interrupt_default_default_AVR_GCC_assemble>")
endif()

# Handle files with suffix S, for group default-AVR-GCC
if(Interrupt_default_default_AVR_GCC_FILE_TYPE_assemblePreprocess)
add_library(Interrupt_default_default_AVR_GCC_assemblePreprocess OBJECT ${Interrupt_default_default_AVR_GCC_FILE_TYPE_assemblePreprocess})
    Interrupt_default_default_AVR_GCC_assemblePreprocess_rule(Interrupt_default_default_AVR_GCC_assemblePreprocess)
    list(APPEND Interrupt_default_library_list "$<TARGET_OBJECTS:Interrupt_default_default_AVR_GCC_assemblePreprocess>")
endif()

# Handle files with suffix [cC], for group default-AVR-GCC
if(Interrupt_default_default_AVR_GCC_FILE_TYPE_compile)
add_library(Interrupt_default_default_AVR_GCC_compile OBJECT ${Interrupt_default_default_AVR_GCC_FILE_TYPE_compile})
    Interrupt_default_default_AVR_GCC_compile_rule(Interrupt_default_default_AVR_GCC_compile)
    list(APPEND Interrupt_default_library_list "$<TARGET_OBJECTS:Interrupt_default_default_AVR_GCC_compile>")
endif()


add_executable(Interrupt_default_image_fdugTixG ${Interrupt_default_library_list})

set_target_properties(Interrupt_default_image_fdugTixG PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${Interrupt_default_output_dir})
set_target_properties(Interrupt_default_image_fdugTixG PROPERTIES OUTPUT_NAME "default")
set_target_properties(Interrupt_default_image_fdugTixG PROPERTIES SUFFIX ".elf")
         

target_link_libraries(Interrupt_default_image_fdugTixG PRIVATE ${Interrupt_default_default_AVR_GCC_FILE_TYPE_link})


# Add the link options from the rule file.
Interrupt_default_link_rule(Interrupt_default_image_fdugTixG)




