cmake_minimum_required(VERSION 3.13)

project(test C)

add_executable(test main.c)

include(ci-version.cmake)
ci_version(test)