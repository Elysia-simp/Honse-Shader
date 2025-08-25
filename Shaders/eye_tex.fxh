#define merge_strings(a,b) a##b 


texture diffuseTexture : MATERIALTEXTURE <>;
sampler diffuseSampler = sampler_state {texture = < diffuseTexture >; ADDRESSU = WRAP; ADDRESSV = WRAP;};

texture High0Texture : TEXTURE <string ResourceName = merge_strings("Textures/", _High0Tex);>;
sampler High0Sampler = sampler_state 
{texture = < High0Texture >; ADDRESSU = CLAMP; ADDRESSV = CLAMP;};

texture High1Texture : TEXTURE <string ResourceName = merge_strings("Textures/", _High1Tex);>;
sampler High1Sampler = sampler_state 
{texture = < High1Texture >; ADDRESSU = CLAMP; ADDRESSV = CLAMP;};

texture High2Texture : TEXTURE <string ResourceName = merge_strings("Textures/", _High2Tex);>;
sampler High2Sampler = sampler_state 
{texture = < High2Texture >; ADDRESSU = CLAMP; ADDRESSV = CLAMP;};