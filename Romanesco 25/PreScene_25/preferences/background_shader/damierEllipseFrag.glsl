/*
	Remake of my Khan academy computer science program
	https://www.khanacademy.org/cs/circles/1073977688
	And rework  for Romanesco by Stan le Punk 2014
*/

#ifdef GL_ES
precision mediump float;
#endif

uniform vec4 colorBG ;
uniform float beat;
uniform float time;
uniform vec2 mouse;
uniform vec2 resolution;



vec2 ASPECT_RATIO = normalize(vec2(resolution.x, resolution.y));

struct circle {
	vec2 pos;
	float r;
	float border;
	vec4 color ;
} ;
	





float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

uniform sampler2D backbuffer;
vec2 position;

// http://stackoverflow.com/questions/12945277/drawing-antialiased-circle-using-shaders
void circle_render(circle c) {
    vec2 m = position + vec2(-c.pos.x, -c.pos.y);
    float dist = c.r - length(m);
    float t = 0.0;
	
    if (dist > c.border) t = 1.0;
    else if (dist > 0.0) t = dist / c.border;
	    
    vec4 bb = vec4(texture2D(backbuffer, gl_FragCoord.xy/resolution).rgb, 1.0);
    vec4 colorTemp = mix(mix(gl_FragColor, c.color, t), bb, 0.02);
    gl_FragColor = colorTemp ;

}

const int n = 10;

float r = 0.05;
float max_r = 0.05;

float s = beat *.1;
circle c;

float dist;

// vec4  color = vec4(1., 1., 1., 1.) ;
vec4  color = vec4(colorBG.x, colorBG.y, 1., 1.) ;
// vec4  color = colorBG ;

void main (void) {

	position = ( gl_FragCoord.xy / resolution.xy ) *ASPECT_RATIO;
	
	for(int i = 0; i < n; i++) {
		
		for(int j = 0; j < n; j++) {
			c.pos = vec2(float(i)*r*2.0, float(j) *r *2.);
			
			dist = distance(mouse *ASPECT_RATIO, c.pos) *s;
			
			c.border = dist = max(dist, .003);
			
			c.r = min(dist + rand(vec2(beat +float(i), beat +float(j))) *dist *.5, max_r);
			
			c.color = vec4(color.x/dist, color.y/dist, color.z/dist, color.w) *.015 ;

			circle_render(c);
		}
		
	}

}