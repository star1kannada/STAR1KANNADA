-- ONE FILE: 10 gallery posters + 6 upcoming programme records.
-- Original posters supplied by the channel. Run in Supabase SQL Editor.
-- Files are hosted by the website under /media/. No Storage upload is needed.
-- Safe to run again; existing unrelated records are preserved.
begin;
insert into public.gallery
(id,title_en,title_kn,alt_en,alt_kn,image_url,image_path,sort_order,is_published)
values
('31f1f027-d53c-518b-98c7-e8db35d79799','STAR1 Police Seva Samman 2026','ಸ್ಟಾರ್1 ಆರಕ್ಷಕ ಸೇವಾ ಸಮ್ಮಾನ್ 2026','STAR1 Police Seva Samman 2026 promotional poster','ಸ್ಟಾರ್1 ಆರಕ್ಷಕ ಸೇವಾ ಸಮ್ಮಾನ್ 2026 ಪೋಸ್ಟರ್','/media/gallery/01-police-seva-samman-2026.jpg',null,1,true),
('b11d8ddc-0453-5545-b160-7591e3f1f6a0','STAR1 Voice of Youth','ಸ್ಟಾರ್1 ವಾಯ್ಸ್ ಆಫ್ ಯೂತ್','STAR1 Voice of Youth promotional poster','ಸ್ಟಾರ್1 ವಾಯ್ಸ್ ಆಫ್ ಯೂತ್ ಪೋಸ್ಟರ್','/media/gallery/02-voice-of-youth.jpg',null,2,true),
('3e2abac6-b814-5641-9766-27ac0a9b3802','STAR1 Yoga Kshema','ಸ್ಟಾರ್1 ಯೋಗ ಕ್ಷೇಮ','STAR1 Yoga Kshema promotional poster','ಸ್ಟಾರ್1 ಯೋಗ ಕ್ಷೇಮ ಪೋಸ್ಟರ್','/media/gallery/03-yoga-kshema.jpg',null,3,true),
('cd3fd923-b743-5b5f-8524-8edb594c6deb','STAR1 Lovely Couple','ಸ್ಟಾರ್1 ಲವ್ಲಿ ಕಪಲ್','STAR1 Lovely Couple promotional poster','ಸ್ಟಾರ್1 ಲವ್ಲಿ ಕಪಲ್ ಪೋಸ್ಟರ್','/media/gallery/04-lovely-couple.jpg',null,4,true),
('96f1cdd3-764f-5fb8-b8a0-b268050cf957','STAR1 Dance with Dance','ಸ್ಟಾರ್1 ಡಾನ್ಸ್ ವಿತ್ ಡಾನ್ಸ್','STAR1 Dance with Dance promotional poster','ಸ್ಟಾರ್1 ಡಾನ್ಸ್ ವಿತ್ ಡಾನ್ಸ್ ಪೋಸ್ಟರ್','/media/gallery/05-dance-with-dance.jpg',null,5,true),
('128039ff-81af-5352-8d06-8b9a965abe5a','STAR1 Singer','ಸ್ಟಾರ್1 ಸಿಂಗರ್','STAR1 Singer promotional poster','ಸ್ಟಾರ್1 ಸಿಂಗರ್ ಪೋಸ್ಟರ್','/media/gallery/06-star1-singer.jpg',null,6,true),
('6bdb5908-5e63-5cdb-9abe-3afed93909c9','STAR1 Singer – audition spotlight','ಸ್ಟಾರ್1 ಸಿಂಗರ್ – ಆಡಿಷನ್ ಪರಿಚಯ','STAR1 Singer – audition spotlight promotional poster','ಸ್ಟಾರ್1 ಸಿಂಗರ್ – ಆಡಿಷನ್ ಪರಿಚಯ ಪೋಸ್ಟರ್','/media/gallery/07-singer-audition-poster.jpg',null,7,true),
('82b9b330-00a0-5c9e-9b9a-b9bd2bf78066','STAR1 Kannada – channel launch greetings','ಸ್ಟಾರ್1 ಕನ್ನಡ – ವಾಹಿನಿ ಆರಂಭದ ಶುಭಾಶಯಗಳು','STAR1 Kannada – channel launch greetings promotional poster','ಸ್ಟಾರ್1 ಕನ್ನಡ – ವಾಹಿನಿ ಆರಂಭದ ಶುಭಾಶಯಗಳು ಪೋಸ್ಟರ್','/media/gallery/08-channel-launch-greetings.jpg',null,8,true),
('14594af0-c3b7-5b02-87a9-6f8a41ffd848','STAR1 Kannada – media recruitment poster','ಸ್ಟಾರ್1 ಕನ್ನಡ – ಮಾಧ್ಯಮ ನೇಮಕಾತಿ ಪೋಸ್ಟರ್','STAR1 Kannada – media recruitment poster promotional poster','ಸ್ಟಾರ್1 ಕನ್ನಡ – ಮಾಧ್ಯಮ ನೇಮಕಾತಿ ಪೋಸ್ಟರ್ ಪೋಸ್ಟರ್','/media/gallery/09-media-recruitment.jpg',null,9,true),
('c00364b4-156c-5af5-9211-efc6b68a004e','STAR1 Kannada Magazine – children’s talent','ಸ್ಟಾರ್1 ಕನ್ನಡ ಮ್ಯಾಗಜಿನ್ – ಮಕ್ಕಳ ಪ್ರತಿಭೆ','STAR1 Kannada Magazine – children’s talent promotional poster','ಸ್ಟಾರ್1 ಕನ್ನಡ ಮ್ಯಾಗಜಿನ್ – ಮಕ್ಕಳ ಪ್ರತಿಭೆ ಪೋಸ್ಟರ್','/media/gallery/10-magazine-childrens-talent.jpg',null,10,true)
on conflict(id) do update set title_en=excluded.title_en,title_kn=excluded.title_kn,alt_en=excluded.alt_en,alt_kn=excluded.alt_kn,image_url=excluded.image_url,image_path=null,sort_order=excluded.sort_order,is_published=true;
commit;

