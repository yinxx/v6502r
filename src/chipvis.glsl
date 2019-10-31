//------------------------------------------------------------------------------
//  chipvis.glsl
//  Shader for rendering the chip visualization.
//------------------------------------------------------------------------------
@ctype vec4 float4_t
@ctype vec2 float2_t

@vs vs
uniform vs_params {
    vec4 color0;
    vec2 half_size;
    vec2 offset;
    vec2 scale;
};
uniform sampler2D palette_tex;
in vec2 pos;
in vec2 uv;
out vec4 color;

void main() {
    vec2 p = (pos - half_size) + offset;
    p *= scale;
    gl_Position = vec4(p, 0.5, 1.0);
    float u = (uv.x + 0.5f) / 2048.0;
    float r = texture(palette_tex, vec2(u, 0.5)).r;
    color = vec4(color0.xyz, ((r < 0.5) ? 0.25 : 1.0));
}
@end

@fs fs
in vec4 color;
out vec4 frag_color;

void main() {
    frag_color = color;
}
@end

@program chipvis vs fs
