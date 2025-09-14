# cmake files support debug production
include("${CMAKE_CURRENT_LIST_DIR}/rule.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/file.cmake")

set(Task8_default_library_list )

# Handle files with suffix s, for group default-XC32
if(Task8_default_default_XC32_FILE_TYPE_assemble)
add_library(Task8_default_default_XC32_assemble OBJECT ${Task8_default_default_XC32_FILE_TYPE_assemble})
    Task8_default_default_XC32_assemble_rule(Task8_default_default_XC32_assemble)
    list(APPEND Task8_default_library_list "$<TARGET_OBJECTS:Task8_default_default_XC32_assemble>")
endif()

# Handle files with suffix S, for group default-XC32
if(Task8_default_default_XC32_FILE_TYPE_assembleWithPreprocess)
add_library(Task8_default_default_XC32_assembleWithPreprocess OBJECT ${Task8_default_default_XC32_FILE_TYPE_assembleWithPreprocess})
    Task8_default_default_XC32_assembleWithPreprocess_rule(Task8_default_default_XC32_assembleWithPreprocess)
    list(APPEND Task8_default_library_list "$<TARGET_OBJECTS:Task8_default_default_XC32_assembleWithPreprocess>")
endif()

# Handle files with suffix [cC], for group default-XC32
if(Task8_default_default_XC32_FILE_TYPE_compile)
add_library(Task8_default_default_XC32_compile OBJECT ${Task8_default_default_XC32_FILE_TYPE_compile})
    Task8_default_default_XC32_compile_rule(Task8_default_default_XC32_compile)
    list(APPEND Task8_default_library_list "$<TARGET_OBJECTS:Task8_default_default_XC32_compile>")
endif()

# Handle files with suffix cpp, for group default-XC32
if(Task8_default_default_XC32_FILE_TYPE_compile_cpp)
add_library(Task8_default_default_XC32_compile_cpp OBJECT ${Task8_default_default_XC32_FILE_TYPE_compile_cpp})
    Task8_default_default_XC32_compile_cpp_rule(Task8_default_default_XC32_compile_cpp)
    list(APPEND Task8_default_library_list "$<TARGET_OBJECTS:Task8_default_default_XC32_compile_cpp>")
endif()


add_executable(Task8_default_image_jjtzSKF6 ${Task8_default_library_list})

set_target_properties(Task8_default_image_jjtzSKF6 PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${Task8_default_output_dir})
set_target_properties(Task8_default_image_jjtzSKF6 PROPERTIES OUTPUT_NAME "default")
set_target_properties(Task8_default_image_jjtzSKF6 PROPERTIES SUFFIX ".elf")
         

target_link_libraries(Task8_default_image_jjtzSKF6 PRIVATE ${Task8_default_default_XC32_FILE_TYPE_link})


# Add the link options from the rule file.
Task8_default_link_rule(Task8_default_image_jjtzSKF6)

# Add bin2hex target for converting built file to a .hex file.
string(REGEX REPLACE [.]elf$ .hex Task8_default_image_name_hex ${Task8_default_image_name})
add_custom_target(Task8_default_Bin2Hex ALL
    COMMAND ${MP_BIN2HEX} \"${Task8_default_output_dir}/${Task8_default_image_name}\"
    BYPRODUCTS ${Task8_default_output_dir}/${Task8_default_image_name_hex}
    COMMENT "Convert built file to .hex")
add_dependencies(Task8_default_Bin2Hex Task8_default_image_jjtzSKF6)





