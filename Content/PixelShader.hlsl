Texture3D ObjTexture;
SamplerState ObjSamplerState;

// Per-pixel color data passed through the pixel shader.
struct PixelShaderInput
{
    float4 pos   : SV_POSITION;
    float3 posModel : POSITION;
    float3 posEye : POSITION1;
    float3 texCoord: TEXCOORD0;
};

#define NUM_STEPS 100

float4 Max_intensity(PixelShaderInput i)
{
    const float stepSize = 1.7f / NUM_STEPS;

    float3 rayStartPos = float3(i.texCoord);

    float3 posWorld = i.posModel;
    float3 posEye = i.posEye;
    float3 rayDir = posEye - posWorld;
    rayDir = normalize(rayDir);

    float maxDensity = 0.0f;
    float3 currPos;
    float4 col = float4(0.0f, 0.0f, 0.0f, 0.0f);
    for (uint iStep = 0; iStep < NUM_STEPS; iStep++)
    {
        // 100 steps, step size 0.14f / 100;
        currPos = rayStartPos + rayDir * iStep * stepSize;

        // Stop when we are outside the box
        if (currPos.x < 0.0f || currPos.x > 1.0f || currPos.y < 0.0f || currPos.y > 1.0f || currPos.z < 0.0f || currPos.z > 1.0f) {
            break;
        }

        float density = ObjTexture.Sample(ObjSamplerState, float3(1.f - currPos.x, 1.f - currPos.y, 1.f - currPos.z));

        if (density > 0.1 && density < 1.0)
            maxDensity = max(density, maxDensity);

        float4 src = float4(density, density, density, density * 0.1f);

        col.rgb = src.a * src.rgb + (1.0f - src.a) * col.rgb;
        col.a = src.a + (1.0f - src.a) * col.a;

        if (col.a > 1.0f)
            break;
    }

    return col;
}

// The pixel shader passes through the color data. The color data from 
// is interpolated and assigned to a pixel at the rasterization step.
float4 main(PixelShaderInput input) : SV_TARGET
{
    return Max_intensity(input);
}