-- Original posters supplied by the channel. Run in Supabase SQL Editor.
-- Files are hosted by the website under /media/. No Storage upload is needed.
-- Safe to run again; existing unrelated records are preserved.
-- Dates and venues are unconfirmed. Update them through Admin when confirmed.
-- On repeat runs, previously entered dates and venues are preserved.
begin;
insert into public.events
(slug,title_en,title_kn,description_en,description_kn,category_label_en,category_label_kn,starts_at,ends_at,venue_en,venue_kn,image_url,image_path,sort_order,status,is_sample,is_published)
values
('star1-police-seva-samman-2026','STAR1 Police Seva Samman 2026','ಸ್ಟಾರ್1 ಆರಕ್ಷಕ ಸೇವಾ ಸಮ್ಮಾನ್ 2026','An awards programme recognising police service and dedication. Event date, venue and participation details are to be confirmed with STAR1 Kannada.','ಪೊಲೀಸ್ ಸೇವೆ ಮತ್ತು ಸಮರ್ಪಣೆಯನ್ನು ಗೌರವಿಸುವ ಪ್ರಶಸ್ತಿ ಕಾರ್ಯಕ್ರಮ. ದಿನಾಂಕ, ಸ್ಥಳ ಮತ್ತು ಭಾಗವಹಿಸುವ ವಿವರಗಳನ್ನು ಸ್ಟಾರ್1 ಕನ್ನಡದಿಂದ ದೃಢೀಕರಿಸಿ.','Awards','ಪ್ರಶಸ್ತಿಗಳು',null,null,'','','/media/events/01-police-seva-samman-2026.jpg',null,1,'upcoming',false,true),
('star1-voice-of-youth','STAR1 Voice of Youth','ಸ್ಟಾರ್1 ವಾಯ್ಸ್ ಆಫ್ ಯೂತ್','A programme for young voices and emerging leadership. The supplied poster lists participation for ages 15 to 30. Contact STAR1 Kannada for the upcoming schedule and registration details.','ಯುವ ಧ್ವನಿಗಳು ಮತ್ತು ಬೆಳೆಯುತ್ತಿರುವ ನಾಯಕತ್ವಕ್ಕೆ ವೇದಿಕೆ. ನೀಡಿರುವ ಪೋಸ್ಟರ್‌ನಲ್ಲಿ 15 ರಿಂದ 30 ವರ್ಷ ವಯೋಮಿತಿಯನ್ನು ಸೂಚಿಸಲಾಗಿದೆ. ಮುಂದಿನ ವೇಳಾಪಟ್ಟಿ ಮತ್ತು ನೋಂದಣಿಗಾಗಿ ಸ್ಟಾರ್1 ಕನ್ನಡವನ್ನು ಸಂಪರ್ಕಿಸಿ.','Youth','ಯುವಜನತೆ',null,null,'','','/media/events/02-voice-of-youth.jpg',null,2,'upcoming',false,true),
('star1-yoga-kshema','STAR1 Yoga Kshema','ಸ್ಟಾರ್1 ಯೋಗ ಕ್ಷೇಮ','A STAR1 Kannada programme focused on yoga and wellbeing. Contact the channel to confirm the next session, broadcast schedule and participation details.','ಯೋಗ ಮತ್ತು ಸ್ವಾಸ್ಥ್ಯಕ್ಕೆ ಮೀಸಲಾದ ಸ್ಟಾರ್1 ಕನ್ನಡ ಕಾರ್ಯಕ್ರಮ. ಮುಂದಿನ ತರಗತಿ, ಪ್ರಸಾರದ ವೇಳಾಪಟ್ಟಿ ಮತ್ತು ಭಾಗವಹಿಸುವ ವಿವರಗಳಿಗಾಗಿ ವಾಹಿನಿಯನ್ನು ಸಂಪರ್ಕಿಸಿ.','Yoga & wellness','ಯೋಗ ಮತ್ತು ಸ್ವಾಸ್ಥ್ಯ',null,null,'','','/media/events/03-yoga-kshema.jpg',null,3,'upcoming',false,true),
('star1-lovely-couple','STAR1 Lovely Couple','ಸ್ಟಾರ್1 ಲವ್ಲಿ ಕಪಲ್','A reality-show programme celebrating couples and performance. Confirm the next programme date, location and participation requirements directly with STAR1 Kannada.','ಜೋಡಿಗಳು ಮತ್ತು ಪ್ರದರ್ಶನ ಪ್ರತಿಭೆಯನ್ನು ಸಂಭ್ರಮಿಸುವ ರಿಯಾಲಿಟಿ ಶೋ. ಮುಂದಿನ ಕಾರ್ಯಕ್ರಮದ ದಿನಾಂಕ, ಸ್ಥಳ ಮತ್ತು ಭಾಗವಹಿಸುವ ನಿಯಮಗಳನ್ನು ಸ್ಟಾರ್1 ಕನ್ನಡದಿಂದ ದೃಢೀಕರಿಸಿ.','Reality shows','ರಿಯಾಲಿಟಿ ಶೋಗಳು',null,null,'','','/media/events/04-lovely-couple.jpg',null,4,'upcoming',false,true),
('star1-dance-with-dance','STAR1 Dance with Dance','ಸ್ಟಾರ್1 ಡಾನ್ಸ್ ವಿತ್ ಡಾನ್ಸ್','A dance and talent programme from STAR1 Kannada. This poster features an audition participant. Contact the channel for upcoming audition dates and eligibility details.','ಸ್ಟಾರ್1 ಕನ್ನಡದ ನೃತ್ಯ ಮತ್ತು ಪ್ರತಿಭಾ ಕಾರ್ಯಕ್ರಮ. ಈ ಪೋಸ್ಟರ್‌ನಲ್ಲಿ ಆಡಿಷನ್ ಸ್ಪರ್ಧಿಯನ್ನು ಪರಿಚಯಿಸಲಾಗಿದೆ. ಮುಂದಿನ ಆಡಿಷನ್ ದಿನಾಂಕ ಮತ್ತು ಅರ್ಹತೆಯ ವಿವರಗಳಿಗಾಗಿ ವಾಹಿನಿಯನ್ನು ಸಂಪರ್ಕಿಸಿ.','Dance','ನೃತ್ಯ',null,null,'','','/media/events/05-dance-with-dance.jpg',null,5,'upcoming',false,true),
('star1-star1-singer','STAR1 Singer','ಸ್ಟಾರ್1 ಸಿಂಗರ್','A singing programme showcasing musical talent and Kannada voices. Contact STAR1 Kannada for the next audition, programme schedule and registration details.','ಸಂಗೀತ ಪ್ರತಿಭೆ ಮತ್ತು ಕನ್ನಡ ಧ್ವನಿಗಳಿಗೆ ವೇದಿಕೆಯಾದ ಗಾಯನ ಕಾರ್ಯಕ್ರಮ. ಮುಂದಿನ ಆಡಿಷನ್, ಕಾರ್ಯಕ್ರಮದ ವೇಳಾಪಟ್ಟಿ ಮತ್ತು ನೋಂದಣಿಗಾಗಿ ಸ್ಟಾರ್1 ಕನ್ನಡವನ್ನು ಸಂಪರ್ಕಿಸಿ.','Music & singing','ಸಂಗೀತ ಮತ್ತು ಗಾಯನ',null,null,'','','/media/events/06-star1-singer.jpg',null,6,'upcoming',false,true)
on conflict(slug) do update set title_en=excluded.title_en,title_kn=excluded.title_kn,description_en=excluded.description_en,description_kn=excluded.description_kn,category_label_en=excluded.category_label_en,category_label_kn=excluded.category_label_kn,image_url=excluded.image_url,image_path=null,sort_order=excluded.sort_order,status=excluded.status,is_sample=false,is_published=true;
commit;
