//A shader for making the boss invincibility effect
sampler sampler0_ : register(s0);

//X variables
float X_LOW;
float Y_LOW;
float X_HIGH;
float Y_HIGH;
float DEST_X;
float DEST_Y;
float TEX_X;
float TEX_Y;
//Dither
float STEP;

struct PS_INPUT
{
	float4 diffuse : COLOR0;
	float2 texCoord : TEXCOORD0;
    float2 vPos : VPOS;
};

struct PS_OUTPUT
{
    float4 color : COLOR0; 
};

PS_OUTPUT PSRect (PS_INPUT In) : COLOR0
{
	PS_OUTPUT Out;

	float2 texUV = In.texCoord;
    //Setting shader bounds
    float2 minUV = float2(X_LOW, Y_LOW);
    float2 maxUV = float2(X_HIGH, Y_HIGH);
    float2 destUV = float2(DEST_X, DEST_Y);
    float2 pathUV = float2(TEX_X, TEX_Y);
    float2 dUV = maxUV - minUV;
    float2 wrapUV = minUV + frac(texUV * (pathUV / destUV)) * dUV; 
    
    //Dithering the new coordinates
    float2 posUV = In.vPos;
    Out.color = tex2D(sampler0_, wrapUV) * In.diffuse;
    Out.color.a = lerp(Out.color.a, 0, (posUV.x + posUV.y) % STEP != 0);
	return Out;
}

technique Render
{
	pass P0
	{
		PixelShader = compile ps_3_0 PSRect();
	}
}