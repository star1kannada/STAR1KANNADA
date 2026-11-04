-- Replace all current banner rows with these four event banners.
-- FIRST deploy public/event-banners/ with the website, OR upload each PNG
-- to Supabase Storage and replace image_url with its full public URL.
-- Events, gallery, partners and physical images are not deleted.
BEGIN;

DELETE FROM public.banners;

INSERT INTO public.banners
  (slug, label_en, label_kn, line1_en, line1_kn, line2_en, line2_kn,
   image_url, alt_en, alt_kn, cta_en, cta_kn, link_url, sort_order, is_published)
VALUES
  ('event-awards', 'Awards', 'ಪ್ರಶಸ್ತಿಗಳು',
   'Honouring service.', 'ಸೇವೆಗೆ ಗೌರವ.',
   'Celebrating dedication.', 'ಸಮರ್ಪಣೆಗೆ ಸನ್ಮಾನ.',
   '/event-banners/01-awards.png', 'Awards programme collage', 'ಪ್ರಶಸ್ತಿ ಕಾರ್ಯಕ್ರಮಗಳ ಸಂಯೋಜಿತ ಚಿತ್ರ',
   'Explore programmes', 'ಕಾರ್ಯಕ್ರಮಗಳನ್ನು ನೋಡಿ', '#ongoing', 1, true),

  ('event-youth-reality', 'Youth & Reality Shows', 'ಯುವಜನತೆ ಮತ್ತು ರಿಯಾಲಿಟಿ ಶೋಗಳು',
   'Your talent. Your stage.', 'ನಿಮ್ಮ ಪ್ರತಿಭೆ. ನಿಮ್ಮ ವೇದಿಕೆ.',
   'Your STAR1 moment.', 'ನಿಮ್ಮ ಸ್ಟಾರ್1 ಕ್ಷಣ.',
   '/event-banners/02-youth-reality.png', 'Youth and reality shows collage', 'ಯುವಜನತೆ ಮತ್ತು ರಿಯಾಲಿಟಿ ಶೋಗಳ ಸಂಯೋಜಿತ ಚಿತ್ರ',
   'Explore programmes', 'ಕಾರ್ಯಕ್ರಮಗಳನ್ನು ನೋಡಿ', '#ongoing', 2, true),

  ('event-music-dance', 'Music & Dance', 'ಸಂಗೀತ ಮತ್ತು ನೃತ್ಯ',
   'Every voice. Every move.', 'ಪ್ರತಿ ಧ್ವನಿ. ಪ್ರತಿ ಹೆಜ್ಜೆ.',
   'A stage to shine.', 'ಮಿಂಚಲು ಒಂದು ವೇದಿಕೆ.',
   '/event-banners/03-music-dance.png', 'Music and dance programme collage', 'ಸಂಗೀತ ಮತ್ತು ನೃತ್ಯ ಕಾರ್ಯಕ್ರಮಗಳ ಸಂಯೋಜಿತ ಚಿತ್ರ',
   'Explore programmes', 'ಕಾರ್ಯಕ್ರಮಗಳನ್ನು ನೋಡಿ', '#ongoing', 3, true),

  ('event-yoga-wellness', 'Yoga & Wellness', 'ಯೋಗ ಮತ್ತು ಸ್ವಾಸ್ಥ್ಯ',
   'Pause. Breathe.', 'ವಿರಮಿಸಿ. ಉಸಿರಾಡಿ.',
   'Find your balance.', 'ನಿಮ್ಮ ಸಮತೋಲನ ಕಂಡುಕೊಳ್ಳಿ.',
   '/event-banners/04-yoga-wellness.png', 'Yoga and wellness programme collage', 'ಯೋಗ ಮತ್ತು ಸ್ವಾಸ್ಥ್ಯ ಕಾರ್ಯಕ್ರಮಗಳ ಸಂಯೋಜಿತ ಚಿತ್ರ',
   'Explore programmes', 'ಕಾರ್ಯಕ್ರಮಗಳನ್ನು ನೋಡಿ', '#ongoing', 4, true);

COMMIT;

SELECT slug, image_url, is_published
FROM public.banners ORDER BY sort_order;
