/*
  Warnings:

  - You are about to drop the column `userId` on the `educations` table. All the data in the column will be lost.
  - You are about to drop the `StudentProfile` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `studentId` to the `educations` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "UserRole" AS ENUM ('ADMIN', 'STUDENT', 'INSTRUCTOR');

-- DropForeignKey
ALTER TABLE "Address" DROP CONSTRAINT "Address_studentId_fkey";

-- DropForeignKey
ALTER TABLE "StudentProfile" DROP CONSTRAINT "StudentProfile_id_fkey";

-- DropForeignKey
ALTER TABLE "educations" DROP CONSTRAINT "educations_userId_fkey";

-- AlterTable
ALTER TABLE "educations" DROP COLUMN "userId",
ADD COLUMN     "studentId" TEXT NOT NULL,
ALTER COLUMN "institution" DROP NOT NULL,
ALTER COLUMN "degree" DROP NOT NULL,
ALTER COLUMN "fieldOfStudy" DROP NOT NULL,
ALTER COLUMN "startDate" DROP NOT NULL;

-- AlterTable
ALTER TABLE "user" ADD COLUMN     "Role" "UserRole" NOT NULL DEFAULT 'STUDENT',
ADD COLUMN     "isBlocked" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "isDeleted" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "needPasswordReset" BOOLEAN NOT NULL DEFAULT false;

-- DropTable
DROP TABLE "StudentProfile";

-- CreateTable
CREATE TABLE "student_profiles" (
    "id" TEXT NOT NULL,
    "fullName" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "studentId" TEXT NOT NULL,
    "phoneNumber" TEXT NOT NULL,
    "whatsAppNumber" TEXT,
    "gender" "Gender",
    "dateOfBirth" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "student_profiles_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "student_profiles_email_key" ON "student_profiles"("email");

-- CreateIndex
CREATE UNIQUE INDEX "student_profiles_studentId_key" ON "student_profiles"("studentId");

-- CreateIndex
CREATE UNIQUE INDEX "student_profiles_phoneNumber_key" ON "student_profiles"("phoneNumber");

-- CreateIndex
CREATE INDEX "idx_student_email" ON "student_profiles"("email");

-- CreateIndex
CREATE INDEX "idx_student_id" ON "student_profiles"("studentId");

-- CreateIndex
CREATE INDEX "idx_education_studentId" ON "educations"("studentId");

-- CreateIndex
CREATE INDEX "idx_education_institution" ON "educations"("institution");

-- AddForeignKey
ALTER TABLE "Address" ADD CONSTRAINT "Address_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "student_profiles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "educations" ADD CONSTRAINT "educations_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "student_profiles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "student_profiles" ADD CONSTRAINT "student_profiles_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE CASCADE;
