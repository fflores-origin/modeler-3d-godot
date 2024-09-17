import mongoose, { Schema, model, Types } from "mongoose";

export interface Dimension {
    x: number,
    y: number,
    z: number,
}

export const meshComponentSchema = new Schema({
    _id: { type: Types.ObjectId },
    componentType: { type: String },
    name: { type: String },
    dimension: { type: Array<Dimension>, default: [] },
    position: { type: Array<Dimension>, default: [] }

})

export const MeshComponent = model('meshComponent', meshComponentSchema, 'meshComponent')

export const projectSchema = new Schema({
    _id: { type: Types.ObjectId },
    dateCreation: { type: Date },
    dateUpdate: { type: Date },
    creatorId: { type: Types.ObjectId },
    models: { type: Array<typeof MeshComponent>, default: [] }
})

export const Project = model("project", projectSchema, 'project')