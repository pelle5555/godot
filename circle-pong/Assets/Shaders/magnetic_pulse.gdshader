shader_type canvas_item;

uniform float speed = 1.0;
uniform float wave_width = 0.2;
uniform float intensity = 1.0;
uniform vec4 pulse_color : source_color = vec4(0.2, 0.8, 1.0, 1.0); // cyan blue

void fragment() {
    float time_offset = TIME * speed;

    // Normalize coordinates (0 to 1)
    vec2 uv = UV;

    // Animate a wave moving vertically
    float wave = sin((-uv.x + time_offset) * 5.0) * 0.5 + 0.5;

    // Create a soft vertical band (x-axis) as the pulse center
    float pulse = smoothstep(0.5 - wave_width, 0.5, uv.x) * (1.0 - smoothstep(0.5, 0.5 + wave_width, uv.x));

    // Multiply wave and pulse for the full effect
    float alpha = wave * pulse * intensity;

    COLOR = pulse_color * alpha;
}