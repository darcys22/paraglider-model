cmake_minimum_required (VERSION 3.0)

project (app)

include_directories("${PROJECT_SOURCE_DIR}/include")

add_library(paraglider src/paraglider.cpp)

add_executable(app apps/app.cpp)

target_link_libraries(app paraglider)
