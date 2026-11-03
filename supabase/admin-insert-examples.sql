-- OPTIONAL INSERT EXAMPLES: replace sample values and image URLs before running.
-- These examples are drafts (is_published=false). Publish from the admin panel.
-- Upload actual images using Admin or Storage Dashboard, bucket site-media.
-- image_path/logo_path is the bucket-relative path, e.g. gallery/photo.jpg.
-- image_url/logo_url is the corresponding public URL. SQL does not upload files.
-- Local bundled /newsroom.jpg is used below so the example banner has a valid image.

insert into public.banners
(slug,label_en,label_kn,tag_en,tag_kn,line1_en,line1_kn,line2_en,line2_kn,body_en,body_kn,cta_en,cta_kn,link_url,alt_en,alt_kn,image_url,sort_order,is_published)
values
('example-banner','News update','ಸುದ್ದಿ ಮಾಹಿತಿ','STAR1 KANNADA','ಸ್ಟಾರ್1 ಕನ್ನಡ','Your news. Your world.','ನಿಮ್ಮ ಸುದ್ದಿ. ನಿಮ್ಮ ಜಗತ್ತು.','In Kannada.','ಕನ್ನಡದಲ್ಲಿ.','Stories from Karnataka.','ಕರ್ನಾಟಕದ ಸುದ್ದಿಗಳು.','Explore events','ಕಾರ್ಯಕ್ರಮಗಳನ್ನು ನೋಡಿ','#events','News studio','ಸುದ್ದಿ ಸ್ಟುಡಿಯೋ','/newsroom.jpg',4,false)
on conflict(slug) do nothing;

insert into public.events
(slug,title_en,title_kn,description_en,description_kn,category_label_en,category_label_kn,starts_at,ends_at,venue_en,venue_kn,image_url,image_path,sort_order,status,is_sample,is_published)
values
('example-community-event','Sample community event','ಮಾದರಿ ಸಮುದಾಯ ಕಾರ್ಯಕ್ರಮ','Replace with your real event details.','ನಿಮ್ಮ ಕಾರ್ಯಕ್ರಮದ ವಿವರಗಳನ್ನು ಇಲ್ಲಿ ಸೇರಿಸಿ.','Community','ಸಮುದಾಯ','2027-01-15 17:00:00+05:30','2027-01-15 20:00:00+05:30','Bengaluru','ಬೆಂಗಳೂರು','/newsroom.jpg',null,1,'upcoming',true,false)
on conflict(slug) do nothing;

insert into public.gallery
(id,title_en,title_kn,alt_en,alt_kn,image_url,image_path,sort_order,is_published)
values
('fd660c34-dc91-4f26-a025-676fbce417e1','Sample studio photo','ಮಾದರಿ ಸ್ಟುಡಿಯೋ ಚಿತ್ರ','News studio sample','ಸುದ್ದಿ ಸ್ಟುಡಿಯೋ ಮಾದರಿ','/newsroom.jpg',null,1,false)
on conflict(id) do nothing;

insert into public.partners
(slug,name_en,name_kn,subtitle_en,subtitle_kn,logo_url,logo_path,website_url,sort_order,is_sample,is_published)
values
('example-partner','Sample partner','ಮಾದರಿ ಪಾಲುದಾರ','Replace with an actual partner','ನಿಜವಾದ ಪಾಲುದಾರರ ವಿವರಗಳನ್ನು ಸೇರಿಸಿ',null,null,null,1,true,false)
on conflict(slug) do nothing;
