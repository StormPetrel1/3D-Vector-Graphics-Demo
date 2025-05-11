
#ifdef VERTEX
// max FOV: 45.0 / 64.0
uniform float fov = 9.0 / 16.0;
uniform vec3 look = vec3(0.0, 0.0, 1.0);
uniform vec3 origin = vec3(0.0);

vec4 position(mat4 transformProjection, vec4 vertexPosition){
	vec3 axisHorizon = normalize(cross(look, vec3(0.0, 1.0, 0.0)));
	vec3 axisVertical = normalize(cross(axisHorizon, look));
	vec3 relative = vertexPosition.xyz - origin;
	
	// inverse length of relative
	float closeness = inversesqrt(dot(relative, relative));
	vec3 direction = normalize(relative);
	
	float x = dot(direction, axisHorizon);
	float y = dot(direction, axisVertical);
	float z = dot(direction, look);
	
	// x, y, and z must be between -w and w (anything outside clipped)
	return vec4(
		// old clipping algorithm (x): abs(sign(z) - 1.0 + x) * sign(x)
		x,
		y,
		// stupid hack to normalize depth and clip scenery behind you
		-closeness + sign(z) * fov,
		fov
	);
}
#endif

#ifdef PIXEL
vec4 effect(vec4 color, Image tex, vec2 textureCoords, vec2 screenCoords){
	vec4 texColor = Texel(tex, textureCoords);
	vec4 mixColor = texColor * color;
	return mixColor;
}
#endif
