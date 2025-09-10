# cmake files support debug production
include("${CMAKE_CURRENT_LIST_DIR}/rule.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/file.cmake")

set(Interrupt_config_1_library_list )

# Handle files with suffix (s|as|asm|AS|ASM|As|aS|Asm), for group config_1_toolchain
if(Interrupt_config_1_config_1_toolchain_FILE_TYPE_assemble)
add_library(Interrupt_config_1_config_1_toolchain_assemble OBJECT ${Interrupt_config_1_config_1_toolchain_FILE_TYPE_assemble})
    Interrupt_config_1_config_1_toolchain_assemble_rule(Interrupt_config_1_config_1_toolchain_assemble)
    list(APPEND Interrupt_config_1_library_list "$<TARGET_OBJECTS:Interrupt_config_1_config_1_toolchain_assemble>")
endif()

# Handle files with suffix S, for group config_1_toolchain
if(Interrupt_config_1_config_1_toolchain_FILE_TYPE_assemblePreprocess)
add_library(Interrupt_config_1_config_1_toolchain_assemblePreprocess OBJECT ${Interrupt_config_1_config_1_toolchain_FILE_TYPE_assemblePreprocess})
    Interrupt_config_1_config_1_toolchain_assemblePreprocess_rule(Interrupt_config_1_config_1_toolchain_assemblePreprocess)
    list(APPEND Interrupt_config_1_library_list "$<TARGET_OBJECTS:Interrupt_config_1_config_1_toolchain_assemblePreprocess>")
endif()

# Handle files with suffix [cC], for group config_1_toolchain
if(Interrupt_config_1_config_1_toolchain_FILE_TYPE_compile)
add_library(Interrupt_config_1_config_1_toolchain_compile OBJECT ${Interrupt_config_1_config_1_toolchain_FILE_TYPE_compile})
    Interrupt_config_1_config_1_toolchain_compile_rule(Interrupt_config_1_config_1_toolchain_compile)
    list(APPEND Interrupt_config_1_library_list "$<TARGET_OBJECTS:Interrupt_config_1_config_1_toolchain_compile>")
endif()


add_executable(Interrupt_config_1_image_zsdIyys_ ${Interrupt_config_1_library_list})

set_target_properties(Interrupt_config_1_image_zsdIyys_ PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${Interrupt_config_1_output_dir})
set_target_properties(Interrupt_config_1_image_zsdIyys_ PROPERTIES OUTPUT_NAME "config_1")
set_target_properties(Interrupt_config_1_image_zsdIyys_ PROPERTIES SUFFIX ".elf")
         

target_link_libraries(Interrupt_config_1_image_zsdIyys_ PRIVATE ${Interrupt_config_1_config_1_toolchain_FILE_TYPE_link})


# Add the link options from the rule file.
Interrupt_config_1_link_rule(Interrupt_config_1_image_zsdIyys_)




