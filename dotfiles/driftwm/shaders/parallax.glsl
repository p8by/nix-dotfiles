// Mirrored Parallax — tiles an image across the canvas with a parallax depth effect
// that responds to camera movement. It uses a mirrored repeat (kaleidoscope) technique
// to eliminate harsh seams, making the texture tile infinitely and smoothly.
//
// Zoom behavior:
//   - At FIT_ZOOM (or lower), the full image fits the monitor.
//   - When you zoom in, the image zooms in too.
//
//     [background]
//     type = "shader"
//     path = "~/.config/driftwm/wallpapers/mirrored_parallax.glsl"
//     texture = "~/Pictures/your_image.png"

precision highp float; // Set high precision for floating-point calculations to prevent jittering

// Inputs from driftwm
varying vec2 v_coords;         // Normalized screen coordinates from the vertex shader (0.0 to 1.0)
uniform sampler2D tex;         // The background texture image

uniform vec2 u_camera;         // Top-left corner of the viewport in canvas pixels
uniform vec2 u_output_size;    // Viewport size in canvas pixels (monitor size / zoom)
uniform vec2 u_texture_size;   // Dimensions of the source texture in pixels
uniform float u_zoom;          // Canvas to screen scale (1.0 = no zoom)

// The zoom level where the full image fits the monitor.
const float FIT_ZOOM = 0.25;

// Parallax intensity: lower values make the background appear further away
const float PARALLAX_FACTOR = 0.15;

void main() {
    vec2 screen_size = u_output_size * u_zoom;

    float fit_scale = max(screen_size.x / u_texture_size.x,
                          screen_size.y / u_texture_size.y);
    vec2 fit_tile_screen = u_texture_size * fit_scale;

    vec2 tile_canvas = fit_tile_screen / FIT_ZOOM;

    float eff_zoom = max(u_zoom, FIT_ZOOM);

    vec2 canvas_center = u_camera + 0.5 * u_output_size;

    vec2 wrapped_center = mod(canvas_center * PARALLAX_FACTOR + 0.5 * tile_canvas, tile_canvas * 2.0);

    vec2 from_center = (v_coords - 0.5) * screen_size / eff_zoom;

    vec2 tile_uv = (from_center + wrapped_center) / tile_canvas;

    vec2 mirrored_uv = 1.0 - abs(mod(tile_uv, 2.0) - 1.0);

    gl_FragColor = vec4(texture2D(tex, mirrored_uv).rgb, 1.0);
}
