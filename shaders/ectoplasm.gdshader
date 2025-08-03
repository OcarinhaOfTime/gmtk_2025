shader_type canvas_item;
uniform vec4 color : source_color = vec4(1);
uniform float disp : hint_range(0, 1) = .5;
//uniform float emission : hint_range(0, 20) = 1;
uniform sampler2D displacement;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

varying vec3 world_position;


void vertex() {
    world_position = (MODEL_MATRIX * vec4(VERTEX, 1.0, 1.0)).xyz * 0.005;
}

float ectofield(vec2 quv, vec2 kuv, float l){
    float inten = .12;
    float k = smoothstep(1.0, 1.0-l, quv.x + kuv.x * inten);
    k *= smoothstep(.0, l, quv.x + kuv.x * inten);
    k *= smoothstep(.0, l, quv.y + kuv.y * inten);
    k *= smoothstep(1.0, 1.0-l, quv.y + kuv.y * inten);

    return k;
}

void fragment() {
    vec2 quv = UV;
    vec2 uv = SCREEN_UV;
    vec2 wuv = world_position.xy; 
    float t = TIME * 0.5;
    vec2 tuv = vec2(sin(t), cos(t)) * .3;

    // waterlike stuff
    vec4 og_color = textureLod(screen_texture, uv, 0.0);
    vec2 ouv = texture(displacement, fract(wuv + tuv)).rg - .5;
    ouv = ouv * .05 * disp;
    vec4 refracted_color = textureLod(screen_texture, uv + ouv, 0.0);

    //border
    tuv = vec2(sin(t), cos(t)) * .15;
    float inten = .12;
    vec2 kuv = texture(displacement, fract(wuv + tuv + 666.60969696)).rg - .5;
    float k = ectofield(quv, kuv, .1);

    // distant field
    float rim = 1.0 - ectofield(quv, kuv, .3);
    vec4 c = mix(color * mix(1, 1.5, rim), refracted_color, .3);
    c = mix(og_color, c, k);

	COLOR = c;
}
