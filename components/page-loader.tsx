'use client';
import {useEffect,useState} from 'react';
export default function PageLoader(){
 const[loading,setLoading]=useState(true);
 useEffect(()=>{const done=()=>setLoading(false);if(document.readyState==='complete'){done();return}window.addEventListener('load',done,{once:true});const timeout=setTimeout(done,8000);return()=>{window.removeEventListener('load',done);clearTimeout(timeout)}},[]);
 if(!loading)return null;
 return <div className="page-loader" role="status" aria-live="polite"><img src="/logo-web.png" alt="STAR1 Kannada"/><span className="site-loader-ring"/><span>Loading…</span></div>
}
