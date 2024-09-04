import repository from '../repositories/users.repository'

export async function getByUserName(name: string) {
    return await repository.getUserByName(name);
}

export default {
    getByUserName
}