#if !defined INCLUDE_UTILITY_FAST_MATH
#define INCLUDE_UTILITY_FAST_MATH

// Faster alternative to acos
// Source: https://seblagarde.wordpress.com/2014/12/01/inverse-trigonometric-functions-gpu-optimization-for-amd-gcn-architecture/#more-3316
// Max relative error: 3.9 * 10^-4
// Max absolute error: 6.1 * 10^-4
// Polynomial degree: 2
float fast_acos(float x) {
	const float C0 = 1.57018;
	const float C1 = -0.201877;
	const float C2 = 0.0464619;

	float res = (C2 * abs(x) + C1) * abs(x) + C0; // p(x)
	res *= sqrt(1.0 - abs(x));

	return x >= 0 ? res : pi - res; // Undo range reduction
}
vec2 fast_acos(vec2 v) { return vec2(fast_acos(v.x), fast_acos(v.y)); }

float pow4(float x) { return sqr(sqr(x)); }
float pow5(float x) { return pow4(x) * x; }
float pow6(float x) { return sqr(cube(x)); }
float pow7(float x) { return pow6(x) * x; }
float pow8(float x) { return sqr(pow4(x)); }

float pow12(float x) {
	return cube(pow4(x));
}

float pow16(float x) {
	x *= x;
	x *= x;
	x *= x;
	x *= x;
	return x;
}

float pow32(float x) {
	x *= x;
	x *= x;
	x *= x;
	x *= x;
	x *= x;
	return x;
}

float pow64(float x) {
	x *= x;
	x *= x;
	x *= x;
	x *= x;
	x *= x;
	x *= x;
	return x;
}

float pow128(float x) {
	x *= x;
	x *= x;
	x *= x;
	x *= x;
	x *= x;
	x *= x;
	x *= x;
	return x;
}

float pow1d5(float x) {
	return x * sqrt(x);
}

float rcp_length(vec2 v) { return inversesqrt(dot(v, v)); }
float rcp_length(vec3 v) { return inversesqrt(dot(v, v)); }

// Computes the length of a vector and normalizes it using one inversesqrt
void length_normalize(vec3 v, out vec3 normalized, out float len) {
	float len_sq = length_squared(v);
	float rcp_len = inversesqrt(len_sq);
	len = len_sq * rcp_len;
	normalized = rcp_len * v;
}

#endif // INCLUDE_UTILITY_FAST_MATH
