#version 430 core

layout(location = 0) in vec3 vertexPosition;
layout(location = 1) in vec2 vertexTexCoord;
layout(location = 2) in vec3 vertexNormal;

uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelMatrix;
uniform mat4 perspectiveMatrix;
uniform float fogDensity;
uniform float fogGradient;

out vec3 interpNormal;
out float visibility;

void main()
{
	vec4 worldPosition = modelViewProjectionMatrix * vec4(vertexPosition, 1.0);

	gl_Position = worldPosition;
	interpNormal = (modelMatrix * vec4(vertexNormal, 0.0)).xyz;

	vec4 positionRelativeToCamera = perspectiveMatrix * worldPosition;
	float distanceFromCamera = length(positionRelativeToCamera.xyz);
	visibility = exp(-pow((distanceFromCamera * fogDensity), fogGradient));
	visibility = clamp(visibility, 0.0, 1.0);
}
