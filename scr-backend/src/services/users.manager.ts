import repository from '../repositories/users.repository'
import { UserLoginDto } from '../schemas/dtos/users/users.models';
import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';

export async function getByUserName(name: string) {
    const user = await repository.getUsername(name);
    const response = {
        id: user._id,
        username: user.username
    }
    return response;
}

export async function login(data: UserLoginDto) {
    var user = await repository.getUsername(data.username);

    if (user == null) throw new Error("user not found");

    const token = jwt.sign(
        {
            id: user._id,
            username: user.username
        },
        process.env.SECRET_KEY,
        { expiresIn: '1d' }
    );

    return token;
}

export async function register(user: UserLoginDto) {
    Validation.username(user.username)
    Validation.password(user.password)
    const passwordHashed = await bcrypt.hash(user.password, 10);
    await repository.create({ username: user.username, password: passwordHashed })
}

export default {
    getByUserName,
    login
}


class Validation {
    static password(value: string) {
        if (value == null || value == undefined || value == "") throw new Error("password cant be null");
        if (value.length < 6) throw new Error("lenght can't be less than 6");
    }

    static username(value: string) {
        if (value == null || value == undefined || value == "") throw new Error("user cant be null");
        if (value.length < 4) throw new Error("lenght can't be less than 4");
    }
}
