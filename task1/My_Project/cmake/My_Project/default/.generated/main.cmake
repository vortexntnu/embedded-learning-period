# cmake files support debug production
include("${CMAKE_CURRENT_LIST_DIR}/rule.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/file.cmake")

set(My_Project_default_library_list )

# Handle files with suffix (s|as|asm|AS|ASM|As|aS|Asm), for group default-XC8
if(My_Project_default_default_XC8_FILE_TYPE_assemble)
add_library(My_Project_default_default_XC8_assemble OBJECT ${My_Project_default_default_XC8_FILE_TYPE_assemble})
    My_Project_default_default_XC8_assemble_rule(My_Project_default_default_XC8_assemble)
    list(APPEND My_Project_default_library_list "$<TARGET_OBJECTS:My_Project_default_default_XC8_assemble>")
endif()

# Handle files with suffix S, for group default-XC8
if(My_Project_default_default_XC8_FILE_TYPE_assemblePreprocess)
add_library(My_Project_default_default_XC8_assemblePreprocess OBJECT ${My_Project_default_default_XC8_FILE_TYPE_assemblePreprocess})
    My_Project_default_default_XC8_assemblePreprocess_rule(My_Project_default_default_XC8_assemblePreprocess)
    list(APPEND My_Project_default_library_list "$<TARGET_OBJECTS:My_Project_default_default_XC8_assemblePreprocess>")
endif()

# Handle files with suffix [cC], for group default-XC8
if(My_Project_default_default_XC8_FILE_TYPE_compile)
add_library(My_Project_default_default_XC8_compile OBJECT ${My_Project_default_default_XC8_FILE_TYPE_compile})
    My_Project_default_default_XC8_compile_rule(My_Project_default_default_XC8_compile)
    list(APPEND My_Project_default_library_list "$<TARGET_OBJECTS:My_Project_default_default_XC8_compile>")
endif()


add_executable(My_Project_default_image_5pvt9hjm ${My_Project_default_library_list})

set_target_properties(My_Project_default_image_5pvt9hjm PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${My_Project_default_output_dir})
set_target_properties(My_Project_default_image_5pvt9hjm PROPERTIES OUTPUT_NAME "default")
set_target_properties(My_Project_default_image_5pvt9hjm PROPERTIES SUFFIX ".elf")
         

target_link_libraries(My_Project_default_image_5pvt9hjm PRIVATE ${My_Project_default_default_XC8_FILE_TYPE_link})


# Add the link options from the rule file.
My_Project_default_link_rule(My_Project_default_image_5pvt9hjm)




