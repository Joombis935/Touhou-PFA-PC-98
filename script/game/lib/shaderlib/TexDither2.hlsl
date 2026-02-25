//A variation of TexDither1
//Sprite becomes less transparent as STEP increases
sampler sampler0_ : register(s0);

float enable;
float STEP;

struct PS_INPUT{
    float4 diffuse : COLOR0;
    float2 texCoord : TEXCOORD0;
    float2 vPos : VPOS;
};

struct PS_OUTPUT{
    float4 color : COLOR0;
};

PS_OUTPUT PsDither1 (PS_INPUT In) : COLOR0 {
    PS_OUTPUT Out;

    float2 texUV = In.texCoord;
    float2 posUV = In.vPos;
    Out.color = tex2D(sampler0_, texUV) * In.diffuse;
    Out.color.a = lerp(Out.color.a, 0, (posUV.x + posUV.y) % STEP == 0 && enable);

    return Out;
}

technique Render
{
    pass p0
    {
        PixelShader = compile ps_3_0 PsDither1();
    }
}