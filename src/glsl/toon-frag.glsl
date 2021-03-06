
uniform sampler2D texture;
uniform int u_useTexture;
uniform vec3 u_albedo;
uniform vec3 u_ambient;
uniform vec3 u_lightPos;
uniform vec3 u_lightCol;
uniform float u_lightIntensity;

varying vec3 f_position;
varying vec3 f_normal;
varying vec2 f_uv;

void main() {
    vec4 color = vec4(u_albedo, 1.0);
    
    if (u_useTexture == 1) {
        color = texture2D(texture, f_uv);
    }

    float d = clamp(dot(f_normal, normalize(u_lightPos - f_position)), 0.0, 1.0);

    vec3 calcColor = d * color.rgb * u_lightCol * u_lightIntensity + u_ambient;
    float bin = 2.0;
    calcColor = (ceil((calcColor * bin)) - bin/3.0) / bin;

    vec3 look = (cameraPosition - f_position);
    if (dot(look, f_normal) < 0.5) {
    	calcColor = vec3( 1,1,1);
    }


    gl_FragColor = vec4(calcColor, 1.0);
}