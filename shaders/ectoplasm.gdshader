shader_type canvas_item;
uniform vec4 color : source_color = vec4(1);
uniform float disp : hint_range(0, 1) = .5;
uniform float emission : hint_range(0, 20) = 1;
uniform sampler2D displacement;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

varying vec3 world_position;


void vertex() {
    world_position = (MODEL_MATRIX * vec4(VERTEX, 1.0, 1.0)).xyz * 0.005;
}


void fragment() {
    vec2 uv = SCREEN_UV;
    vec2 wuv = world_position.xy; 
    float t = TIME * 0.5;
    vec2 tuv = vec2(sin(t), cos(t)) * .3;
    vec2 ouv = texture(displacement, fract(wuv + tuv)).rg - .5;
    ouv = ouv * .1 * disp;
    vec4 refracted_color = textureLod(screen_texture, uv + ouv, 0.0);
    vec4 c = mix(color, refracted_color, .2);
	COLOR = c;
}
