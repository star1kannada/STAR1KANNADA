import type { Metadata } from 'next';
import { DM_Sans, Fraunces, Noto_Sans_Kannada, Noto_Serif_Kannada } from 'next/font/google';
import './globals.css';
import PageLoader from '../components/page-loader';
import './public.css';
const serif=Fraunces({subsets:['latin'],style:['normal','italic'],variable:'--f-serif',display:'swap'});
const sans=DM_Sans({subsets:['latin'],variable:'--f-sans',display:'swap'});
const serifKn=Noto_Serif_Kannada({subsets:['kannada'],variable:'--f-serif-kn',display:'swap'});
const sansKn=Noto_Sans_Kannada({subsets:['kannada'],variable:'--f-sans-kn',display:'swap'});
export const metadata: Metadata={title:'Star 1 Kannada | ನಮ್ಮ ನಾಡು. ನಮ್ಮ ಧ್ವನಿ.',description:'Discover Star 1 Kannada — news, culture and community. Explore our programmes and events celebrating Karnataka.',icons:{icon:'/logo-web.png'}};
export default function Layout({children}:{children:React.ReactNode}){return <html lang="en" className={[serif.variable,sans.variable,serifKn.variable,sansKn.variable].join(' ')}><body><PageLoader/>{children}</body></html>}
