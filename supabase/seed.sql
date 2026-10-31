-- Run after schema.sql. User-supplied organization and leadership information.

begin;

insert into public.people (slug,name_en,name_kn,title_en,title_kn,roles,service_areas,sort_order,is_published) values
('raasaa-abhaya-eshwara','Sri RAASAA ABHAYA ESHWARA','ಶ್ರೀ ರಾಸಾ ಅಭಯ ಈಶ್ವರ','Founder, CEO, President & Editor-in-Chief','ಸಂಸ್ಥಾಪಕರು, ಅಧ್ಯಕ್ಷರು ಮತ್ತು ಮುಖ್ಯ ಸಂಪಾದಕರು','[{"en": "Founder President and Editor-in-Chief", "kn": "ಸಂಸ್ಥಾಪಕ ಅಧ್ಯಕ್ಷರು ಮತ್ತು ಮುಖ್ಯ ಸಂಪಾದಕರು"}, {"en": "Director — television serials, theatre and cinema", "kn": "ನಿರ್ದೇಶಕರು-ಧಾರಾವಾಹಿ, ರಂಗ, ಚಲನಚಿತ್ರ"}, {"en": "Publisher — STAR1 Prakashana", "kn": "ಪ್ರಕಾಶಕರು-ಸ್ಟಾರ್1 ಪ್ರಕಾಶನ"}, {"en": "Founder President — Raasaa Kannada and Art & Culture Charitable Trust (Regd.)", "kn": "ಸಂಸ್ಥಾಪಕ ಅಧ್ಯಕ್ಷರು-ರಾಸಾ ಕನ್ನಡ ಮತ್ತು ಕಲಾ ಸಂಸ್ಕೃತಿ ಚಾರಿಟೇಬಲ್ ಟ್ರಸ್ಟ್ (ರಿ.)"}, {"en": "Head — Raasaa Digital Media", "kn": "ಮುಖ್ಯಸ್ಥರು-ರಾಸಾ ಡಿಜಿಟಲ್ ಮೀಡಿಯಾ"}, {"en": "Founder State President — Kavisa Seva Parishattu (Regd.)", "kn": "ಸಂಸ್ಥಾಪಕ ರಾಜ್ಯಾಧ್ಯಕ್ಷರು-ಕವಿಸ ಸೇವಾ ಪರಿಷತ್ತು (ರಿ.)"}, {"en": "National President — BBR", "kn": "ರಾಷ್ಟ್ರೀಯ ಅಧ್ಯಕ್ಷರು-ಬಿಬಿಆರ್"}, {"en": "Literary pursuits and social service", "kn": "ಸಾಹಿತ್ಯ ಕೃಷಿ ಮತ್ತು ಸಾಮಾಜಿಕ ಸೇವೆ"}]'::jsonb,'[{"en": "Legal awareness for the public", "kn": "ಜನಸಾಮಾನ್ಯರಲ್ಲಿ ಕಾನೂನು ಅರಿವು-ಜಾಗೃತಿ"}, {"en": "Awareness for children and women", "kn": "ಮಕ್ಕಳು ಮತ್ತು ಮಹಿಳೆಯರಿಗೆ ಅರಿವು-ಜಾಗೃತಿ"}, {"en": "Media guidance and training", "kn": "ಮಾಧ್ಯಮ ಸಲಹೆ ಮತ್ತು ತರಬೇತಿ"}, {"en": "Social awareness and outreach", "kn": "ಸಾಮಾಜಿಕ ಅರಿವು ಮತ್ತು ಜಾಗೃತಿ"}]'::jsonb,1,true),
('hema','Smt. HEMA','ಶ್ರೀಮತಿ ಹೇಮಾ','Trustee & State President','ಟ್ರಸ್ಟಿಗಳು ಮತ್ತು ರಾಜ್ಯಾಧ್ಯಕ್ಷರು','[{"en": "Head — STAR1 Kannada", "kn": "ಮುಖ್ಯಸ್ಥರು-ಸ್ಟಾರ್1 ಕನ್ನಡ"}, {"en": "Women’s State President — Kavisa Seva Parishattu (Regd.)", "kn": "ಮಹಿಳಾ ರಾಜ್ಯಾಧ್ಯಕ್ಷರು- ಕವಿಸ ಸೇವಾ ಪರಿಷತ್ತು (ರಿ.)"}, {"en": "Trustee — Raasaa Kannada and Kala Samskruti Charitable Trust (R.)", "kn": "ಟ್ರಸ್ಟಿಗಳು-ರಾಸಾ ಕನ್ನಡ ಮತ್ತು ಕಲಾ ಸಂಸ್ಕೃತಿ ಚಾರಿಟೇಬಲ್ ಟ್ರಸ್ಟ್ (ರಿ.)"}, {"en": "Producer — television serials, theatre and cinema", "kn": "ನಿರ್ಮಾಪಕರು- ಧಾರಾವಾಹಿ, ರಂಗ-ಚಲನಚಿತ್ರ"}, {"en": "Social service", "kn": "ಸಾಮಾಜಿಕ ಸೇವೆ"}]'::jsonb,'[]'::jsonb,2,true)
on conflict(slug) do update set name_en=excluded.name_en,name_kn=excluded.name_kn,title_en=excluded.title_en,title_kn=excluded.title_kn,roles=excluded.roles,service_areas=excluded.service_areas,sort_order=excluded.sort_order,is_published=excluded.is_published;

