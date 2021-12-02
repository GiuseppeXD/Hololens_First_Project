Texture3D ObjTexture;
Texture1D TransferFunc;
SamplerState ObjSampler;

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
    const float stepSize = 1.74f / NUM_STEPS;

    float3 rayStartPos = i.texCoord;

    float3 posWorld = i.posModel;
    float3 posEye = i.posEye;
    float3 rayDir = posEye - posWorld;
    rayDir = normalize(rayDir);

    float maxDensity = 0.0f;
    float3 currPos;
    float4 col = float4(0.0f, 0.0f, 0.0f, 0.0f);
    float3 posTexture;

    for (uint iStep = 0; iStep < NUM_STEPS; iStep++)
    {
        currPos = rayStartPos + (rayDir * iStep * stepSize);

        // Para quando esta fora do cubo
        if (currPos.x < 0.0f || currPos.x > 1.0f || currPos.y < 0.0f || currPos.y > 1.0f || currPos.z < 0.0f || currPos.z > 1.0f) {
            break;
        }

        posTexture.x = 1.f - currPos.x;
        posTexture.y = 1.f - currPos.y;
        posTexture.z = 1.f - currPos.z;

        maxDensity = max(maxDensity, ObjTexture.Sample(ObjSampler, posTexture));
    }

    col = float4(1.0f, 1.0f, 1.0f, maxDensity);

    return col;
}

float4 main(PixelShaderInput input) : SV_TARGET
{
    return Max_intensity(input);
}
