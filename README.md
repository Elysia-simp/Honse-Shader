# OLD GPU WARNING
As this is code converted from OpenGL to HLSL. I cannot personally address issues caused by simply having a old computer/intergrated GPUs. But seeing as the code should be similar to how the PC shaders work there shouldn't be any problems. Otherwise do not make an error report.

I tried my best to make sure MMD has a consistent result when compiling.

Well, It's either all that or y'all need to upgrade to windows 10+ idk...

# Usage

You will require a dumped material file from the game, While this uses [UmaViewer](https://github.com/katboi01/UmaViewer) exports as a base. I would not reccomend using any other methods of exports unless you knew what you were doing.

If you use UmaViewer in editor you can use this edit of [ModelExporter.cs](https://gist.github.com/Elysia-simp/9c4d8c7c59f7d3e531c2a8b374711383) that'll export material values from UmaViewer.


Otherwise you can just use your own dumped materials and just edit Material.fx for each instance of your material.

There are no other alternatives to this as it'll have to be on UmaViewer devs or someone else. Due to the complexity of the shader it's not exactly plug and play. This is just how I personally choose to go about it.

# Rules

1. Follow the official guidelines for Uma Musume Fan content/derivative work ([JP](https://umamusume.jp/derivativework_guidelines/)/[EN](https://umamusume.com/fan-createdguide/)).
2. When using this shader do clarify that CyGames and Me (Chips) created the shader.
3. When releasing models using MusumeToon. Only ship relevant material files to prevent conflicts. If you have made modifications to the shader then this is not applicable.

# Unimplemented features

I implemented features based on how I use the shader within context. If something is missing and makes a valid point for implementing into MMD please let me know via Discord (CBTDWG) or in the error reports (label them correctly)!

If you have any other inquires about the rules or the shader itself best to contact me via Discord.