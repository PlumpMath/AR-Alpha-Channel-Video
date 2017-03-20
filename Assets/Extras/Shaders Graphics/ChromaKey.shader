Shader "Custom/OriInvi" {
	Properties{
		_MainTex("Base (RGB)", 2D) = "white" {}
	}
		SubShader{
		Tags{ "Queue" = "Transparent" "IgnoreProjector" = "True" "RenderType" = "Transparent" }
		LOD 100

		CGPROGRAM
#pragma surface surf Lambert alpha

		sampler2D _MainTex;

	struct Input {
		float2 uv_MainTex;
	};

	void surf(Input IN, inout SurfaceOutput o) {
		half4 c = tex2D(_MainTex, IN.uv_MainTex);
		o.Albedo = c.rgb;

		// #################################
		//
		// CHANGE THESE VALUES DEPENDING ON WHAT SHOULD BE TRANSPARENT
		//
		// #################################
		if (c.g > 70.0 / 255.0 && c.r < 80.0 / 255.0 && c.b < 80.0 / 255.0)
		{
			o.Alpha = 0.00;
		}
		else
		{
			o.Alpha = c.a;
		}
	}
	ENDCG
	}
		FallBack "Diffuse"
}