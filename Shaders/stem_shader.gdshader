shader_type spatial;

uniform float[3] xcurve;
uniform float[3] zcurve;
uniform float height;
uniform float startRadius;
uniform float endRadius;

float getXCurve(float y){
	return (sin(y * xcurve[0]) + sin(y * xcurve[1]) + sin(y * xcurve[2])) * 0.1;
}

float getZCurve(float y){
	return (sin(y * zcurve[0]) + sin(y * zcurve[1]) + sin(y * zcurve[2])) * 0.1;
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
	VERTEX.y = (VERTEX.y + 0.5) * height;
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