insert into public.categories(slug,name_en,name_kn,description_en,description_kn,sort_order,is_published) values
('reality-shows','Reality shows','ರಿಯಾಲಿಟಿ ಶೋಗಳು','A space for talent, participation and Kannada entertainment.','ಪ್ರತಿಭೆ, ಭಾಗವಹಿಸುವಿಕೆ ಮತ್ತು ಕನ್ನಡ ಮನರಂಜನೆಗೆ ವೇದಿಕೆ.',1,true),
('awards-shows','Awards shows','ಪ್ರಶಸ್ತಿ ಪ್ರದಾನ ಕಾರ್ಯಕ್ರಮಗಳು','A dedicated category for recognition and celebration.','ಸಾಧನೆಗಳ ಗುರುತಿಸುವಿಕೆ ಮತ್ತು ಸಂಭ್ರಮಕ್ಕೆ ಪ್ರತ್ಯೇಕ ವಿಭಾಗ.',2,true),
('serials','Serials','ಧಾರಾವಾಹಿಗಳು','Stories and serial productions from the STAR1 world.','ಸ್ಟಾರ್1 ಜಗತ್ತಿನ ಕಥೆಗಳು ಮತ್ತು ಧಾರಾವಾಹಿ ನಿರ್ಮಾಣಗಳು.',3,true),
('magazine','Magazine & E-Paper','ನಿಯತಕಾಲಿಕೆ ಮತ್ತು ಇ-ಪೇಪರ್','STAR1 Kannada’s publishing and reading space.','ಸ್ಟಾರ್1 ಕನ್ನಡದ ಪ್ರಕಾಶನ ಮತ್ತು ಓದಿನ ವೇದಿಕೆ.',4,true),
('media','Digital media','ಡಿಜಿಟಲ್ ಮಾಧ್ಯಮ','News, conversations and community stories in Kannada.','ಕನ್ನಡದಲ್ಲಿ ಸುದ್ದಿ, ಸಂವಾದ ಮತ್ತು ಸಮುದಾಯದ ಕಥೆಗಳು.',5,true)
on conflict(slug) do update set name_en=excluded.name_en,name_kn=excluded.name_kn,description_en=excluded.description_en,description_kn=excluded.description_kn,sort_order=excluded.sort_order,is_published=excluded.is_published;

