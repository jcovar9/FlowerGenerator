shader_type spatial;

float getBottomCurve(float yValue){
	float retValue = 0.0;
	return retValue;
}

void vertex() {
	// Called for every vertex the material is visible on.
	VERTEX.y += 0.5;
	if(VERTEX.y < 0.5){
		VERTEX.x += sin(VERTEX.y * 20.0);
		//if(VERTEX.x == 0.0){
			//
		//}else{
			//if(VERTEX.x < 0.0){
				//VERTEX.x *= VERTEX.y;
			//}else{
				//VERTEX.x *= VERTEX.y;
			//}
		//}
	}
	
}

void fragment() {
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
