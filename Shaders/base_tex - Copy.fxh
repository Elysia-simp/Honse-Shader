#define merge_strings(a,b) a##b 


texture diffuseTexture : MATERIALTEXTURE <>;
sampler diffuseSampler = sampler_state {texture = < diffuseTexture >; ADDRESSU = WRAP; ADDRESSV = WRAP;};

texture LightTexture : MATERIALSPHEREMAP<>;
sampler LightSampler = sampler_state 
{texture = < LightTexture >; ADDRESSU = CLAMP; ADDRESSV = CLAMP;};