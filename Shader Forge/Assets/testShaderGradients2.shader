// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.1280277,fgcg:0.1953466,fgcb:0.2352941,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33224,y:32713,varname:node_3138,prsc:2|emission-3032-OUT;n:type:ShaderForge.SFN_TexCoord,id:8681,x:31786,y:32734,varname:node_8681,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Color,id:470,x:32785,y:32407,ptovrint:False,ptlb:node_470,ptin:_node_470,varname:_node_470,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.0518765,c2:0,c3:0.6838235,c4:1;n:type:ShaderForge.SFN_Color,id:3705,x:32748,y:32651,ptovrint:False,ptlb:node_3705,ptin:_node_3705,varname:_node_3705,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.8161765,c2:0,c3:0.7598885,c4:1;n:type:ShaderForge.SFN_Lerp,id:3032,x:32982,y:32735,varname:node_3032,prsc:2|A-470-RGB,B-3705-RGB,T-3957-OUT;n:type:ShaderForge.SFN_ComponentMask,id:3241,x:31960,y:32748,varname:node_3241,prsc:2,cc1:1,cc2:-1,cc3:-1,cc4:-1|IN-8681-UVOUT;n:type:ShaderForge.SFN_Clamp01,id:3957,x:32765,y:32835,varname:node_3957,prsc:2|IN-119-OUT;n:type:ShaderForge.SFN_Sin,id:5052,x:32359,y:32695,varname:node_5052,prsc:2|IN-3004-OUT;n:type:ShaderForge.SFN_Tau,id:5977,x:31884,y:32526,varname:node_5977,prsc:2;n:type:ShaderForge.SFN_Vector1,id:446,x:31943,y:32332,varname:node_446,prsc:2,v1:2;n:type:ShaderForge.SFN_Multiply,id:3004,x:32187,y:32695,varname:node_3004,prsc:2|A-5977-OUT,B-3241-OUT,C-446-OUT;n:type:ShaderForge.SFN_RemapRange,id:119,x:32537,y:32746,varname:node_119,prsc:2,frmn:-1,frmx:1,tomn:0,tomx:1|IN-5052-OUT;n:type:ShaderForge.SFN_Root2,id:2848,x:31884,y:32406,varname:node_2848,prsc:2;proporder:470-3705;pass:END;sub:END;*/

Shader "Shader Forge/testShaderGradients2" {
    Properties {
        _node_470 ("node_470", Color) = (0.0518765,0,0.6838235,1)
        _node_3705 ("node_3705", Color) = (0.8161765,0,0.7598885,1)
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float4 _node_470;
            uniform float4 _node_3705;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
////// Lighting:
////// Emissive:
                float3 emissive = lerp(_node_470.rgb,_node_3705.rgb,saturate((sin((6.28318530718*i.uv0.g*2.0))*0.5+0.5)));
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
