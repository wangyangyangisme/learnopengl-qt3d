import Qt3D.Core 2.0
import Qt3D.Render 2.0

import "Components"

Scene0 {
	Entity {
		id: root

		RenderSettings0 {}

		Entity {
			id: plane

			GeometryRenderer {
				id: geometry
				geometry: Geometry {
					boundingVolumePositionAttribute: position

					Attribute {
						id: position
						attributeType: Attribute.VertexAttribute
						vertexBaseType: Attribute.Float
						vertexSize: 3
						count: 4
						byteOffset: 0
						byteStride: 8 * 4
						name: "position"
						buffer: vertexBuffer
					}

					Attribute {
						attributeType: Attribute.VertexAttribute
						vertexBaseType: Attribute.Float
						vertexSize: 3
						count: 4
						byteOffset: 3 * 4
						byteStride: 8 * 4
						name: "color"
						buffer: vertexBuffer
					}

					Attribute {
						attributeType: Attribute.VertexAttribute
						vertexBaseType: Attribute.Float
						vertexSize: 2
						count: 4
						byteOffset: 6 * 4
						byteStride: 8 * 4
						name: "texCoord"
						buffer: vertexBuffer
					}

					Attribute {
						attributeType: Attribute.IndexAttribute
						vertexBaseType: Attribute.UnsignedShort
						vertexSize: 1
						count: 6
						buffer: Buffer {
							type: Buffer.IndexBuffer
							data: new Uint16Array([
								0, 1, 3,  // First Triangle
								1, 2, 3,  // Second Triangle
							])
						}
					}
				}

				Buffer {
					id: vertexBuffer
					type: Buffer.VertexBuffer
					data: new Float32Array([
						// Positions	  // Colors		// Texture Coords
						 0.5,  0.5, 0.0,   1.0, 0.0, 0.0,   1.0, 1.0, // Top Right
						 0.5, -0.5, 0.0,   0.0, 1.0, 0.0,   1.0, 0.0, // Bottom Right
						-0.5, -0.5, 0.0,   0.0, 0.0, 1.0,   0.0, 0.0, // Bottom Left
						-0.5,  0.5, 0.0,   1.0, 1.0, 0.0,   0.0, 1.0, // Top Left
					])
				}
			}

			Material {
				id: material
				effect: Effect {
					techniques: AutoTechnique {
						renderPasses: RenderPass {
							renderStates: CullFace { mode: CullFace.NoCulling }
							shaderProgram: AutoShaderProgram {
								vertName: "texture"
								fragName: "texture"
							}
						}
					}
				}

				parameters: Parameter {
					name: "ourTexture"
					value: Texture2D {
						/*
							Any texture from AbstractTexture is available, we use 2D texture here
							Refer: qthelp://org.qt-project.qt3d.570/qt3d/qt3drender-qtexture2d.html
							#TRYIT: change filtering mode
						*/

						generateMipMaps: true
						minificationFilter: Texture.Linear
						magnificationFilter: Texture.Linear
						wrapMode { // #TRYIT: change wrap mode
							x: WrapMode.Repeat
							y: WrapMode.Repeat
						}
						TextureImage {
							// Texture image here

							mipLevel: 0
							source: Resources.texture("container.jpg")
						}
					}
				}
			}

			components: [geometry, material]
		}
	}
}
