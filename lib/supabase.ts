import { createClient, type SupabaseClient } from '@supabase/supabase-js';
const url = process.env.NEXT_PUBLIC_SUPABASE_URL?.trim() || '';
const key = process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY?.trim() || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY?.trim() || '';
export const supabaseConfigured = /^https?:\/\//.test(url) && !/YOUR_PROJECT|REPLACE|example/i.test(url + key) && !!key;
let client: SupabaseClient | null = null;
export function getSupabase(): SupabaseClient | null {
  if (!supabaseConfigured) return null;
  if (!client) client = createClient(url, key, {auth:{persistSession:true,autoRefreshToken:true,detectSessionInUrl:false}});
  return client;
}
