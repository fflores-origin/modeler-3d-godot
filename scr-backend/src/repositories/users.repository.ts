import { User } from "../schemas/user.schema";
import { NewId, Save } from "./base.repository";

export async function getUserByName(name: string) {
    return await User.findOne({ userName: name });
}

export async function saveUser(user: any) {
    Save(new User({ _id: NewId(), dateCreation: new Date() }));
}

export async function login(username: string, password: string) {
    const user = getUserByName(username)

}

export default {
    getUserByName,
    saveUser
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
