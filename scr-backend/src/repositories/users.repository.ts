import { User } from "../schemas/user.schema";
import { NewId, Save } from "./base.repository";

export async function getUserByName(name: string) {
    return await User.findOne({ userName: name });
}

export async function saveUser(user: any) {
    Save(new User({ _id: NewId(), dateCreation: new Date() }));
}

export default {
    getUserByName,
    saveUser
}
