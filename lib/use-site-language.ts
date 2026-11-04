'use client';
import {useEffect,useState} from 'react';
export function useSiteLanguage(){const[kn,setKn]=useState(false);useEffect(()=>{setKn(localStorage.getItem('star1-language')==='kn')},[]);const change=(value:boolean)=>{setKn(value);localStorage.setItem('star1-language',value?'kn':'en');document.documentElement.lang=value?'kn':'en'};useEffect(()=>{document.documentElement.lang=kn?'kn':'en'},[kn]);return {kn,setKn:change,t:(en:string,ka:string)=>kn?ka:en}}
