import type { Metadata } from 'next';
import AdminPanel from './panel';
export const metadata:Metadata={title:'STAR1 Kannada | Content administration',robots:{index:false,follow:false}};
export default function AdminPage(){return <AdminPanel/>;}
