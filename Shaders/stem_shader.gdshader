shader_type spatial;

uniform float xa;
uniform float xb;
uniform float xc;
uniform float za;
uniform float zb;
uniform float zc;
uniform float height;
uniform float startRadius;
uniform float endRadius;

float getXCurve(float y){
	return (sin(y * xa) + sin(y * xb) + sin(y * xc)) * 0.1;
}

float getZCurve(float y){
	return (sin(y * za) + sin(y * zb) + sin(y * zc)) * 0.1;
}

vec2 adjustForNewRadius(vec3 vertex) {
	float oldRadius = length(vertex.xz);
	float xRatio = vertex.x / oldRadius;
	float zRatio = vertex.z / oldRadius;
	float newRadius = mix(startRadius, endRadius, vertex.y / height);
	return vec2(xRatio * newRadius, zRatio * newRadius);
}

void vertex() {
	// Called for every vertex the material is visible on.
	VERTEX.y += height / 2.0;
	VERTEX.xz = adjustForNewRadius(VERTEX);
	VERTEX.x += getXCurve(VERTEX.y);
	VERTEX.z += getZCurve(VERTEX.y);
}

void fragment() {
	// Called for every pixel the material is visible on.
	ALBEDO = vec3(0.0, 1.0, 0.0);
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
