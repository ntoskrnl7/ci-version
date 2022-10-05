cmake_minimum_required(VERSION 3.13)

project(test C)

add_executable(test main.c)

target_include_directories(test PRIVATE ../include)
target_include_directories(test PRIVATE ${CI_VERSION_PATH})