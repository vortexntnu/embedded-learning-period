# The following variables contains the files used by the different stages of the build process.
set(Task8_default_default_XC32_FILE_TYPE_assemble)
set_source_files_properties(${Task8_default_default_XC32_FILE_TYPE_assemble} PROPERTIES LANGUAGE ASM)

# For assembly files, add "." to the include path for each file so that .include with a relative path works
foreach(source_file ${Task8_default_default_XC32_FILE_TYPE_assemble})
        set_source_files_properties(${source_file} PROPERTIES INCLUDE_DIRECTORIES "$<PATH:NORMAL_PATH,$<PATH:REMOVE_FILENAME,${source_file}>>")
endforeach()

set(Task8_default_default_XC32_FILE_TYPE_assembleWithPreprocess)
set_source_files_properties(${Task8_default_default_XC32_FILE_TYPE_assembleWithPreprocess} PROPERTIES LANGUAGE ASM)

# For assembly files, add "." to the include path for each file so that .include with a relative path works
foreach(source_file ${Task8_default_default_XC32_FILE_TYPE_assembleWithPreprocess})
        set_source_files_properties(${source_file} PROPERTIES INCLUDE_DIRECTORIES "$<PATH:NORMAL_PATH,$<PATH:REMOVE_FILENAME,${source_file}>>")
endforeach()

set(Task8_default_default_XC32_FILE_TYPE_compile
    "${CMAKE_CURRENT_SOURCE_DIR}/../../../clock.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/../../../main.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/../../../sercom.c")
set_source_files_properties(${Task8_default_default_XC32_FILE_TYPE_compile} PROPERTIES LANGUAGE C)
set(Task8_default_default_XC32_FILE_TYPE_compile_cpp)
set_source_files_properties(${Task8_default_default_XC32_FILE_TYPE_compile_cpp} PROPERTIES LANGUAGE CXX)
set(Task8_default_default_XC32_FILE_TYPE_link)
set(Task8_default_image_name "default.elf")
set(Task8_default_image_base_name "default")


# The output directory of the final image.
set(Task8_default_output_dir "${CMAKE_CURRENT_SOURCE_DIR}/../../../out/Task8")
