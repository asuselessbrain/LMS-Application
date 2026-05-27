import { UserRole } from './../../prisma/generated/prisma/enums';
import { betterAuth } from "better-auth";
import { prismaAdapter } from "better-auth/adapters/prisma";
import { prisma } from "./prisma";


export const auth = betterAuth({
    database: prismaAdapter(prisma, {
        provider: "postgresql",
    }),
    emailPassword: {
        enable: true
    },
    user: {
        additionalFields: {
            role: {
                type: "string",
                required: true,
                default: UserRole.STUDENT
            },
            isBlocked: {
                type: "boolean",
                required: true,
                default: false
            },
            isDeleted: {
                type: "boolean",
                required: true,
                default: false
            },
            needPasswordReset: {
                type: "boolean",
                required: true,
                default: false
            }
        }
    }
});