insert into public.organizations(slug,name_en,name_kn,description_en,description_kn,location_en,location_kn,registration_information,is_published) values
('star1-kannada','STAR1 KANNADA','ಸ್ಟಾರ್1 ಕನ್ನಡ','Digital Media, Magazine and E-Paper','ಡಿಜಿಟಲ್ ಮೀಡಿಯಾ, ನಿಯತಕಾಲಿಕೆ ಮತ್ತು ಇ-ಪೇಪರ್','Bengaluru, Karnataka, India','ಬೆಂಗಳೂರು, ಕರ್ನಾಟಕ, ಭಾರತ','[]'::jsonb,true),
('star1-studio-film-city','STAR1 STUDIO & FILM CITY','ಸ್ಟಾರ್1 ಸ್ಟುಡಿಯೋ ಮತ್ತು ಫಿಲ್ಮ್ ಸಿಟಿ','','','Bengaluru, Karnataka, India','ಬೆಂಗಳೂರು, ಕರ್ನಾಟಕ, ಭಾರತ','[]'::jsonb,true),
('star1-entertainment','STAR1 ENTERTAINMENT','ಸ್ಟಾರ್1 ಎಂಟರ್‌ಟೈನ್‌ಮೆಂಟ್','','','Bengaluru, Karnataka, India','ಬೆಂಗಳೂರು, ಕರ್ನಾಟಕ, ಭಾರತ','[]'::jsonb,true),
('raasaa-trust','RAASAA KANNADA AND KALA SAMSKRUTI CHARITABLE TRUST (R.)','ರಾಸಾ ಕನ್ನಡ ಮತ್ತು ಕಲಾ ಸಂಸ್ಕೃತಿ ಚಾರಿಟೇಬಲ್ ಟ್ರಸ್ಟ್ (ರಿ.)','Art, culture and social service','ಕಲೆ, ಸಂಸ್ಕೃತಿ ಮತ್ತು ಸಮಾಜ ಸೇವೆ','Bengaluru, Karnataka, India','ಬೆಂಗಳೂರು, ಕರ್ನಾಟಕ, ಭಾರತ','[{"label": "NITI Aayog / Ministry of Culture", "details_en": "Registration with NITI Aayog, Government of India / Ministry of Culture, Government of India.", "source": "Supplied by the trust; no registration numbers supplied."}, {"label": "NGO-DARPAN", "details_en": "Registered with NITI Aayog, Government of India."}, {"label": "12A & 80G", "details_en": "Approved by the Income Tax Department of India."}]'::jsonb,true)
on conflict(slug) do update set name_en=excluded.name_en,name_kn=excluded.name_kn,description_en=excluded.description_en,description_kn=excluded.description_kn,registration_information=excluded.registration_information,is_published=excluded.is_published;

insert into public.contact_channels(slug,label_en,label_kn,phone_e164,url,sort_order,is_published) values
('digital-media','STAR1 Kannada Digital Media','ಸ್ಟಾರ್1 ಕನ್ನಡ ಡಿಜಿಟಲ್ ಮೀಡಿಯಾ','+917406401473','https://wa.me/917406401473',1,true),
('magazine','STAR1 Kannada Magazine','ಸ್ಟಾರ್1 ಕನ್ನಡ ನಿಯತಕಾಲಿಕೆ','+919980778836','https://wa.me/919980778836',2,true)
on conflict(slug) do update set label_en=excluded.label_en,label_kn=excluded.label_kn,phone_e164=excluded.phone_e164,url=excluded.url,is_published=excluded.is_published;
insert into public.social_links(platform,label_en,label_kn,url,sort_order,is_published) values
('youtube','YouTube','ಯೂಟ್ಯೂಬ್','https://youtube.com/shorts/NXQU7bpt050?si=DKAuuphstXjsBMTO',1,true),
('instagram','Instagram','ಇನ್‌ಸ್ಟಾಗ್ರಾಂ','https://www.instagram.com/reel/De_VbvxTUs8/?exln=MWZ1eG5vY2J2OXQ4eg==',2,true),
('whatsapp','WhatsApp Channel','ವಾಟ್ಸಾಪ್ ಚಾನೆಲ್','https://whatsapp.com/channel/0029VbBiGKq9mrGVUdnqK93N',3,true)
on conflict(platform) do update set label_en=excluded.label_en,label_kn=excluded.label_kn,url=excluded.url,is_published=excluded.is_published;

commit;
