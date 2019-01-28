# Copyright 2017 MongoDB Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set (MONGOC_STATIC_MAJOR_VERSION 0)
set (MONGOC_STATIC_MINOR_VERSION 0)
set (MONGOC_STATIC_MICRO_VERSION 0)
set (MONGOC_STATIC_VERSION 0.0.0)

find_package (libbson-static-1.0 "0.0" REQUIRED)


####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was libmongoc-static-1.0-config.cmake.in                            ########

get_filename_component(PACKAGE_PREFIX_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../" ABSOLUTE)

macro(set_and_check _var _file)
  set(${_var} "${_file}")
  if(NOT EXISTS "${_file}")
    message(FATAL_ERROR "File or directory ${_file} referenced by variable ${_var} does not exist !")
  endif()
endmacro()

macro(check_required_components _NAME)
  foreach(comp ${${_NAME}_FIND_COMPONENTS})
    if(NOT ${_NAME}_${comp}_FOUND)
      if(${_NAME}_FIND_REQUIRED_${comp})
        set(${_NAME}_FOUND FALSE)
      endif()
    endif()
  endforeach()
endmacro()

####################################################################################

set_and_check (MONGOC_STATIC_INCLUDE_DIRS "${PACKAGE_PREFIX_DIR}/include/libmongoc-1.0")
list (APPEND MONGOC_STATIC_INCLUDE_DIRS ${BSON_STATIC_INCLUDE_DIRS})

# We want to provide an absolute path to the library and we know the
# directory and the base name, but not the suffix, so we use CMake's
# find_library () to pick that up.  Users can override this by configuring
# MONGOC_STATIC_LIBRARY themselves.
find_library (MONGOC_STATIC_LIBRARY mongoc-static-1.0 PATHS "${PACKAGE_PREFIX_DIR}/lib" NO_DEFAULT_PATH)
if (MSVC)
   set (MONGOC_STATIC_LIB_EXT "lib")
else ()
   set (MONGOC_STATIC_LIB_EXT "a")
endif ()
set (MONGOC_STATIC_LIBRARIES ${MONGOC_STATIC_LIBRARY} ${ZLIB_STATIC_LIBRARY} ${BSON_STATIC_LIBRARIES})

# If this file is generated by the Autotools on Mac, SSL_LIBRARIES might be
# "-framework CoreFoundation -framework Security". Split into a CMake array
# like "-framework CoreFoundation;-framework Security".
set (IS_FRAMEWORK_VAR 0)
foreach (LIB /usr/lib/x86_64-linux-gnu/libsasl2.so /usr/lib/x86_64-linux-gnu/libssl.so;/usr/lib/x86_64-linux-gnu/libcrypto.so rt /usr/lib/x86_64-linux-gnu/libz.so
    resolv /usr/lib/x86_64-linux-gnu/libicuuc.so
)
   if (LIB STREQUAL "-framework")
      set (IS_FRAMEWORK_VAR 1)
      continue ()
   elseif (IS_FRAMEWORK_VAR)
      list (APPEND MONGOC_STATIC_LIBRARIES "-framework ${LIB}")
      set (IS_FRAMEWORK_VAR 0)
   else ()
      list (APPEND MONGOC_STATIC_LIBRARIES ${LIB})
   endif ()
endforeach ()

set (MONGOC_STATIC_DEFINITIONS MONGOC_STATIC ${BSON_STATIC_DEFINITIONS})
