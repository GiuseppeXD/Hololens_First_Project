Texture2D ObjTexture;
SamplerState ObjSamplerState;

struct PixelShaderInput
{
    float4 pos     : SV_POSITION;

    // The render target array index will be set by the geometry shader.
    //float3 color : COLOR0;
    float2 texCoord : TEXCOORD0;
};

float4 main(PixelShaderInput input) : SV_TARGET
{
	return ObjTexture.Sample(ObjSamplerState, input.texCoord);
    //return float4(0.5f,0.5f,0.5f,0.5f);
}