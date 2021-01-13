// A constant buffer that stores the model transform.
cbuffer ModelConstantBuffer : register(b0)
{
    float4x4 model;
};

// A constant buffer that stores each set of view and projection matrices in column-major format.
cbuffer ViewProjectionConstantBuffer : register(b1)
{
    float4x4 viewProjection[2];
};

struct VertexShaderOutput
{
    float4 pos     : SV_POSITION;
    //uint   viewId  : TEXCOORD0;
    float2 texCoord : TEXCOORD0;
    //float3 color : COLOR0;
};

struct VertexShaderInput
{
    float3 pos     : POSITION;
    float2 texCoord : TEXCOORD0;
    //float3 color : COLOR0;
    //uint   instId  : SV_InstanceID;
};

VertexShaderOutput main(VertexShaderInput input)
{
    VertexShaderOutput output;

    output.pos = float4(input.pos, 1.0f);
    output.texCoord = input.texCoord;
    //output.color = input.color;

    return output;
}