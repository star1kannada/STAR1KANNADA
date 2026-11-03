import type {Metadata} from 'next';
import AdminPanel from '../panel';
export const metadata:Metadata={title:'STAR1 Kannada | Gallery',robots:{index:false,follow:false}};
export default function Page(){return <AdminPanel section="gallery"/>;}
