#if !defined INCLUDE_LIGHT_LPV_BLOCKLIGHT
#define INCLUDE_LIGHT_LPV_BLOCKLIGHT

#include "voxelization.glsl"

vec3 read_lpv_linear(vec3 pos) {
	if ((frameCounter & 1) == 0) {
		return texture(light_sampler_a, pos).rgb;
	} else {
		return texture(light_sampler_b, pos).rgb;
	}
}

float lpv_distance_fade(vec3 scene_pos) {
	float distance_fade  = 2.0 * max_of(abs(scene_pos / vec3(voxel_volume_size)));
		  distance_fade  = linear_step(0.75, 1.0, distance_fade);

	return distance_fade;
}

vec3 get_lpv_blocklight(vec3 scene_pos, vec3 normal, vec3 mc_blocklight, float ao) {
	vec3 voxel_pos = scene_to_voxel_space(scene_pos);

	if (is_inside_voxel_volume(voxel_pos)) {
#ifndef NO_NORMAL
		vec3 sample_pos = clamp01((voxel_pos + normal * 0.5) / vec3(voxel_volume_size));
		vec3 lpv_blocklight = sqrt(read_lpv_linear(sample_pos)) * ao;
#else
		vec3 sample_pos = clamp01(voxel_pos / vec3(voxel_volume_size));
		vec3 lpv_blocklight = sqrt(read_lpv_linear(sample_pos));
#endif

		float distance_fade = lpv_distance_fade(scene_pos);

		return mix(lpv_blocklight, mc_blocklight, distance_fade);
	} else {
		return mc_blocklight;
	}
}

#endif // INCLUDE_LIGHT_LPV_BLOCKLIGHT
