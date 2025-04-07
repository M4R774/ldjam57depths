shader_type canvas_item;

uniform float strength : hint_range(1, 512) = 0;
uniform int sample_count : hint_range(1, 64) = 1;

// Pseudo-random number generator
float rand(vec2 uv) {
    return fract(sin(dot(uv.xy,
        vec2(12.9898, 78.233))) * 43758.5453123);
}

vec4 blur_random(sampler2D tex, vec2 uv, vec2 pixelSize) {
    vec4 color = vec4(0.0);

    float time_offset = TIME * 0.1; // Control how fast blur randomness changes

    for (int i = 0; i < sample_count; i++) {
        float x = rand(uv + float(i) + time_offset) - 0.5;
        float y = rand(uv + float(i) + 1.2345 + time_offset) - 0.5;
        vec2 offset = vec2(x, y) * strength * pixelSize;
        color += texture(tex, uv + offset);
    }

    return color / float(sample_count);
}

void fragment() {
    COLOR = blur_random(TEXTURE, UV, TEXTURE_PIXEL_SIZE);
}
