// A constant buffer that stores the model transform.
cbuffer ModelConstantBuffer : register(b0)
{
    float4x4 model;
    float4 eye;
};

// A constant buffer that stores each set of view and projection matrices in column-major format.
cbuffer ViewProjectionConstantBuffer : register(b1)
{
    float4x4 viewProjection[2];
};

cbuffer EyeBuffer : register(b2)
{
    float4 eyeBuffer;
};

// Per-vertex data used as input to the vertex shader.
struct VertexShaderInput
{
    float3 pos     : POSITION;
    float3 texCoord: TEXCOORD0;
    uint   instId  : SV_InstanceID;
};

// Simple shader to do vertex processing on the GPU.
VertexShaderOutput main(VertexShaderInput input)
{
    VertexShaderOutput output;
    float4 pos = float4(input.pos, 1.0f);
    

    // Note which view this vertex has been sent to. Used for matrix lookup.
    // Taking the modulo of the instance ID allows geometry instancing to be used
    // along with stereo instanced drawing; in that case, two copies of each 
    // instance would be drawn, one for left and one for right.
    int idx = input.instId % 2;

    // Transform the vertex position into world space.
    pos = mul(pos, model);
    output.posModel = pos.xyz;

    // Correct for perspective and project the vertex position onto the screen.
    pos = mul(pos, viewProjection[idx]);
    output.pos = (float4)pos;
    output.posEye = eye.xyz;

    // Pass the color through without modification.
    output.texCoord = input.texCoord;

    // Set the render target array index.
    output.viewId = idx;

    return output;
}
