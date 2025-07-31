shader_type canvas_item;
uniform vec4 color : source_color = vec4(1);
uniform float disp : hint_range(0, 1) = .5;
uniform float emission : hint_range(0, 20) = 1;
uniform sampler2D displacement : repeat_disable, filter_nearest;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;


void fragment() {
    vec2 uv = SCREEN_UV;
    float t = TIME * .75;
    vec2 tuv = vec2(sin(t), cos(t)) * .05;
    vec2 ouv = texture(displacement, uv + tuv).rg * .1 * disp;
    vec4 refracted_color = textureLod(screen_texture, uv + ouv, 0.0);
    vec4 c = mix(color, refracted_color, .2);
	COLOR = c;
}
