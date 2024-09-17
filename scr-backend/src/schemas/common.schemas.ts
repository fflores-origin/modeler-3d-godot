import { Schema, model, Types } from "mongoose";

export const translationSchema = new Schema({
    _id: { type: Types.ObjectId },
    isoCode: {
        type: String,
        required: true
    },
    values: {
        type: Map,
        of: String, // Cada valor dentro del diccionario será una cadena de texto (la traducción)
        required: true
    }
})

const translationSetSchema = new Schema({
    name: {
        type: String,
        required: true // Por ejemplo, podría ser el nombre de la página o la sección
    },
    translations: [translationSchema], // Lista de traducciones con sus respectivos idiomas
});

export const TranslationSet = model('translation', translationSetSchema, 'translation');


