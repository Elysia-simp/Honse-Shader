float UmaStep(float value, float step, float feather, float mask = 1.0)
{
    float stepval = step + (-feather);
    return saturate((((-mask) * value + stepval) / feather) + 1.0); // rimlights don't use mask here, but it works all the same.
}

float UmaShadow(float ndotl, float shadowmask)
{
    float toonstep = UmaStep(ndotl, _ToonStep, _ToonFeather, shadowmask);
    float temp = (0.0 >= _ToonStep) ? toonstep : 0.0;
    toonstep += temp;

    return toonstep;
}

float3 ToonShift(float3 ToonColBase, float4 ToonColor, float vertpow)
{
    float toonbright = (0.5 >= ToonColor.w) ? 1.0 : 0.0f;
    float toonbrightvert = vertpow * toonbright;
    
    float3 toonbrightcol = lerp(1.0, ToonColor.xyz, toonbrightvert);
    float3 toonbrightemp = (0.5 >= ToonColor.w) ? 0.0 : ToonColor;
    float3 toonbrightcol2 = vertpow * toonbrightemp;

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
        float3 viewoffset1 = UmaView(view, _RimHorizonOffset, _RimVerticalOffset, viewmatrix1, viewmatrix2);
        float3 viewoffset2 = UmaView(view, _RimHorizonOffset2, _RimVerticalOffset2, viewmatrix1, viewmatrix2);

        float ndotv1 = dot(viewoffset1, normal);
        float ndotv2 = dot(viewoffset2, normal);

        float2 rims;
        rims.x = pow(UmaStep(ndotv1, _RimStep, _RimFeather), 3) * _RimColor.w;
        rims.y = pow(UmaStep(ndotv2, _RimStep2, _RimFeather2), 3) * _RimColor2.w;
        rims.xy *= rimmask;

        //specular

        float spec = max(ndotv1, 0.0f);
        float specpow = (_SpecularPower * 10) + 1;
        spec = pow(spec, specpow) * specmask;
        return float3(rims.xy,spec.x);
    }
#endif