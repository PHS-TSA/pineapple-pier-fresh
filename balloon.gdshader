shader_type spatial;

// Noise function for random generation
float noise(vec2 input){
	return fract(sin(dot(input, vec2(12.25, 10.356)) * 23.12) * 5054.52);
}

// Random color generation
vec3 random_color(vec3 seed) {
	float r = noise(seed.xy);
	float g = noise(seed.yz);
	float b = noise(seed.zx);
	return vec3(r, g, b);
}

// Using global coordinates for consistent color per object
uniform vec3 color_seed = vec3(0.0, 0.0, 0.0);
// Added parameter for base color
uniform vec3 base_color = vec3(1.0, 1.0, 1.0);
// Parameter to control whether to use random or custom color
uniform bool use_random_color = true;
vec3 object_color;

void vertex() {
	// Generate color once in vertex shader
	if (color_seed == vec3(0.0, 0.0, 0.0)) {
		// Use MODEL_MATRIX[3].xyz (object position) as seed
		object_color = random_color(MODEL_MATRIX[3].xyz);
	} else {
		object_color = random_color(color_seed);
	}
}

void fragment() {
	// Use either random color or the specified base_color
	ALBEDO = use_random_color ? object_color : base_color;
}

//void light() {
//    // Called for every pixel for every light affecting the material.
//    // Uncomment to replace the default light processing function with this one.
//}
