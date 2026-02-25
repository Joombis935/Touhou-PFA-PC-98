//Shader for changing pixel colors to white
sampler sampler0_ : register(s0);

float enable;

struct PS_INPUT {
    float4 diffuse : COLOR0;  
    float2 texCoord : TEXCOORD0;
};

float4 PsWhite(PS_INPUT input) : COLOR0 {
    float4 color = tex2D(sampler0_, input.texCoord);
    
    color.rgb = lerp(color.rgb, (float3)1, enable);
    
    return color * input.diffuse;
}

technique Render {
    pass P0 {
        PixelShader = compile ps_2_0 PsWhite();
    }
}