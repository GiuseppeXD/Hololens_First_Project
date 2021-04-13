Texture3D ObjTexture;
SamplerState ObjSamplerState;

// Per-pixel color data passed through the pixel shader.
struct PixelShaderInput
{
    float4 pos   : SV_POSITION;
    float3 texCoord: TEXCOORD0;
};

// The pixel shader passes through the color data. The color data from 
// is interpolated and assigned to a pixel at the rasterization step.
float4 main(PixelShaderInput input) : SV_TARGET
{
    float luminancia = ObjTexture.Sample(ObjSamplerState, input.texCoord);
    return float4(luminancia, luminancia, luminancia, luminancia);
}
