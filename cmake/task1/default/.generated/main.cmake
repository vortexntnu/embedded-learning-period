# cmake files support debug production
include("${CMAKE_CURRENT_LIST_DIR}/rule.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/file.cmake")

set(task1_default_library_list )

# Handle files with suffix (s|as|asm|AS|ASM|As|aS|Asm), for group default-XC8
if(task1_default_default_XC8_FILE_TYPE_assemble)
add_library(task1_default_default_XC8_assemble OBJECT ${task1_default_default_XC8_FILE_TYPE_assemble})
    task1_default_default_XC8_assemble_rule(task1_default_default_XC8_assemble)
    list(APPEND task1_default_library_list "$<TARGET_OBJECTS:task1_default_default_XC8_assemble>")
endif()

# Handle files with suffix S, for group default-XC8
if(task1_default_default_XC8_FILE_TYPE_assemblePreprocess)
add_library(task1_default_default_XC8_assemblePreprocess OBJECT ${task1_default_default_XC8_FILE_TYPE_assemblePreprocess})
    task1_default_default_XC8_assemblePreprocess_rule(task1_default_default_XC8_assemblePreprocess)
    list(APPEND task1_default_library_list "$<TARGET_OBJECTS:task1_default_default_XC8_assemblePreprocess>")
endif()

# Handle files with suffix [cC], for group default-XC8
if(task1_default_default_XC8_FILE_TYPE_compile)
add_library(task1_default_default_XC8_compile OBJECT ${task1_default_default_XC8_FILE_TYPE_compile})
    task1_default_default_XC8_compile_rule(task1_default_default_XC8_compile)
    list(APPEND task1_default_library_list "$<TARGET_OBJECTS:task1_default_default_XC8_compile>")
endif()


add_executable(task1_default_image_SrAKr2Uf ${task1_default_library_list})

set_target_properties(task1_default_image_SrAKr2Uf PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${task1_default_output_dir})
set_target_properties(task1_default_image_SrAKr2Uf PROPERTIES OUTPUT_NAME "default")
set_target_properties(task1_default_image_SrAKr2Uf PROPERTIES SUFFIX ".elf")
         

target_link_libraries(task1_default_image_SrAKr2Uf PRIVATE ${task1_default_default_XC8_FILE_TYPE_link})


# Add the link options from the rule file.
task1_default_link_rule(task1_default_image_SrAKr2Uf)




