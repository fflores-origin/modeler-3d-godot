import { UserRepository } from '../repositories/users.repository'
import { UserLoginDto } from '../schemas/dtos/users/users.models';
import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';

export async function getByUserName(name: string) {
    const user = await UserRepository.findByUsername(name);
    const response = {
        id: user._id,
        username: user.username
    }
    return response;
}

export async function login(data: UserLoginDto) {
    var user = await UserRepository.findByUsername(data.username);
    if (user==null) throw new Error("user not found");

    // if(bcrypt(data.password))


    const token = jwt.sign(
        {
            id: user._id,
            username: user.username
        },
        process.env.SECRET_KEY,
        { expiresIn: '1d' }
    );

    return { username: user.username, token: token };
}

export async function register(user: UserLoginDto) {
    Validation.username(user.username)
    Validation.password(user.password)
    const passwordHashed = await bcrypt.hash(user.password, 10);

    var found = UserRepository.findByUsername(user.username);
    if(found) throw new Error("User already exists");

    await UserRepository.create({ username: user.username, password: passwordHashed })
}

export async function logout() {
    // TODO: validar si es requerido
}

export async function recover(username: string) {

    UserRepository.findByUsername(username);

    // TODO: enviar mail

}

export default {
    getByUserName,
    login,
    register,
    logout,
    recover,
}


class Validation {
    static password(value: string) {
        if (value == null || value == undefined || value == "") throw new Error("password cant be null");
        if (value.length < 6) throw new Error("passwor lenght can't be less than 6");
    }

    static username(value: string) {
        if (value == null || value == undefined || value == "") throw new Error("user cant be null");
        if (value.length < 4) throw new Error("username lenght can't be less than 4");
    }
}
