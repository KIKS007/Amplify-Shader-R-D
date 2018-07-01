// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "S_Dissolve"
{
	Properties
	{
		_RotateSpeed("Rotate Speed", Float) = 0.5
		_RotateDirection("Rotate Direction", Vector) = (0.5,0.5,0,0)
		_DissolveAmount("DissolveAmount", Range( 0 , 1)) = 0
		_Normal("Normal", 2D) = "white" {}
		_BurnColors("Burn Colors", 2D) = "white" {}
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
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows exclude_path:deferred 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Normal;
		uniform float4 _Normal_ST;
		uniform float _DissolveAmount;
		uniform sampler2D _DissolveGuide;
		uniform float _RotateSpeed;
		uniform float2 _RotateDirection;
		uniform float4 _DissolveGuide_ST;
		uniform sampler2D _BurnColors;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Normal = i.uv_texcoord * _Normal_ST.xy + _Normal_ST.zw;
			o.Normal = tex2D( _Normal, uv_Normal ).rgb;
			float2 uv_DissolveGuide = i.uv_texcoord * _DissolveGuide_ST.xy + _DissolveGuide_ST.zw;
			float2 panner6_g9 = ( ( _Time.y * _RotateSpeed ) * _RotateDirection + uv_DissolveGuide);
			float4 tex2DNode15_g9 = tex2D( _DissolveGuide, panner6_g9 );
			float clampResult14 = clamp( (-4.0 + (( (-0.6 + (( 1.0 - _DissolveAmount ) - 0.0) * (0.6 - -0.6) / (1.0 - 0.0)) + tex2DNode15_g9.r ) - 0.0) * (4.0 - -4.0) / (1.0 - 0.0)) , 0.0 , 1.0 );
			float temp_output_15_0 = ( 1.0 - clampResult14 );
			float2 appendResult18 = (float2(temp_output_15_0 , 0.0));
			o.Emission = ( temp_output_15_0 * tex2D( _BurnColors, appendResult18 ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15401
0;92;1185;926;1978.377;-207.5482;1.511155;True;False
Node;AmplifyShaderEditor.CommentaryNode;7;-1304.084,562.5005;Float;False;1078.463;544.312;Dissolve Mask;5;5;6;3;2;61;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;2;-1273.729,772.1158;Float;False;Property;_DissolveAmount;DissolveAmount;3;0;Create;True;0;0;False;0;0;0.365;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;61;-1013.168,888.9035;Float;True;Property;_DissolveGuide;Dissolve Guide;8;0;Create;True;0;0;False;0;None;e28dc97a9541e3642a48c0e3886688c5;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.OneMinusNode;3;-981.9378,782.9211;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;67;-737.9997,921.7427;Float;False;Rotate;0;;9;24f5866c41dc8f640b75511a997c62d4;0;1;16;SAMPLER2D;0;False;5;COLOR;0;FLOAT;17;FLOAT;18;FLOAT;19;FLOAT;20
Node;AmplifyShaderEditor.TFHCRemapNode;6;-799.4559,623.3846;Float;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-0.6;False;4;FLOAT;0.6;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;5;-466.0878,678.3882;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;12;-993.9129,93.7694;Float;False;814.5701;432.0292;Burn Effect - Emission;6;18;15;14;13;17;22;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TFHCRemapNode;13;-979.1328,325.567;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-4;False;4;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;14;-898.6154,134.9864;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;15;-728.58,127.774;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;18;-685.7198,340.4723;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;22;-467.9961,331.9601;Float;True;Property;_BurnColors;Burn Colors;7;0;Create;True;0;0;False;0;None;64e7766099ad46747a07014e44d0aea1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;8;-391.9432,-421.5798;Float;True;Property;_Albedo;Albedo;5;0;Create;True;0;0;False;0;None;7a170cdb7cc88024cb628cfcdbb6705c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;9;-650.908,-202.9549;Float;True;Property;_Normal;Normal;6;0;Create;True;0;0;False;0;None;e9742c575b8f4644fb9379e7347ff62e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;23;40.56822,341.1155;Float;False;Property;_Color0;Color 0;9;0;Create;True;0;0;False;0;0.764151,0.118948,0.118948,0;0.3820755,0.7306685,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-410.617,85.70295;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;422.9156,-243.1801;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;S_Dissolve;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.5;True;True;0;False;TransparentCutout;;AlphaTest;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;-1;False;-1;-1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;4;0;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;3;0;2;0
WireConnection;67;16;61;0
WireConnection;6;0;3;0
WireConnection;5;0;6;0
WireConnection;5;1;67;17
WireConnection;13;0;5;0
WireConnection;14;0;13;0
WireConnection;15;0;14;0
WireConnection;18;0;15;0
WireConnection;22;1;18;0
WireConnection;17;0;15;0
WireConnection;17;1;22;0
WireConnection;0;1;9;0
WireConnection;0;2;17;0
ASEEND*/
//CHKSM=8A5C99C69026B4E099AB8B98AE2FACB50ABC6995