//A shader for the title-logo sine effect
sampler sampler0_ : register(s0);

float WIDTH;
float STEP;
float MUL;

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

PS_OUTPUT PSSine (PS_INPUT In) : COLOR0
{
	PS_OUTPUT Out;

	float2 texUV = In.texCoord;
	float2 texVPOS = In.vPos;
	texUV.x += sin(STEP + texUV.y * MUL) * WIDTH;
	//texUV.y += sin(STEP + texUV.x * MUL) * WIDTH;
	Out.color = tex2D(sampler0_, texUV);
	Out.color.rgba *= In.diffuse;
	return Out;
}

technique Render
{
	pass P0
	{
		PixelShader = compile ps_3_0 PSSine();
	}
}