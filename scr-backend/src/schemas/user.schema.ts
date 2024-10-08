import mongoose, { Schema, model, Types } from "mongoose";

export const userSchema = new Schema({
    _id: { type: Types.ObjectId },
    username: { type: String },
    dateCreation: { type: Date },
    dateUpdate: { type: Date },
    password: { type: String },
    status: { type: Number },
})

export const User = model('users', userSchema, 'users')

export const sesionSchema = new Schema({
    _id: { type: Types.ObjectId },
    user: { type: mongoose.Schema.Types.ObjectId, ref: 'users' },
    token: { type: String },
    dateCreation: { type: Date }
})

export const Session = model('sessions', sesionSchema, 'sessions')