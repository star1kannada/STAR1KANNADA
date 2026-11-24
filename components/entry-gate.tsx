'use client';
import {useEffect,useState,type FormEvent} from 'react';
import {usePathname} from 'next/navigation';
import {ArrowRight,ArrowUpRight,Check,Copy,Heart,ShieldCheck} from 'lucide-react';
import {useSiteLanguage} from '../lib/use-site-language';
import {DONATION_UPI,DONATION_PAYEE,donationLink} from '../lib/donations';

const PASS_KEY='star1-entry-pass';
const MIN_AMOUNT=5;
const PRESETS=[5,11,21,51,101];
// Pages that stay open without the entry pass.
const OPEN_PATHS=['/donate','/admin'];

export default function EntryGate(){
 const pathname=usePathname()||'/';
 const{kn,setKn,t}=useSiteLanguage();
 const[open,setOpen]=useState(false);
 const[step,setStep]=useState<1|2>(1);
 const[amount,setAmount]=useState('11');
 const[utr,setUtr]=useState('');
 const[copied,setCopied]=useState(false);
 const[error,setError]=useState('');
 const[leaving,setLeaving]=useState(false);

 const exempt=OPEN_PATHS.some(p=>pathname===p||pathname.startsWith(p+'/'));
 useEffect(()=>{if(exempt){setOpen(false);return}try{setOpen(!localStorage.getItem(PASS_KEY))}catch{setOpen(true)}},[exempt]);
 useEffect(()=>{if(!open)return;const prev=document.body.style.overflow;document.body.style.overflow='hidden';return()=>{document.body.style.overflow=prev}},[open]);
 if(!open)return null;

 const value=Number(amount);
 const valid=Number.isFinite(value)&&value>=MIN_AMOUNT;
 const link=valid?donationLink(amount,'news'):'';

 function next(){if(!valid){setError(t(`Minimum entry amount is ₹${MIN_AMOUNT}.`,`ಕನಿಷ್ಠ ಪ್ರವೇಶ ಮೊತ್ತ ₹${MIN_AMOUNT}.`));return}setError('');setStep(2)}
 function enter(e:FormEvent){e.preventDefault();const ref=utr.trim();if(!/^[A-Za-z0-9]{6,30}$/.test(ref)){setError(t('Enter the UTR / transaction ID from your payment app (6–30 letters or digits).','ನಿಮ್ಮ ಪಾವತಿ ಆ್ಯಪ್‌ನ UTR / ವಹಿವಾಟು ಸಂಖ್ಯೆ ನಮೂದಿಸಿ (6–30 ಅಕ್ಷರ/ಅಂಕಿ).'));return}
  try{localStorage.setItem(PASS_KEY,JSON.stringify({amount:value,utr:ref,at:new Date().toISOString()}))}catch{}
  setLeaving(true);setTimeout(()=>setOpen(false),650)}

 return <div className={'entry-gate'+(leaving?' leaving':'')} role="dialog" aria-modal="true" aria-labelledby="entry-title">
  <div className="entry-glow" aria-hidden="true"/>
  <button type="button" className="entry-lang" onClick={()=>setKn(!kn)}>{kn?'English':'ಕನ್ನಡ'}</button>
  <div className="entry-ticket">
   <aside className="entry-stub">
    <img src="/logo-web.png" alt="STAR1 Kannada"/>
    <span className="entry-kicker">{t('ENTRY PASS','ಪ್ರವೇಶ ಪಾಸ್')}</span>
    <strong className="entry-min">₹{MIN_AMOUNT}<small>+</small></strong>
    <p>{t('A small token to keep Kannada stories alive.','ಕನ್ನಡ ಕಥೆಗಳ ಉಳಿವಿಗೆ ಒಂದು ಸಣ್ಣ ಕಾಣಿಕೆ.')}</p>
    <ol className="entry-steps" aria-label={t('Steps','ಹಂತಗಳು')}>
     <li className={step===1?'on':'done'}><span>{step>1?<Check size={13}/>:'1'}</span>{t('Choose & pay','ಆಯ್ಕೆ ಮಾಡಿ ಪಾವತಿಸಿ')}</li>
     <li className={step===2?'on':''}><span>2</span>{t('Confirm & enter','ದೃಢೀಕರಿಸಿ ಪ್ರವೇಶಿಸಿ')}</li>
    </ol>
   </aside>
   <section className="entry-main">
    {step===1?<>
     <span className="entry-eyebrow">{t('WELCOME TO STAR1 KANNADA','ಸ್ಟಾರ್1 ಕನ್ನಡಕ್ಕೆ ಸ್ವಾಗತ')}</span>
     <h1 id="entry-title">{t('Support to','ಬೆಂಬಲಿಸಿ')} <em>{t('step inside.','ಒಳಗೆ ಬನ್ನಿ.')}</em></h1>
     <p className="entry-sub">{t(`Donate ₹${MIN_AMOUNT} or more by UPI to enter the site.`,`ಜಾಲತಾಣ ಪ್ರವೇಶಿಸಲು UPI ಮೂಲಕ ₹${MIN_AMOUNT} ಅಥವಾ ಹೆಚ್ಚು ದೇಣಿಗೆ ನೀಡಿ.`)}</p>
     <div className="entry-chips" role="group" aria-label={t('Amount','ಮೊತ್ತ')}>
      {PRESETS.map(v=><button type="button" key={v} aria-pressed={value===v} className={value===v?'on':''} onClick={()=>{setAmount(String(v));setError('')}}>₹{v}</button>)}
     </div>
     <label className="entry-custom">{t('Or enter your amount','ಅಥವಾ ನಿಮ್ಮ ಮೊತ್ತ ನಮೂದಿಸಿ')}<span><b>₹</b><input type="number" inputMode="decimal" min={MIN_AMOUNT} step="1" value={amount} onChange={e=>{setAmount(e.target.value);setError('')}}/></span></label>
     <div className="entry-pay">
      <img src="/donations/upi-qr.png" alt={t('UPI QR code for '+DONATION_UPI,'UPI QR ಕೋಡ್ '+DONATION_UPI)}/>
      <div>
       <p className="entry-pay-amt">₹{valid?value.toLocaleString('en-IN'):'—'}</p>
       <p className="entry-pay-hint">{t('Scan with any UPI app and enter this amount.','ಯಾವುದೇ UPI ಆ್ಯಪ್‌ನಲ್ಲಿ ಸ್ಕ್ಯಾನ್ ಮಾಡಿ ಈ ಮೊತ್ತ ನಮೂದಿಸಿ.')}</p>
       <div className="entry-upi"><code>{DONATION_UPI}</code><button type="button" aria-label={t('Copy UPI ID','UPI ಐಡಿ ನಕಲಿಸಿ')} onClick={async()=>{try{await navigator.clipboard.writeText(DONATION_UPI);setCopied(true)}catch{}}}>{copied?<Check size={15}/>:<Copy size={15}/>}</button></div>
       <p className="entry-payee">{DONATION_PAYEE}</p>
      </div>
     </div>
     {error&&<p className="entry-error" role="alert">{error}</p>}
     <div className="entry-actions">
      <a className="entry-btn gold" href={link||undefined} aria-disabled={!link}><Heart size={16}/>{t('Pay with UPI app','UPI ಆ್ಯಪ್‌ನಲ್ಲಿ ಪಾವತಿಸಿ')}<ArrowUpRight size={16}/></a>
      <button type="button" className="entry-btn ghost" onClick={next}>{t('I have paid','ನಾನು ಪಾವತಿಸಿದ್ದೇನೆ')}<ArrowRight size={16}/></button>
     </div>
    </>:<form onSubmit={enter}>
     <span className="entry-eyebrow">{t('ALMOST THERE','ಇನ್ನೇನು ಮುಗಿಯಿತು')}</span>
     <h1 id="entry-title">{t('Thank you for','ನಿಮ್ಮ ಬೆಂಬಲಕ್ಕೆ')} <em>{t('your support.','ಧನ್ಯವಾದಗಳು.')}</em></h1>
     <p className="entry-sub">{t(`Enter the UTR / transaction ID of your ₹${value.toLocaleString('en-IN')} payment to unlock the site.`,`ನಿಮ್ಮ ₹${value.toLocaleString('en-IN')} ಪಾವತಿಯ UTR / ವಹಿವಾಟು ಸಂಖ್ಯೆ ನಮೂದಿಸಿ.`)}</p>
     <label className="entry-custom">{t('UTR / Transaction ID','UTR / ವಹಿವಾಟು ಸಂಖ್ಯೆ')}<span><input autoFocus autoComplete="off" maxLength={30} placeholder="e.g. 431298765432" value={utr} onChange={e=>{setUtr(e.target.value);setError('')}}/></span></label>
     <p className="entry-pay-hint"><ShieldCheck size={14}/> {t('Payments are checked against our UPI records.','ಪಾವತಿಗಳನ್ನು ನಮ್ಮ UPI ದಾಖಲೆಗಳೊಂದಿಗೆ ಪರಿಶೀಲಿಸಲಾಗುತ್ತದೆ.')}</p>
     {error&&<p className="entry-error" role="alert">{error}</p>}
     <div className="entry-actions">
      <button type="submit" className="entry-btn gold">{t('Enter Star1 Kannada','ಸ್ಟಾರ್1 ಕನ್ನಡ ಪ್ರವೇಶಿಸಿ')}<ArrowRight size={16}/></button>
      <button type="button" className="entry-btn ghost" onClick={()=>{setStep(1);setError('')}}>{t('Back','ಹಿಂದೆ')}</button>
     </div>
    </form>}
    <a className="entry-more" href="/donate/">{t('Want to give more or bank transfer? Open the full donate page','ಹೆಚ್ಚು ದೇಣಿಗೆ ಅಥವಾ ಬ್ಯಾಂಕ್ ವರ್ಗಾವಣೆ? ಪೂರ್ಣ ದೇಣಿಗೆ ಪುಟ ತೆರೆಯಿರಿ')}<ArrowUpRight size={13}/></a>
   </section>
  </div>
 </div>
}
