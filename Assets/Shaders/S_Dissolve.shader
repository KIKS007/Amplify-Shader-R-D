// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "IronEqual/S_Dissolve"
{
	Properties
	{
		_MovementSpeed("Movement Speed", Float) = 0.5
		_MovementDirection("Movement Direction", Vector) = (0.5,0.5,0,0)
		_DissolveAmount("DissolveAmount", Range( 0 , 1)) = 0
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_Albedo("Albedo", 2D) = "white" {}
		_Normal("Normal", 2D) = "white" {}
		_BurnColors("Burn Colors", 2D) = "white" {}
		_RemapMin("Remap Min", Float) = 0
		_RemapMax("Remap Max", Float) = 0
		_DissolveGuide("Dissolve Guide", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 4.6
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows exclude_path:deferred 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Normal;
		uniform float4 _Normal_ST;
		uniform sampler2D _Albedo;
		uniform float4 _Albedo_ST;
		uniform float _DissolveAmount;
		uniform sampler2D _DissolveGuide;
		uniform float _MovementSpeed;
		uniform float2 _MovementDirection;
		uniform float4 _DissolveGuide_ST;
		uniform float _RemapMin;
		uniform float _RemapMax;
		uniform sampler2D _BurnColors;
		uniform float _Cutoff = 0.5;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Normal = i.uv_texcoord * _Normal_ST.xy + _Normal_ST.zw;
			o.Normal = tex2D( _Normal, uv_Normal ).rgb;
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			o.Albedo = tex2D( _Albedo, uv_Albedo ).rgb;
			float2 uv_DissolveGuide = i.uv_texcoord * _DissolveGuide_ST.xy + _DissolveGuide_ST.zw;
			float2 panner6_g13 = ( ( _Time.y * _MovementSpeed ) * _MovementDirection + uv_DissolveGuide);
			float4 tex2DNode15_g13 = tex2D( _DissolveGuide, panner6_g13 );
			float temp_output_5_0 = ( (-0.6 + (( 1.0 - _DissolveAmount ) - 0.0) * (0.6 - -0.6) / (1.0 - 0.0)) + tex2DNode15_g13.r );
			float clampResult14 = clamp( (_RemapMin + (temp_output_5_0 - 0.0) * (_RemapMax - _RemapMin) / (1.0 - 0.0)) , 0.0 , 1.0 );
			float temp_output_15_0 = ( 1.0 - clampResult14 );
			float2 temp_cast_2 = (temp_output_15_0).xx;
			o.Emission = ( temp_output_15_0 * tex2D( _BurnColors, temp_cast_2 ) ).rgb;
			o.Alpha = 1;
			clip( temp_output_5_0 - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
}
/*ASEBEGIN
Version=15401
0;92;1154;926;1636.912;203.7273;1.3;True;False
Node;AmplifyShaderEditor.CommentaryNode;76;-1206.818,667.3775;Float;False;1031.741;534.5068;Dissolve Mask;6;61;71;5;3;6;2;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;2;-1156.818,872.1087;Float;False;Property;_DissolveAmount;DissolveAmount;3;0;Create;True;0;0;False;0;0;0.514;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;3;-883.0271,876.914;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;61;-954.5571,971.1965;Float;True;Property;_DissolveGuide;Dissolve Guide;10;0;Create;True;0;0;False;0;None;e28dc97a9541e3642a48c0e3886688c5;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TFHCRemapNode;6;-700.5452,717.3775;Float;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-0.6;False;4;FLOAT;0.6;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;71;-683.2722,999.8843;Float;False;Move;0;;13;24f5866c41dc8f640b75511a997c62d4;0;1;16;SAMPLER2D;0;False;5;COLOR;0;FLOAT;17;FLOAT;18;FLOAT;19;FLOAT;20
Node;AmplifyShaderEditor.CommentaryNode;77;-1245.434,52.19331;Float;False;1077.807;536.5805;Burn Effect;7;13;14;15;22;17;73;75;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;73;-1195.434,381.939;Float;False;Property;_RemapMin;Remap Min;8;0;Create;True;0;0;False;0;0;-3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;75;-1184.434,454.939;Float;False;Property;_RemapMax;Remap Max;9;0;Create;True;0;0;False;0;0;3.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;5;-410.0773,763.2811;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;13;-964.2361,335.7738;Float;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-1;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;14;-922.9182,102.1933;Float;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;15;-674.5828,175.2808;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;22;-529.4538,354.3696;Float;True;Property;_BurnColors;Burn Colors;7;0;Create;True;0;0;False;0;None;64e7766099ad46747a07014e44d0aea1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-402.6272,114.2002;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;9;-636.1145,-193.0925;Float;True;Property;_Normal;Normal;6;0;Create;True;0;0;False;0;None;e9742c575b8f4644fb9379e7347ff62e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;8;-391.9432,-421.5798;Float;True;Property;_Albedo;Albedo;5;0;Create;True;0;0;False;0;None;f6df8509372384f48bb3fa1a762ba9b3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-32.68334,-80.46612;Float;False;True;6;Float;;0;0;Standard;IronEqual/S_Dissolve;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.5;True;True;0;False;TransparentCutout;;AlphaTest;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;-1;False;-1;-1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;4;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;3;0;2;0
WireConnection;6;0;3;0
WireConnection;71;16;61;0
WireConnection;5;0;6;0
WireConnection;5;1;71;17
WireConnection;13;0;5;0
WireConnection;13;3;73;0
WireConnection;13;4;75;0
WireConnection;14;0;13;0
WireConnection;15;0;14;0
WireConnection;22;1;15;0
WireConnection;17;0;15;0
WireConnection;17;1;22;0
WireConnection;0;0;8;0
WireConnection;0;1;9;0
WireConnection;0;2;17;0
WireConnection;0;10;5;0
ASEEND*/
//CHKSM=F4A7CB931C88B0E536BED46CCDDF7A0BAE402FB2