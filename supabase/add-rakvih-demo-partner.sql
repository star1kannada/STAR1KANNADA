-- Optional: save the demo card in Supabase so it also appears in Admin.
-- The website currently includes this labelled demo when no Rakvih row is present.
insert into public.partners
(slug,name_en,name_kn,subtitle_en,subtitle_kn,logo_url,website_url,sort_order,is_sample,is_published)
values
('rakvih-demo','Rakvih','ರಕ್ವಿಹ್','Solutions Private Limited','ಸೊಲ್ಯೂಷನ್ಸ್ ಪ್ರೈವೇಟ್ ಲಿಮಿಟೆಡ್','/partners/rakvih-logo.png','https://www.rakvih.in/',1,true,true)
on conflict(slug) do update set name_en=excluded.name_en,name_kn=excluded.name_kn,subtitle_en=excluded.subtitle_en,subtitle_kn=excluded.subtitle_kn,logo_url=excluded.logo_url,website_url=excluded.website_url,is_sample=true,is_published=true;
