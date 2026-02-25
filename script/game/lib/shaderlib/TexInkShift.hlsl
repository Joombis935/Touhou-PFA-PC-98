//Perlin shader for shifting-ink texture in music room
//Thanks Sheck for help :)
sampler sampler0_ : register(s0);

static const float TAU = 6.28318530718;
float time_;

struct PS_INPUT{
    float4 diffuse : COLOR0;
    float2 texCoord : TEXCOORD0;
};

float4 PsPerlin(PS_INPUT v) : COLOR0{
    float2 offset1 = tex2D(sampler0_, v.texCoord + float2(time_ / 6.0f, -time_ / 5.0f)).rg;
    float4 color1 = tex2D(sampler0_, v.texCoord + offset1 * 0.1f);

    float4 color = 1.0f - color1;
    color = 1.0f - color;

    color.a = smoothstep(0.7f - v.diffuse.a, 0.8f - v.diffuse.a, (color.r + color.g + color.b) / 3.0f);

    return color * v.diffuse;
}

technique Render{
    pass p0{
        PixelShader = compile ps_2_0 PsPerlin();
    }
}