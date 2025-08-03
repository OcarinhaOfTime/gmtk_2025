shader_type canvas_item;
uniform vec4 color : source_color = vec4(1);

void fragment() {
	vec4 tex_color = texture(TEXTURE, UV);
	COLOR = tex_color * color;
}
