export type ContentKind = 'events' | 'banners' | 'gallery' | 'partners';
export type ContentRow = {
  id: string; slug?: string; title_en?: string; title_kn?: string;
  name_en?: string; name_kn?: string; subtitle_en?: string; subtitle_kn?: string;
  description_en?: string; description_kn?: string; category_label_en?: string; category_label_kn?: string;
  starts_at?: string | null; venue_en?: string; venue_kn?: string; status?: string;
  label_en?: string; label_kn?: string; tag_en?: string; tag_kn?: string;
  line1_en?: string; line1_kn?: string; line2_en?: string; line2_kn?: string;
  body_en?: string; body_kn?: string; cta_en?: string; cta_kn?: string; link_url?: string;
  alt_en?: string; alt_kn?: string; image_url?: string; image_path?: string | null;
  logo_url?: string; logo_path?: string | null; website_url?: string;
  sort_order: number; is_published: boolean; is_sample?: boolean;
};
export const CONTENT_KINDS: ContentKind[] = ['events','banners','gallery','partners'];
export const MEDIA_BUCKET = 'site-media';
export const MAX_IMAGE_SIZE = 5 * 1024 * 1024;
export const IMAGE_TYPES = ['image/jpeg','image/png','image/webp','image/avif'];
export function safeLink(value: string, allowAnchor = true): string {
  const text = value.trim();
  if (allowAnchor && /^#[a-zA-Z][\w-]*$/.test(text)) return text;
  if (allowAnchor && /^\/(?!\/)[a-zA-Z0-9/_-]*(?:#[a-zA-Z][\w-]*)?$/.test(text)) return text;
  try { const url = new URL(text); return ['http:','https:'].includes(url.protocol) ? url.href : ''; } catch { return ''; }
}
export function validImageUrl(value: string): boolean {
  return /^\/(?!\/)[a-zA-Z0-9_./%-]+$/.test(value) || !!safeLink(value, false);
}
export function imageFields(kind:ContentKind){return kind==='partners'?{url:'logo_url' as const,path:'logo_path' as const}:{url:'image_url' as const,path:'image_path' as const};}
export function titleOf(row:ContentRow){return row.title_en||row.name_en||row.label_en||row.line1_en||'Untitled';}
export function toISTInput(value:string|null|undefined){
  if(!value)return '';
  const date=new Date(value);if(Number.isNaN(date.getTime()))return '';
  const p=Object.fromEntries(new Intl.DateTimeFormat('en-CA',{timeZone:'Asia/Kolkata',year:'numeric',month:'2-digit',day:'2-digit',hour:'2-digit',minute:'2-digit',hourCycle:'h23'}).formatToParts(date).map(x=>[x.type,x.value]));
  return `${p.year}-${p.month}-${p.day}T${p.hour}:${p.minute}`;
}
export function fromISTInput(value:string){const date=new Date(value+':00+05:30');if(Number.isNaN(date.getTime()))throw Error('Enter a valid event date and time.');return date.toISOString();}
