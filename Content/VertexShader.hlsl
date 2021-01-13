// Per-vertex data passed to the geometry shader.
struct VertexShaderOutput
{
    float4 pos     : SV_POSITION;

    //float3 color   : COLOR0;

    float2 texCoord     : TEXCOORD0;

    // The render target array index will be set by the geometry shader.
    uint   viewId  : TEXCOORD1;
};

#include "VertexShaderShared.hlsl"
