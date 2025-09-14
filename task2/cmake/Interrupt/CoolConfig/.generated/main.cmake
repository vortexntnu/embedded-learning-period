# cmake files support debug production
include("${CMAKE_CURRENT_LIST_DIR}/rule.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/file.cmake")

set(Interrupt_CoolConfig_library_list )

# Handle files with suffix s, for group default-XC32
if(Interrupt_CoolConfig_default_XC32_FILE_TYPE_assemble)
add_library(Interrupt_CoolConfig_default_XC32_assemble OBJECT ${Interrupt_CoolConfig_default_XC32_FILE_TYPE_assemble})
    Interrupt_CoolConfig_default_XC32_assemble_rule(Interrupt_CoolConfig_default_XC32_assemble)
    list(APPEND Interrupt_CoolConfig_library_list "$<TARGET_OBJECTS:Interrupt_CoolConfig_default_XC32_assemble>")
endif()

# Handle files with suffix S, for group default-XC32
if(Interrupt_CoolConfig_default_XC32_FILE_TYPE_assembleWithPreprocess)
add_library(Interrupt_CoolConfig_default_XC32_assembleWithPreprocess OBJECT ${Interrupt_CoolConfig_default_XC32_FILE_TYPE_assembleWithPreprocess})
    Interrupt_CoolConfig_default_XC32_assembleWithPreprocess_rule(Interrupt_CoolConfig_default_XC32_assembleWithPreprocess)
    list(APPEND Interrupt_CoolConfig_library_list "$<TARGET_OBJECTS:Interrupt_CoolConfig_default_XC32_assembleWithPreprocess>")
endif()

# Handle files with suffix [cC], for group default-XC32
if(Interrupt_CoolConfig_default_XC32_FILE_TYPE_compile)
add_library(Interrupt_CoolConfig_default_XC32_compile OBJECT ${Interrupt_CoolConfig_default_XC32_FILE_TYPE_compile})
    Interrupt_CoolConfig_default_XC32_compile_rule(Interrupt_CoolConfig_default_XC32_compile)
    list(APPEND Interrupt_CoolConfig_library_list "$<TARGET_OBJECTS:Interrupt_CoolConfig_default_XC32_compile>")
endif()

# Handle files with suffix cpp, for group default-XC32
if(Interrupt_CoolConfig_default_XC32_FILE_TYPE_compile_cpp)
add_library(Interrupt_CoolConfig_default_XC32_compile_cpp OBJECT ${Interrupt_CoolConfig_default_XC32_FILE_TYPE_compile_cpp})
    Interrupt_CoolConfig_default_XC32_compile_cpp_rule(Interrupt_CoolConfig_default_XC32_compile_cpp)
    list(APPEND Interrupt_CoolConfig_library_list "$<TARGET_OBJECTS:Interrupt_CoolConfig_default_XC32_compile_cpp>")
endif()


add_executable(Interrupt_CoolConfig_image_wj8dWaCn ${Interrupt_CoolConfig_library_list})

set_target_properties(Interrupt_CoolConfig_image_wj8dWaCn PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${Interrupt_CoolConfig_output_dir})
set_target_properties(Interrupt_CoolConfig_image_wj8dWaCn PROPERTIES OUTPUT_NAME "CoolConfig")
set_target_properties(Interrupt_CoolConfig_image_wj8dWaCn PROPERTIES SUFFIX ".elf")
         

target_link_libraries(Interrupt_CoolConfig_image_wj8dWaCn PRIVATE ${Interrupt_CoolConfig_default_XC32_FILE_TYPE_link})


# Add the link options from the rule file.
Interrupt_CoolConfig_link_rule(Interrupt_CoolConfig_image_wj8dWaCn)

# Add bin2hex target for converting built file to a .hex file.
string(REGEX REPLACE [.]elf$ .hex Interrupt_CoolConfig_image_name_hex ${Interrupt_CoolConfig_image_name})
add_custom_target(Interrupt_CoolConfig_Bin2Hex ALL
    COMMAND ${MP_BIN2HEX} \"${Interrupt_CoolConfig_output_dir}/${Interrupt_CoolConfig_image_name}\"
    BYPRODUCTS ${Interrupt_CoolConfig_output_dir}/${Interrupt_CoolConfig_image_name_hex}
    COMMENT "Convert built file to .hex")
add_dependencies(Interrupt_CoolConfig_Bin2Hex Interrupt_CoolConfig_image_wj8dWaCn)





