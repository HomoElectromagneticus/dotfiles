float Random(in vec2 st)
{
    return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    // normalised pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord / iResolution.xy;
    
    // aspect ratio
    vec2 st = uv;
    vec2 aspect = iResolution.xy / min(iResolution.x, iResolution.y);
    st *= aspect;
    
    // noise generation
    float r = Random(st + iTime * 0.00000005);
    
    // Output to screen
    fragColor = texture(iChannel0, uv);
    // control how much noise is mixed in -------v
    fragColor.rgb = mix(fragColor.rgb, vec3(r), 0.065);
}
