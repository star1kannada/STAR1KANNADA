-- Adds four banners without deleting existing banners.
-- Run in Supabase SQL Editor. Safe to run again: updates these four slugs.
begin;
insert into public.banners
(slug,label_en,label_kn,line1_en,line1_kn,line2_en,line2_kn,body_en,body_kn,cta_en,cta_kn,link_url,alt_en,alt_kn,image_url,sort_order,is_published)
values
('founder-profile','Our founder','ನಮ್ಮ ಸಂಸ್ಥಾಪಕರು','Sri Raasaa','ಶ್ರೀ ರಾಸಾ','Abhaya Eshwara','ಅಭಯ ಈಶ್ವರ','Founder, CEO, President & Editor-in-Chief','ಸಂಸ್ಥಾಪಕರು, ಅಧ್ಯಕ್ಷರು ಮತ್ತು ಮುಖ್ಯ ಸಂಪಾದಕರು','Meet our founder','ನಮ್ಮ ಸಂಸ್ಥಾಪಕರ ಪರಿಚಯ','#founder','Sri Raasaa Abhaya Eshwara','ಶ್ರೀ ರಾಸಾ ಅಭಯ ಈಶ್ವರ','/banner-collection/01-founder.png',1,true),
('hema-profile','Our leadership','ನಮ್ಮ ನಾಯಕತ್ವ','Smt. Hema','ಶ್ರೀಮತಿ ಹೇಮಾ','Leading with purpose.','ಸೇವೆಯ ಧ್ಯೇಯದೊಂದಿಗೆ.','Trustee & State President','ಟ್ರಸ್ಟಿಗಳು ಮತ್ತು ರಾಜ್ಯಾಧ್ಯಕ್ಷರು','Meet our leadership','ನಮ್ಮ ನಾಯಕತ್ವದ ಪರಿಚಯ','#hema','Smt. Hema','ಶ್ರೀಮತಿ ಹೇಮಾ','/banner-collection/02-hema.png',2,true),
('leadership-together','Together for Kannada','ಕನ್ನಡಕ್ಕಾಗಿ ಜೊತೆಯಾಗಿ','Our people. Our purpose.','ನಮ್ಮ ಜನರು. ನಮ್ಮ ಧ್ಯೇಯ.','Our Kannada.','ನಮ್ಮ ಕನ್ನಡ.','Sri Raasaa Abhaya Eshwara & Smt. Hema','ಶ್ರೀ ರಾಸಾ ಅಭಯ ಈಶ್ವರ ಮತ್ತು ಶ್ರೀಮತಿ ಹೇಮಾ','Meet our leadership','ನಮ್ಮ ನಾಯಕತ್ವದ ಪರಿಚಯ','#founder','STAR1 leadership portrait composite','ಸ್ಟಾರ್1 ನಾಯಕತ್ವದ ಸಂಯೋಜಿತ ಭಾವಚಿತ್ರ','/banner-collection/03-together.png',3,true),
('star1-programmes','The STAR1 world','ಸ್ಟಾರ್1 ಜಗತ್ತು','Talent. Culture. Community.','ಪ್ರತಿಭೆ. ಸಂಸ್ಕೃತಿ. ಸಮುದಾಯ.','A stage for every story.','ಪ್ರತಿ ಕಥೆಗೂ ಒಂದು ವೇದಿಕೆ.','Explore awards, youth, dance and singing programmes.','ಪ್ರಶಸ್ತಿ, ಯುವಜನತೆ, ನೃತ್ಯ ಮತ್ತು ಗಾಯನ ಕಾರ್ಯಕ್ರಮಗಳನ್ನು ಅನ್ವೇಷಿಸಿ.','Explore programmes','ಕಾರ್ಯಕ್ರಮಗಳನ್ನು ನೋಡಿ','#ongoing','Promotional programme collage','ಕಾರ್ಯಕ್ರಮಗಳ ಪ್ರಚಾರ ಚಿತ್ರಸಂಗ್ರಹ','/banner-collection/04-programmes.png',4,true)
on conflict(slug) do update set
label_en=excluded.label_en,label_kn=excluded.label_kn,
line1_en=excluded.line1_en,line1_kn=excluded.line1_kn,
line2_en=excluded.line2_en,line2_kn=excluded.line2_kn,
body_en=excluded.body_en,body_kn=excluded.body_kn,
cta_en=excluded.cta_en,cta_kn=excluded.cta_kn,
link_url=excluded.link_url,alt_en=excluded.alt_en,alt_kn=excluded.alt_kn,
image_url=excluded.image_url,image_path=null,sort_order=excluded.sort_order,is_published=true;
commit;

-- OPTIONAL: Run separately to show ONLY these four banners:
-- update public.banners set is_published=false
-- where slug not in ('founder-profile','hema-profile','leadership-together','star1-programmes');
