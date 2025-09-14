# cmake files support debug production
include("${CMAKE_CURRENT_LIST_DIR}/rule.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/file.cmake")

set(Interrupt_default_library_list )


add_executable(Interrupt_default_image_Da8imNQh ${Interrupt_default_library_list})

set_target_properties(Interrupt_default_image_Da8imNQh PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${Interrupt_default_output_dir})
set_target_properties(Interrupt_default_image_Da8imNQh PROPERTIES OUTPUT_NAME "default")
set_target_properties(Interrupt_default_image_Da8imNQh PROPERTIES SUFFIX ".elf")
         




# Add the link options from the rule file.
Interrupt_default_link_rule(Interrupt_default_image_Da8imNQh)




