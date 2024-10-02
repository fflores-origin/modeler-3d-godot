import repository from '../repositories/users.repository'
import { UserLoginDto } from '../schemas/dtos/users/users.models';

export async function getByUserName(name: string) {
    return await repository.getUserByName(name);
}

export async function loginUser(data: UserLoginDto) {
    return data;
}

export default {
    getByUserName,
    loginUser
}