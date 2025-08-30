#define merge_strings(a,b) a##b 


texture diffuseTexture : MATERIALTEXTURE <>;
sampler diffuseSampler = sampler_state {texture = < diffuseTexture >; ADDRESSU = WRAP; ADDRESSV = WRAP;};

texture OptionTexture : TEXTURE <string ResourceName = merge_strings("Textures/", _OptionMaskMap);>;
sampler OptionSampler = sampler_state 
{texture = < OptionTexture >; ADDRESSU = CLAMP; ADDRESSV = CLAMP;};

texture TripleTexture : TEXTURE <string ResourceName = merge_strings("Textures/", _TripleMaskMap);>;
sampler TripleSampler = sampler_state 
{texture = < TripleTexture >; ADDRESSU = CLAMP; ADDRESSV = CLAMP;};

texture ToonTexture : TEXTURE <string ResourceName = merge_strings("Textures/", _ToonMap);>;
sampler ToonSampler = sampler_state 
{texture = < ToonTexture >; ADDRESSU = CLAMP; ADDRESSV = CLAMP;};

texture EnvTexture : TEXTURE <string ResourceName = merge_strings("Textures/", _EnvMap);>;
sampler EnvSampler = sampler_state 
{texture = < EnvTexture >; ADDRESSU = CLAMP; ADDRESSV = CLAMP;};

#ifdef _EmissiveTex
texture EmissionTexture : TEXTURE <string ResourceName = merge_strings("Textures/", _EmissiveTex);>;
sampler EmissionSampler = sampler_state 
{texture = < EmissionTexture >; ADDRESSU = CLAMP; ADDRESSV = CLAMP;};
#endif
#ifdef _ReflectionMap
texture ReflectionTexture : TEXTURE <string ResourceName = merge_strings("Textures/", _ReflectionMap);>;
sampler ReflectionSampler = sampler_state 
{texture = < ReflectionTexture >; ADDRESSU = CLAMP; ADDRESSV = CLAMP;};
#endif