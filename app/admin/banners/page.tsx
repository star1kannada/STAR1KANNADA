import type {Metadata} from 'next';
import AdminPanel from '../panel';
export const metadata:Metadata={title:'STAR1 Kannada | Homepage banners',robots:{index:false,follow:false}};
export default function Page(){return <AdminPanel section="banners"/>;}
