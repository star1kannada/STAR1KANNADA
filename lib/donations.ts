export const DONATION_PAYEE='RAASAA KA AND KALA SAMSKRUTI CT';
export const DONATION_UPI='9164399231@hdfc';
export const PROOF_BUCKET='donation-proofs';
export const PROOF_TYPES=['image/jpeg','image/png','image/webp'];
export const PROOF_LIMIT=5*1024*1024;
export const PURPOSE_LABELS:Record<string,string>={news:'Kannada stories',culture:'Culture & community',awareness:'Awareness & learning'};
export function donationLink(amount:string,purpose:string){const value=Number(amount);if(!Number.isFinite(value)||Number(value.toFixed(2))<=0||value>=10000000000)return '';return 'upi://pay?'+new URLSearchParams({pa:DONATION_UPI,pn:DONATION_PAYEE,mc:'0000',cu:'INR',am:value.toFixed(2),tn:'STAR1 Kannada donation: '+(PURPOSE_LABELS[purpose]||'Kannada stories')}).toString().replace(/\+/g,'%20')}
export function proofPath(id:string,type:string){if(!/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/.test(id)||!PROOF_TYPES.includes(type))throw new Error('Invalid proof file.');return 'proofs/'+id+'/proof.'+(type==='image/jpeg'?'jpg':type==='image/png'?'png':'webp')}
export type DonationSubmission={id:string;donor_name:string;donor_contact:string;purpose:string;amount:number;transaction_ref:string;paid_at:string;proof_path:string;status:'pending'|'verified'|'rejected';review_note:string;reviewed_at:string|null;created_at:string};
