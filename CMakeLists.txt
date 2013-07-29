cmake_minimum_required (VERSION 2.8)


project(exoraw)


if(${CMAKE_BUILD_TOOL} MATCHES "(msdev|VCExpress|devenv|nmake)")
	# Do not show msvs security warnings about unsafe functions.
	add_definitions(-D_CRT_SECURE_NO_WARNINGS)
	add_definitions(-D_CRT_SECURE_NO_DEPRECATE)
ENDIF(${CMAKE_BUILD_TOOL} MATCHES "(msdev|VCExpress|devenv|nmake)")


#----------------------------------------------------------------------------
#
# Build the RAM disk library.
#

set(SOURCES_exoraw
	src/chunkpool.c
	src/exo_helper.c
	src/exo_raw.c
	src/exo_util.c
	src/exodec.c
	src/getflag.c
	src/log.c
	src/match.c
	src/membuf.c
	src/membuf_io.c
	src/optimal.c
	src/output.c
	src/progress.c
	src/radix.c
	src/search.c
)

add_executable(TARGET_exoraw ${SOURCES_exoraw})
set_property(TARGET TARGET_exoraw PROPERTY OUTPUT_NAME "exoraw")

#----------------------------------------------------------------------------
#
# Build the distribution.
#

SET(CPACK_PACKAGE_VERSION_MAJOR "2")
SET(CPACK_PACKAGE_VERSION_MINOR "0")
SET(CPACK_PACKAGE_VERSION_PATCH "7")

STRING(TOLOWER ${CMAKE_SYSTEM_NAME} POM_ID_OS)
IF(NOT DEFINED TARGET_PROCESSOR)
	SET(TARGET_PROCESSOR ${CMAKE_SYSTEM_PROCESSOR})
ENDIF(NOT DEFINED TARGET_PROCESSOR)
SET(POM_ID_PROCESSOR ${TARGET_PROCESSOR})
SET(POM_VERSION ${CPACK_PACKAGE_VERSION_MAJOR}.${CPACK_PACKAGE_VERSION_MINOR}.${CPACK_PACKAGE_VERSION_PATCH})
STRING(REPLACE . _ POM_ID_VERSION ${POM_VERSION})
SET(POM_MBS_RELEASE_VERSION 1)

SET(CPACK_INCLUDE_TOPLEVEL_DIRECTORY FALSE)
SET(CPACK_PACKAGE_FILE_NAME ${PROJECT_NAME}_${POM_ID_OS}_${POM_ID_PROCESSOR}-${POM_VERSION}_${POM_MBS_RELEASE_VERSION})

SET(CPACK_GENERATOR "TBZ2")
INCLUDE(CPack)

# Build the POM file.
CONFIGURE_FILE(templates/exoraw.pom ${PROJECT_NAME}_${POM_ID_OS}_${POM_ID_PROCESSOR}-${POM_VERSION}_${POM_MBS_RELEASE_VERSION}.pom)

# Build the python file.
CONFIGURE_FILE(templates/exoraw.py ${PROJECT_NAME}_${POM_ID_OS}_${POM_ID_PROCESSOR}-${POM_VERSION}_${POM_MBS_RELEASE_VERSION}.py)

INSTALL(TARGETS TARGET_exoraw
        RUNTIME DESTINATION ${PROJECT_NAME}-${POM_VERSION}_${POM_MBS_RELEASE_VERSION}
)
INSTALL(FILES templates/exoraw.py
        DESTINATION .)

#----------------------------------------------------------------------------

