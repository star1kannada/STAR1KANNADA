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
