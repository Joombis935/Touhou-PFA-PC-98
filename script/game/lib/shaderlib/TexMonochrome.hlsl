//Shader for converting the pixel values of an image to greyscale values
sampler sampler0_ : register(s0);

float enable;

struct PS_INPUT{
    float4 diffuse : COLOR0;
    float2 texCoord : TEXCOORD0;
};

float4 PsMonochrome(PS_INPUT v) : COLOR0{
    float4 color = tex2D(sampler0_, v.texCoord);
    color.rgb = lerp(color.rgb, (color.r +color.g +color.b)/3, enable)*1.25;
    return color.rgba*v.diffuse;
}

technique Render{
    pass p0{
        PixelShader = compile ps_2_0 PsMonochrome();
    }
}