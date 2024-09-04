import mongoose, { Document } from "mongoose";

export async function Save(document: Document) {
    let obj: any = null;

    await document
        .save()
        .then(res => { obj = res; })
        .catch(err => { console.warn(err); return err; });
    return obj;
}

export const NewId = (value: string | null = null) => {
    if (value)
        return new mongoose.Types.ObjectId(value);
    else
        return new mongoose.Types.ObjectId();
}