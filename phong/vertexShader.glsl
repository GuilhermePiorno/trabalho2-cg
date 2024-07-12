    #version 300 es
    precision mediump float;
    precision mediump int;

    in vec3 aVertexPos;
    in vec3 aVertexColor;
    in vec3 aVertexNormal;
    in vec2 aTextureCoordinate;
    

    smooth out vec4 vColor;
    smooth out vec3 normalVec;
    smooth out vec3 lightVec;
    smooth out vec3 eyeVec;
    out vec2 vTextureCoordinate;
    uniform float uVertexPointSize;
    uniform mat4 uModelViewMatrix;
    uniform mat4 uNormalMatrix;
    uniform mat4 uProjectionMatrix;
    uniform int uTextureActive;
    uniform vec3 uLightPos;
    uniform vec3 uEyePos;


    void main(void) {
      
      mat4 normalMatrix = inverse(uModelViewMatrix);
      normalMatrix = transpose(normalMatrix);

      vec4 pos = vec4(aVertexPos,1.0);
      vec4 normal = normalMatrix*vec4(aVertexNormal,0.0);
      vec4 light =  uNormalMatrix*vec4(uLightPos,0.0);
      vec4 newPos = uProjectionMatrix*uModelViewMatrix * pos;

      vColor = vec4(aVertexColor,1.0); 
      normalVec = normalize(vec3(normal));
      lightVec = normalize(vec3(light));
      eyeVec = normalize(vec3(uEyePos));


      gl_PointSize = 8.0;
      gl_Position = newPos;
      vTextureCoordinate = aTextureCoordinate;
    }
