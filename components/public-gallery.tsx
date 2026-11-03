'use client';
import {useRef,useState} from 'react';
import {X,ArrowUpRight} from 'lucide-react';
import {validImageUrl,type ContentRow} from '../lib/cms-types';
export default function PublicGallery({photos,kn}:{photos:ContentRow[];kn:boolean}){
 const dialog=useRef<HTMLDialogElement>(null);const[selected,setSelected]=useState<ContentRow|null>(null);
 if(!photos.length)return null;
 return <section id="gallery" className="section cms-public-gallery"><div className="section-heading"><div><div className="eyebrow">{kn?'ನಮ್ಮ ಕ್ಷಣಗಳು':'MOMENTS FROM STAR1'}</div><h2>{kn?'ನಮ್ಮ':'Our'} <em>{kn?'ಚಿತ್ರಸಂಪುಟ.':'gallery.'}</em></h2><p>{kn?'ನಮ್ಮ ಕಾರ್ಯಕ್ರಮಗಳು ಮತ್ತು ಸಮುದಾಯದ ಕ್ಷಣಗಳು.':'A closer look at our programmes and community moments.'}</p></div></div><div className="cms-gallery-grid">{photos.filter(photo=>photo.image_url&&validImageUrl(photo.image_url)).map(photo=><button key={photo.id} onClick={()=>{setSelected(photo);dialog.current?.showModal()}} aria-label={(kn?'ಚಿತ್ರ ನೋಡಿ: ':'View photo: ')+(kn?photo.title_kn:photo.title_en)}><img src={photo.image_url} loading="lazy" alt={(kn?photo.alt_kn:photo.alt_en)||(kn?photo.title_kn:photo.title_en)||''}/><span>{kn?photo.title_kn:photo.title_en}<ArrowUpRight size={18}/></span></button>)}</div><dialog ref={dialog} className="cms-lightbox" onClick={e=>{if(e.target===e.currentTarget)dialog.current?.close()}}><button autoFocus className="cms-lightbox-close" aria-label={kn?'ಮುಚ್ಚಿ':'Close image'} onClick={()=>dialog.current?.close()}><X/></button>{selected&&<figure><img src={selected.image_url} alt={(kn?selected.alt_kn:selected.alt_en)||''}/><figcaption>{kn?selected.title_kn:selected.title_en}</figcaption></figure>}</dialog></section>
}
