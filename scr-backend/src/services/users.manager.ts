import repository from '../repositories/users.repository'
import { UserLoginDto } from '../schemas/dtos/users/users.models';

export async function getByUserName(name: string) {
    return await repository.getUsername(name);
}

export async function login(data: UserLoginDto) {
    var user = await repository.getUsername(data.username);

    if (user == null) {
        throw new Error("user not found")
    }

    return user;
}

export async function register(user: UserLoginDto) {
    if (user == null) throw new Error("wrong data send")
    if (user.username == "") throw new Error("user can't be null")
    if (user.username.length < 4) throw new Error("username is too short")
    if (user.password == "") throw new Error("password can't be null")
    if (user.password.length < 10) throw new Error("password do not meet required security")
    await repository.create({ username: user.username, password: user.password })
}

export default {
    getByUserName,
    login
}
