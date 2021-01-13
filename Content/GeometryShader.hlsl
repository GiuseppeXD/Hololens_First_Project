// Per-vertex data from the vertex shader.
struct GeometryShaderInput
{
    float4 pos     : SV_POSITION;
    float2 texCoord: TEXCOORD;
    //float3 color   : COLOR0;
    uint   instId  : TEXCOORD1;
};

// Per-vertex data passed to the rasterizer.
struct GeometryShaderOutput
{
    float4 pos     : SV_POSITION;
    //float3 color   : COLOR0;
    float2 texCoord: TEXCOORD;
    uint   rtvId   : SV_RenderTargetArrayIndex;
};

// This geometry shader is a pass-through that leaves the geometry unmodified 
// and sets the render target array index.
[maxvertexcount(3)]
void main(triangle GeometryShaderInput input[3], inout TriangleStream<GeometryShaderOutput> outStream)
{
    GeometryShaderOutput output;
    [unroll(3)]
    for (int i = 0; i < 3; ++i)
    {
        output.pos   = input[i].pos;
        output.texCoord = input[i].texCoord;
        //output.color = input[i].color;
        output.rtvId = input[i].instId;
        outStream.Append(output);
    }
}
