import dotenv from "dotenv";
import path from "path";

dotenv.config({path: path.join(process.cwd(), ".env")});

export const config = {
    port: process.env.PORT || 5000,
    node_env: process.env.NODE_ENV || "development",
    better_auth_secret: process.env.BETTER_AUTH_SECRET,
    better_auth_url: process.env.BETTER_AUTH_URL
}
