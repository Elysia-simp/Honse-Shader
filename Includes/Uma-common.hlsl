float UmaStep(float value, float step, float feather, float mask = 1.0)
{
    return smoothstep(step + feather, step - feather, mask * value);
} // turns out this was a smoothstep this entire time lmfao
// my only defense is i don't reverse smoothsteps often

float UmaShadow(float ndotl, float shadowmask)
{
    float toonstep = UmaStep(ndotl, ShadowStep, clamp(ShadowFeather, 0.0001, 1), shadowmask);
    float temp = (0.0 >= ShadowStep) ? toonstep : 0.0;
    toonstep += temp;

    return toonstep;
}

float edge_dis(float4 pos)
{
        // Use projection matrix to get correct perspective scaling
        float perspective = max(tan(-mmd_p[0].y/2), 0.0001); // mmd_view[1][1] is related to tan(fov/2)
        if(mmd_p[3].w) perspective = 2.0; // perspective check

        float4 test = mul(pos, mul(model_world, mmd_view));
        float tmp = ((test.z / test.w));
        return clamp(tmp, 1, 50);
}

float3 ToonShift(float3 ToonColBase, float4 ToonColor, float vertpow)
{
    float toonbright = (0.5 >= ToonColor.w) ? 1.0 : 0.0f;
    float toonbrightvert = vertpow * toonbright;
    
    float3 toonbrightcol = lerp(1.0, ToonColor.xyz, toonbrightvert);
    float3 toonbrightcol2 = vertpow * ((0.5 >= ToonColor.w) ? 0.0 : ToonColor);

    return ToonColBase.xyz * toonbrightcol + toonbrightcol2;
}

float whateverthisis(float vertexcolor, float ndotl, float pow = 0) //idk what to call it
{
    float start = (1.0f - vertexcolor) * pow;
    float toon_light = saturate(ndotl - 0.5f + 0.5f);
    return 1.0f - start * toon_light;
}

float3 UmaView(float3 view, float offset_horizontal, float offset_vertical, float3 matrix1, float3 matrix2)
{
    float2 rim_inv = (float2(offset_horizontal, offset_vertical) >= 0.0) ? 1.0 : -1.0;

    float3 view_horiOffset = lerp(view, matrix1 * rim_inv.x, abs(offset_horizontal));
    return lerp(view_horiOffset, matrix2 * rim_inv.y, abs(offset_vertical)); //mmd is -z forward so there might be a minor difference between unity/mmd screenspace?
}

#ifdef _RimHorizonOffset // if it don't have it don't use, shrimple.
    float3 UmaRimSpec(float3 normal, float3 view, float rimmask, float specmask)
    {
        float3 viewmatrix1 = float3(mmd_view[0].x, mmd_view[1].x, mmd_view[2].x);
        float3 viewmatrix2 = float3(mmd_view[0].y, mmd_view[1].y, mmd_view[2].y);

        //rim
        float3 viewoffset1 = UmaView(view, RimHorizonOffset, RimVerticalOffset, viewmatrix1, viewmatrix2);
        float3 viewoffset2 = UmaView(view, RimHorizonOffset2, RimVerticalOffset2, viewmatrix1, viewmatrix2);

        float ndotv1 = dot(viewoffset1, normal);
        float ndotv2 = dot(viewoffset2, normal);

        float2 rims;
        rims.x = pow(UmaStep(ndotv1, RimStep, clamp(RimFeather, 0.0001, 1)), 3) * max(RimColor.w, 0.0f);
        rims.y = pow(UmaStep(ndotv2, RimStep2, clamp(RimFeather2, 0.0001, 1)), 3) * max(RimColor2.w, 0.0f);
        rims.xy *= rimmask;

        //specular

        float spec = max(ndotv1, 0.0f);
        float specpow = (_SpecularPower * 10) + 1;
        spec = pow(spec, specpow) * specmask;
        return float3(rims.xy,spec.x);
    }
#endif

void Generate_Saturation(inout float3 color)
{
    float x = dot(color.xyz, float3(0.213f, 0.72f, 0.072f));
    color.xyz = lerp(x, color.xyz, Saturation);
}

void Generate_Silhouette(inout float3 color)
{
    color.xyz = lerp(color.xyz, CharaColor, Silhouette);
}