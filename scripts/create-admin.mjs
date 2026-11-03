// Run only on your computer. Never import this script into the website.
import {createClient} from '@supabase/supabase-js';
const url=process.env.NEXT_PUBLIC_SUPABASE_URL;
const key=process.env.SUPABASE_SECRET_KEY||process.env.SUPABASE_SERVICE_ROLE_KEY;
const email=process.env.ADMIN_EMAIL?.trim();
const password=process.env.ADMIN_PASSWORD;
if(!url||!key||!email||!password){
 console.error('Missing setup values. Fill .env.admin.local from .env.admin.example, then run npm run admin:create.');process.exit(1);
}
const client=createClient(url,key,{auth:{persistSession:false,autoRefreshToken:false}});
const {data,error}=await client.auth.admin.createUser({email,password,email_confirm:true,app_metadata:{role:'admin'}});
if(error){console.error('Admin was not created: '+error.message);console.error('If the email already exists, grant its admin role using supabase/admin-access.sql. Existing passwords are not overwritten.');process.exit(1);}
console.log('Admin created: '+data.user.email);
console.log('Login: http://localhost:3100/admin/login/');
console.log('Use ADMIN_EMAIL and ADMIN_PASSWORD from your private .env.admin.local file.');
