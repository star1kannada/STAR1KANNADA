-- Add these three published slides. Existing banners are preserved.
-- The images already live in public/ and use website-relative URLs.
BEGIN;
INSERT INTO public.banners (
 slug,label_en,label_kn,tag_en,tag_kn,
 line1_en,line1_kn,line2_en,line2_kn,body_en,body_kn,
 cta_en,cta_kn,link_url,alt_en,alt_kn,image_url,image_path,sort_order,is_published
) VALUES
(
 'star1-newsroom','Kannada news','ಕನ್ನಡ ಸುದ್ದಿ',
 'STAR1 KANNADA · NEWS & PERSPECTIVES','ಸ್ಟಾರ್1 ಕನ್ನಡ · ಸುದ್ದಿ ಮತ್ತು ದೃಷ್ಟಿಕೋನಗಳು',
 'Your news. Your world.','ನಿಮ್ಮ ಸುದ್ದಿ. ನಿಮ್ಮ ಜಗತ್ತು.','In Kannada.','ಕನ್ನಡದಲ್ಲಿ.',
 'News that matters. Culture that connects.','ಮಹತ್ವದ ಸುದ್ದಿ. ಬೆಸೆಯುವ ಸಂಸ್ಕೃತಿ.',
 'Discover our channel','ನಮ್ಮ ವಾಹಿನಿಯ ಪರಿಚಯ','#about',
 'Kannada television newsroom','ಕನ್ನಡ ದೂರದರ್ಶನ ಸುದ್ದಿ ಸ್ಟುಡಿಯೋ',
 '/newsroom.jpg',NULL,20,true
),
(
 'star1-discussion','Real dialogue','ಮುಕ್ತ ಸಂವಾದ',
 'CONVERSATIONS THAT MATTER','ಅರ್ಥಪೂರ್ಣ ಸಂವಾದಗಳು',
 'Big questions. Open minds.','ದೊಡ್ಡ ಪ್ರಶ್ನೆಗಳು. ಮುಕ್ತ ಮನಸ್ಸುಗಳು.','Real dialogue.','ನೈಜ ಸಂವಾದ.',
 'A space for ideas, perspectives and the voices of Karnataka.','ಕರ್ನಾಟಕದ ವಿಚಾರಗಳು, ದೃಷ್ಟಿಕೋನಗಳು ಮತ್ತು ಧ್ವನಿಗಳಿಗೆ ವೇದಿಕೆ.',
 'Explore programmes','ಕಾರ್ಯಕ್ರಮಗಳನ್ನು ನೋಡಿ','#ongoing',
 'A television studio for conversations and discussion','ಸಂವಾದ ಮತ್ತು ಚರ್ಚೆಯ ದೂರದರ್ಶನ ಸ್ಟುಡಿಯೋ',
 '/discussion.jpg',NULL,21,true
),
(
 'star1-reporting','Your voice','ನಿಮ್ಮ ಧ್ವನಿ',
 'ROOTED IN KARNATAKA','ಕರ್ನಾಟಕದ ನೆಲದಿಂದ',
 'Every street. Every story.','ಪ್ರತಿ ಬೀದಿ. ಪ್ರತಿ ಕಥೆ.','Your voice.','ನಿಮ್ಮ ಧ್ವನಿ.',
 'Bringing local stories and our communities closer together.','ಸ್ಥಳೀಯ ಕಥೆಗಳು ಮತ್ತು ನಮ್ಮ ಸಮುದಾಯಗಳನ್ನು ಬೆಸೆಯುತ್ತೇವೆ.',
 'Connect with us','ನಮ್ಮನ್ನು ಸಂಪರ್ಕಿಸಿ','/contact/',
 'Reporting stories from the community','ಸಮುದಾಯದ ಕಥೆಗಳ ವರದಿಗಾರಿಕೆ',
 '/reporting.jpg',NULL,22,true
)
ON CONFLICT (slug) DO UPDATE SET
 label_en=EXCLUDED.label_en,label_kn=EXCLUDED.label_kn,
 tag_en=EXCLUDED.tag_en,tag_kn=EXCLUDED.tag_kn,
 line1_en=EXCLUDED.line1_en,line1_kn=EXCLUDED.line1_kn,
 line2_en=EXCLUDED.line2_en,line2_kn=EXCLUDED.line2_kn,
 body_en=EXCLUDED.body_en,body_kn=EXCLUDED.body_kn,
 cta_en=EXCLUDED.cta_en,cta_kn=EXCLUDED.cta_kn,link_url=EXCLUDED.link_url,
 alt_en=EXCLUDED.alt_en,alt_kn=EXCLUDED.alt_kn,
 image_url=EXCLUDED.image_url,image_path=NULL,
 sort_order=EXCLUDED.sort_order,is_published=true;
COMMIT;
