import mongoose, { Schema, model, Types } from "mongoose";

export const userSchema = new Schema({
    _id: { type: Types.ObjectId },
    userName: { type: String },
    dateCreation: { type: String },
    password: { type: String },
    isBlocked: { type: Boolean },
})

export const User = model('user', userSchema, 'user')

export const sesionSchema = new Schema({
    _id: { type: Types.ObjectId },
    user: { type: User },
    dateCreation: { type: Date }
})

export const Session = model('session', sesionSchema, 'session')