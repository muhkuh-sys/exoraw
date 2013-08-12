# -*- coding: utf-8 -*-

import SCons.Node.FS
import SCons.Scanner

import os.path


def exoraw_emitter(target, source, env):
	env.Depends(target, env['EXORAW'])
	return (target, source)


def ApplyToEnv(env):
	strVersion = '${POM_VERSION}'
	strMbsRelease = '${POM_MBS_RELEASE_VERSION}'
	
	
	#----------------------------------------------------------------------------
	#
	# Add exoraw builder.
	#
	env['EXORAW'] = os.path.join( os.path.dirname(os.path.realpath(__file__)), 'exoraw-%s_%s'%(strVersion,strMbsRelease), 'exoraw' )
	env['EXORAWFLAGS']  = ['-b', '-q']
	env['EXORAWCOM']    = '"$EXORAW" $EXORAWFLAGS -o $TARGET $SOURCES'
	env['EXORAWCOMSTR'] = 'Exoraw $TARGET'
	env['EXORAWSUFFIX'] = '.exo'
	
	exoraw_act = SCons.Action.Action('$EXORAWCOM', '$EXORAWCOMSTR')
	exoraw_bld = SCons.Builder.Builder(action = exoraw_act,
	                                   emitter = exoraw_emitter,
	                                   suffix = '$EXORAWSUFFIX',
	                                   single_source = 1)
	env['BUILDERS']['Exoraw'] = exoraw_bld
