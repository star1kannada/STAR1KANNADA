import {Facebook,Instagram,Youtube,MessageCircle,Link2} from 'lucide-react';
export default function SocialIcon({platform}:{platform:string}){
const props={size:19,'aria-hidden':true as const};
if(platform==='facebook')return <Facebook {...props}/>;
if(platform==='instagram')return <Instagram {...props}/>;
if(platform==='youtube')return <Youtube {...props}/>;
if(platform==='whatsapp')return <MessageCircle {...props}/>;
if(platform==='x')return <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor" aria-hidden="true"><path d="M18.9 2H22l-6.8 7.8L23.2 22h-6.3L12 14.6 5.5 22H2.3l8.2-9.4L.8 2h6.5l4.4 6.6L18.9 2Zm-1.1 18h1.7L6.4 3.9H4.6L17.8 20Z"/></svg>;
return <Link2 {...props}/>;
}
