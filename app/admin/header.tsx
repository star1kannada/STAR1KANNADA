import {ArrowUpRight,CalendarDays,Images,PanelsTopLeft,Handshake,ShieldCheck} from 'lucide-react';
const sections=[
 {key:'events',label:'Upcoming events',Icon:CalendarDays},
 {key:'banners',label:'Homepage banners',Icon:PanelsTopLeft},
 {key:'gallery',label:'Gallery',Icon:Images},
 {key:'partners',label:'Partners',Icon:Handshake},
 {key:'donations',label:'Donation proofs',Icon:ShieldCheck},
];
export default function AdminHeader({active,showNavigation}:{active:string;showNavigation:boolean}){
 return <div className="cms-navigation"><div className="cms-navigation-inner"><a className="cms-brand" href="/admin/"><img src="/logo-web.png" alt=""/><span>STAR1 Kannada<small>ADMIN WORKSPACE</small></span></a><a className="cms-website" href="/">View website<ArrowUpRight size={16}/></a></div>{showNavigation&&<nav aria-label="Admin sections">{sections.map(({key,label,Icon})=><a key={key} className={active===key?'active':''} href={'/admin/'+key+'/'} aria-current={active===key?'page':undefined}><Icon size={17}/>{label}</a>)}</nav>}</div>
}
