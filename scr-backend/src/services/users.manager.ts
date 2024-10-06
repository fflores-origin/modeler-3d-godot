import repository from '../repositories/users.repository'
import { UserLoginDto } from '../schemas/dtos/users/users.models';

export async function getByUserName(name: string) {
    return await repository.getUserByName(name);
}

export async function loginUser(data: UserLoginDto) {
    var user = await repository.getUserByName(data.username);

    if (user != null) {
        throw new Error("user not found")
    }

    return user;
}

export default {
    getByUserName,
    loginUser
}

export class UserService {
    
}