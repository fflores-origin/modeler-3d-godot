import { User } from "../schemas/user.schema";
import { NewId, Save, toObjectId } from "./base.repository";

export class UserRepository {
    static async create({ username, password }) {
        await Save(new User({
            _id: NewId(),
            username,
            password,
            isBlocked: false,
            dateCreation: new Date()
        }));
    }

    static async delete(id: string) {
        await User.deleteOne({ _id: id });
    }

    static async upsert(data: any) {
        if (data.id) {
            data.dateUpdate = new Date();
            await User.findOneAndUpdate({ _id: data.id }, data, { upsert: true, new: true, setDefaultsOnInsert: true })
            return;
        }

        await Save(new User({
            _id: NewId(),
            username: data.username,
            password: data.password,
            dateCreation: new Date(),
            status: 1
        }))
    }

    static async findById(id: string) {
        return await User.findById(id);
    }

    static async findByUsername(name: string) {
        return await User.findOne({ username: name });
    }
}
