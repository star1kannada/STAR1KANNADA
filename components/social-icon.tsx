const icons:Record<string,string>={facebook:'facebook-f.svg',treefe:'treefe.png',x:'x-twitter.svg',youtube:'youtube.svg',instagram:'instagram.svg',whatsapp:'whatsapp.svg'};
export default function SocialIcon({platform}:{platform:string}){
 const file=icons[platform];
 return file?<span className={'social-brand-icon social-brand-'+platform} aria-hidden="true"><img src={'/social/'+file} alt="" width={20} height={20}/></span>:null;
}
