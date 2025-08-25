//KEEP THIS AS SHIFT-JIS

//shit
float4x4 mmd_world : WORLD;
float4x4 mmd_view  : VIEW;
float4x4 mmd_wvp   : WORLDVIEWPROJECTION;
float4x4 mmd_p : PROJECTION;
float4x4 mmd_vp : VIEWPROJECTION;

//useful for scaling edgelines based on camera distance
float4x4 model_world : CONTROLOBJECT < string name = "(self)"; >;
float3 mmd_cameraPosition : POSITION < string Object = "Camera"; >;

//mmd RGB lighting intake
float4 egColor;

//bones
float4x4 head_bone : CONTROLOBJECT < string name = "(self)"; string item = "“ª"; >;
float3 head_loc : CONTROLOBJECT < string name = "(self)"; string item = "“ª"; >;


//mmd light source
float3 light_d : DIRECTION < string Object = "Light"; >;
