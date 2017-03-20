Shader "Custom/SeparateAlpha" { 

     Properties{ 
          _MainTex("Color (RGB)", 2D) = "white" 
     } 

     SubShader{ 
          Tags{ "Queue" = "Transparent" "RenderType" = "Transparent" } 

          CGPROGRAM 
		 //#pragma surface surfaceFunction lightModel [optionalparams]
          #pragma surface surf NoLighting alpha 

          fixed4 LightingNoLighting(SurfaceOutput s, fixed3 lightDir, fixed atten) { 
               fixed4 c; 
               c.rgb = s.Albedo; 
               c.a = s.Alpha; 
               return c; 
          } 

          struct Input { 
               float2 uv_MainTex; 
          }; 

          sampler2D _MainTex; 

          void surf(Input IN, inout SurfaceOutput o) { 

			  //Note:
			  //if the value of IN.uv_MainTex.y is same as the value added at tex2D
			  //a black is shown, to remove that, the alpha must be slightly higher
				if(IN.uv_MainTex.y <= .5)
				{ 	
					o.Emission = tex2D(_MainTex, IN.uv_MainTex).rgb;
					//if the input alpha channel video is adjacent to each other,
					//the value of IN.uv_MainTex.x is concerned
					o.Alpha = tex2D(_MainTex, float2(IN.uv_MainTex.x , IN.uv_MainTex.y+.501)).rgb;
				}
				else 
				{
					o.Alpha = 0 ;
				}

           }

          ENDCG 
     } 

}