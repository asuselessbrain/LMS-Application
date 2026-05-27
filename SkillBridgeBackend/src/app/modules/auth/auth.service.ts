import { auth } from "../../../lib/auth";
import { prisma } from "../../../lib/prisma";
import AppError from "../../errors/appError";

interface IStudent {
    fullName: string;
    email: string;
    phoneNumber: string;
    password: string;
}

const createStudent = async (payload: IStudent) => {
    const { fullName, email, phoneNumber, password } = payload;

    const data = await auth.api.signUpEmail({
        body: {
            name: fullName,
            email,
            password
        }
    })

    if(!data.user) {
        throw new AppError("Failed to create user", 500);
    }

    const student = await prisma.$transaction(async (tx) => {
        const studentProfile = await tx.studentProfile.create({
            data: {
                studentId: data.user.id,
                phoneNumber,
                fullName,
                email,
            }
        })

        await tx.education.create({
            data:{
                studentId: studentProfile.id,
            }
        })

        await tx.address.create({
            data:{
                studentId: studentProfile.id,
            }
        })

        return studentProfile;
    })

    return student;
}

export const AuthService = {
    createStudent
}