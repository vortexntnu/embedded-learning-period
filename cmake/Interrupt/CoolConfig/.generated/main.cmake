# cmake files support debug production
include("${CMAKE_CURRENT_LIST_DIR}/rule.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/file.cmake")

set(Interrupt_CoolConfig_library_list )


add_executable(Interrupt_CoolConfig_image_O9HO41_P ${Interrupt_CoolConfig_library_list})

set_target_properties(Interrupt_CoolConfig_image_O9HO41_P PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${Interrupt_CoolConfig_output_dir})
set_target_properties(Interrupt_CoolConfig_image_O9HO41_P PROPERTIES OUTPUT_NAME "CoolConfig")
set_target_properties(Interrupt_CoolConfig_image_O9HO41_P PROPERTIES SUFFIX ".elf")
         




# Add the link options from the rule file.
Interrupt_CoolConfig_link_rule(Interrupt_CoolConfig_image_O9HO41_P)

# Add bin2hex target for converting built file to a .hex file.
string(REGEX REPLACE [.]elf$ .hex Interrupt_CoolConfig_image_name_hex ${Interrupt_CoolConfig_image_name})
add_custom_target(Interrupt_CoolConfig_Bin2Hex ALL
    COMMAND ${MP_BIN2HEX} \"${Interrupt_CoolConfig_output_dir}/${Interrupt_CoolConfig_image_name}\"
    BYPRODUCTS ${Interrupt_CoolConfig_output_dir}/${Interrupt_CoolConfig_image_name_hex}
    COMMENT "Convert built file to .hex")
add_dependencies(Interrupt_CoolConfig_Bin2Hex Interrupt_CoolConfig_image_O9HO41_P)





