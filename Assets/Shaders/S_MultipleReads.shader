// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "S_MultipleReads"
{
	Properties
	{
		_Enable("Enable", Int) = 0
		_Tilling("Tilling", Float) = 5
		_Albedo("Albedo", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform int _Enable;
		uniform sampler2D _Albedo;
		uniform float4 _Albedo_ST;
		uniform float _Tilling;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			float4 tex2DNode11 = tex2D( _Albedo, uv_Albedo );
			float4 blendOpSrc12 = tex2DNode11;
			float4 blendOpDest12 = tex2D( _Albedo, ( uv_Albedo * _Tilling ) );
			o.Albedo = (( _Enable == 0 ) ? tex2DNode11 :  ( saturate(  (( blendOpSrc12 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpSrc12 - 0.5 ) ) * ( 1.0 - blendOpDest12 ) ) : ( 2.0 * blendOpSrc12 * blendOpDest12 ) ) )) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15401
0;92;1185;926;1520.827;487.5866;1.6;True;False
Node;AmplifyShaderEditor.TexturePropertyNode;7;-1168.601,68.51421;Float;True;Property;_Albedo;Albedo;2;0;Create;True;0;0;False;0;b297077dae62c1944ba14cad801cddf5;b297077dae62c1944ba14cad801cddf5;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;10;-924.9035,202.0529;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;13;-957.6045,391.8529;Float;False;Property;_Tilling;Tilling;1;0;Create;True;0;0;False;0;5;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-769.1047,364.5531;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1;-611.9104,292.4012;Float;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;False;0;b297077dae62c1944ba14cad801cddf5;b297077dae62c1944ba14cad801cddf5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;11;-631.7416,65.50075;Float;True;Property;_TextureSample1;Texture Sample 1;0;0;Create;True;0;0;False;0;b297077dae62c1944ba14cad801cddf5;b297077dae62c1944ba14cad801cddf5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.IntNode;4;-687.7469,-255.7122;Float;False;Property;_Enable;Enable;0;0;Create;True;0;0;False;0;0;1;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;5;-710.5082,-143.2375;Float;False;Constant;_Int0;Int 0;2;0;Create;True;0;0;False;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.BlendOpsNode;12;-283.2714,159.78;Float;True;HardLight;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCCompareEqual;6;-309.3892,-131.645;Float;False;4;0;INT;0;False;1;INT;0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;S_MultipleReads;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;-1;False;-1;-1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;10;2;7;0
WireConnection;14;0;10;0
WireConnection;14;1;13;0
WireConnection;1;0;7;0
WireConnection;1;1;14;0
WireConnection;11;0;7;0
WireConnection;11;1;10;0
WireConnection;12;0;11;0
WireConnection;12;1;1;0
WireConnection;6;0;4;0
WireConnection;6;1;5;0
WireConnection;6;2;11;0
WireConnection;6;3;12;0
WireConnection;0;0;6;0
ASEEND*/
//CHKSM=92F2635BD116F7C5D95934C1CE1D9BF76FD06A38