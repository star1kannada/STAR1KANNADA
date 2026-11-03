'use client';
import {useEffect,useState} from 'react';
import {getSupabase,supabaseConfigured} from './supabase';
import {CONTENT_KINDS,type ContentKind,type ContentRow} from './cms-types';
type ContentState=Record<ContentKind,ContentRow[]>;
const empty:ContentState={events:[],banners:[],gallery:[],partners:[]};
export function usePublicContent(){
 const [content,setContent]=useState<ContentState>(empty);const[loading,setLoading]=useState(supabaseConfigured);const[error,setError]=useState(false);
 useEffect(()=>{const db=getSupabase();if(!db)return;let alive=true;let active=false;
  const refresh=async()=>{if(active)return;active=true;
   try{const results=await Promise.all(CONTENT_KINDS.map(kind=>{let q=db.from(kind).select('*').eq('is_published',true).order('sort_order',{ascending:true}).order('id');if(kind==='events')q=q.eq('status','upcoming');return q;}));
    if(alive){setError(results.some(r=>r.error));setContent(old=>{const next={...old};results.forEach((r,i)=>{if(!r.error)next[CONTENT_KINDS[i]]=r.data as ContentRow[]});return next});}
   }catch{if(alive)setError(true)}finally{active=false;if(alive)setLoading(false)}
  };
  void refresh();window.addEventListener('focus',refresh);const timer=window.setInterval(()=>{if(!document.hidden)void refresh()},60000);
  return()=>{alive=false;window.removeEventListener('focus',refresh);clearInterval(timer)};
 },[]);
 return {configured:supabaseConfigured,content,loading,error};
}
