import { User } from "../schemas/user.schema";
import { NewId, Save, toObjectId } from "./base.repository";
import bcrypt from 'bcrypt';

export async function getUsername(name: string) {
    return await User.findOne({ userName: name });
}

export async function getById(id: string) {
    return await User.findById(id);
}

export async function create(user: any) {
    const id = NewId()
    const password = await bcrypt.hash(user.password, 10);
    await Save(new User({
        _id: id,
        username: user.username,
        password: password,
        dateCreation: new Date()
    }));
}

export async function erase(id: string) {
    await User.deleteOne({ _id: toObjectId(id) })
}

export async function update(user: any) {

}

export default {
    getUsername,
    getById,
    create,
    erase,
    update,
}


export class UserRepository {
    static async create([username, password]) {
        await Save(new User({
            _id: NewId(),
            username,
            password,
            isBlocked: false,
            dateCreation: new Date()
        }));
    }
}
