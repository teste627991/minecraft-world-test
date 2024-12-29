#version 400 compatibility

/*
--------------------------------------------------------------------------------

  Photon Shaders by SixthSurge

  world0/prepare.vsh:
  Render cloud shadow map

--------------------------------------------------------------------------------
*/

#include "/include/global.glsl"

out vec2 uv;

flat out vec2 clouds_cumulus_coverage;
flat out vec2 clouds_altocumulus_coverage;
flat out vec2 clouds_cirrus_coverage;
flat out float clouds_cumulus_congestus_amount;
flat out float clouds_stratus_amount;

// ------------
//   Uniforms
// ------------

uniform int worldTime;
uniform int worldDay;

uniform float rainStrength;
uniform float wetness;
uniform float sunAngle;

uniform int frameCounter;
uniform float frameTimeCounter;

uniform vec3 light_dir;
uniform vec3 sun_dir;
uniform vec3 moon_dir;

uniform float world_age;
uniform float eye_skylight;

uniform float time_sunrise;
uniform float time_noon;
uniform float time_sunset;
uniform float time_midnight;

uniform float biome_cave;
uniform float biome_temperate;
uniform float biome_arid;
uniform float biome_snowy;
uniform float biome_taiga;
uniform float biome_jungle;
uniform float biome_swamp;
uniform float biome_may_rain;
uniform float biome_may_snow;
uniform float biome_temperature;
uniform float biome_humidity;

#define PROGRAM_PREPARE
#define WEATHER_CLOUDS

#include "/include/misc/weather.glsl"

void main() {
	uv = gl_MultiTexCoord0.xy;

	clouds_weather_variation(
		clouds_cumulus_coverage,
		clouds_altocumulus_coverage,
		clouds_cirrus_coverage,
		clouds_cumulus_congestus_amount,
		clouds_stratus_amount
	);

	gl_Position = vec4(gl_Vertex.xy * 2.0 - 1.0, 0.0, 1.0);
}

#ifndef CLOUD_SHADOWS
#error "This program should be disabled if Cloud Shadows are disabled"
#endif
