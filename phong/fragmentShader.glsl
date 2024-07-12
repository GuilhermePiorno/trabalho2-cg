#version 300 es
precision mediump float;
precision mediump int;
in vec4 vColor;

in vec3 normalVec;
in vec3 lightVec;
in vec3 eyeVec;

in vec2 vTextureCoordinate;
out vec4 fragColor;
uniform int uTextureActive;

uniform sampler2D uSampler;

void main(void) {


    float lambert = dot(normalVec,lightVec);
    vec4 matDiff, matSpec;

    //Se houver textura, o material da superficie e definido pela cor dos vertices
    if (uTextureActive==0){
      matDiff = vColor;
      matSpec = vColor;
    }
    else{// se nao é um cor branca
      fragColor = vec4(1.0, 1.0, 1.0, 1.0);
      matDiff = vec4(1.0,1.0,1.0,1.0);
      matSpec = vec4(1.0,1.0,1.0,1.0);
    }

    vec3 Ia; //Iluminacao ambiental
    vec3 Id; //Iluminacao Difusa
    vec3 Is; //Iluminacao Especular
    float Ka = 0.3;
    float Kd = 0.8;
    float Ks = 0.5;
    float ns = 8.0;

    //Calculo da compoenente ambiental
    // Ia = Ka*vec3(1.0,1.0,1.0);
    Ia = vec3(0.1,0.1,0.1);
    // Ia = vec3(0.0,0.0,0.0);

    //Se o coeficiente de atenuacao difusa for positivo
    if (lambert>0.0){//multiplica o coeficiente pelo material
      vec3 refVec = reflect(-lightVec,normalVec);
      float angSpec = max(0.0,dot(refVec,eyeVec));
      float specular = pow(angSpec,ns);
      Id = Kd*vec3(lambert*matDiff);
      Is = Ks*vec3(specular*matSpec);
    }
    else{//senao a iluminacao difusa e zero
      Id = vec3(0.0,0.0,0.0);
      Is = vec3(0.0,0.0,0.0);
    }

    fragColor = vec4(Ia+Id+Is,1.0);

    if (uTextureActive==1){
        fragColor = fragColor*texture(uSampler,vTextureCoordinate);
    }else{
        fragColor = fragColor;
    }
}
