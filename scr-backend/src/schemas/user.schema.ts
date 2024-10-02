import mongoose, { Schema, model, Types } from "mongoose";

export const userSchema = new Schema({
    _id: { type: Types.ObjectId },
    userName: { type: String },
    dateCreation: { type: String },
    password: { type: String },
    isBlocked: { type: Boolean },
})

export const User = model('users', userSchema, 'users')

export const sesionSchema = new Schema({
    _id: { type: Types.ObjectId },
    user: { type: mongoose.Schema.Types.ObjectId, ref: 'users' },
    dateCreation: { type: Date }
})

export const Session = model('sessions', sesionSchema, 'sessions')