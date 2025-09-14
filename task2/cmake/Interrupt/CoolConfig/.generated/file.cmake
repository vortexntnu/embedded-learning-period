# The following variables contains the files used by the different stages of the build process.
set(Interrupt_CoolConfig_default_XC32_FILE_TYPE_assemble)
set_source_files_properties(${Interrupt_CoolConfig_default_XC32_FILE_TYPE_assemble} PROPERTIES LANGUAGE ASM)

# For assembly files, add "." to the include path for each file so that .include with a relative path works
foreach(source_file ${Interrupt_CoolConfig_default_XC32_FILE_TYPE_assemble})
        set_source_files_properties(${source_file} PROPERTIES INCLUDE_DIRECTORIES "$<PATH:NORMAL_PATH,$<PATH:REMOVE_FILENAME,${source_file}>>")
endforeach()

set(Interrupt_CoolConfig_default_XC32_FILE_TYPE_assembleWithPreprocess)
set_source_files_properties(${Interrupt_CoolConfig_default_XC32_FILE_TYPE_assembleWithPreprocess} PROPERTIES LANGUAGE ASM)

# For assembly files, add "." to the include path for each file so that .include with a relative path works
foreach(source_file ${Interrupt_CoolConfig_default_XC32_FILE_TYPE_assembleWithPreprocess})
        set_source_files_properties(${source_file} PROPERTIES INCLUDE_DIRECTORIES "$<PATH:NORMAL_PATH,$<PATH:REMOVE_FILENAME,${source_file}>>")
endforeach()

set(Interrupt_CoolConfig_default_XC32_FILE_TYPE_compile "${CMAKE_CURRENT_SOURCE_DIR}/../../../main.c")
set_source_files_properties(${Interrupt_CoolConfig_default_XC32_FILE_TYPE_compile} PROPERTIES LANGUAGE C)
set(Interrupt_CoolConfig_default_XC32_FILE_TYPE_compile_cpp)
set_source_files_properties(${Interrupt_CoolConfig_default_XC32_FILE_TYPE_compile_cpp} PROPERTIES LANGUAGE CXX)
set(Interrupt_CoolConfig_default_XC32_FILE_TYPE_link)
set(Interrupt_CoolConfig_image_name "CoolConfig.elf")
set(Interrupt_CoolConfig_image_base_name "CoolConfig")


# The output directory of the final image.
set(Interrupt_CoolConfig_output_dir "${CMAKE_CURRENT_SOURCE_DIR}/../../../out/Interrupt")
