import type { Metadata } from 'next';
import './globals.css';
export const metadata: Metadata={title:'Star 1 Kannada | ನಮ್ಮ ನಾಡು. ನಮ್ಮ ಧ್ವನಿ.',description:'Discover Star 1 Kannada — news, culture and community. Explore our programmes and events celebrating Karnataka.'};
export default function Layout({children}:{children:React.ReactNode}){return <html lang="kn"><body>{children}</body></html>}
