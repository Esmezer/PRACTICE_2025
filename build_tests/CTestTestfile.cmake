# CMake generated Testfile for 
# Source directory: /app
# Build directory: /app/build_tests
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(DrogonApiUnitTests "/app/build_tests/drogon_api_tests")
set_tests_properties(DrogonApiUnitTests PROPERTIES  _BACKTRACE_TRIPLES "/app/CMakeLists.txt;56;add_test;/app/CMakeLists.txt;0;")
subdirs("googletest")
