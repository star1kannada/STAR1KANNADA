-- Optional starter leadership banner. Rerunning preserves admin edits.
begin;
insert into public.banners (
  slug, label_en, label_kn, tag_en, tag_kn, line1_en, line1_kn, line2_en, line2_kn, body_en, body_kn, cta_en, cta_kn, link_url, alt_en, alt_kn, image_url, sort_order, is_published
) values (
  'star1-leadership',
  'Our leadership',
  'ನಮ್ಮ ನಾಯಕತ್ವ',
  'STAR1 KANNADA · MEDIA. ARTS. COMMUNITY.',
  'ಸ್ಟಾರ್1 ಕನ್ನಡ · ಮಾಧ್ಯಮ. ಕಲೆ. ಸಮಾಜ.',
  'Our people. Our purpose.',
  'ನಮ್ಮ ಜನರು. ನಮ್ಮ ಧ್ಯೇಯ.',
  'Our Kannada.',
  'ನಮ್ಮ ಕನ್ನಡ.',
  'Led by Sri Raasaa Abhaya Eshwara and Smt. Hema, connecting Karnataka through news, culture and community.',
  'ಶ್ರೀ ರಾಸಾ ಅಭಯ ಈಶ್ವರ ಮತ್ತು ಶ್ರೀಮತಿ ಹೇಮಾ ಅವರ ನಾಯಕತ್ವದಲ್ಲಿ ಸುದ್ದಿ, ಸಂಸ್ಕೃತಿ ಮತ್ತು ಸಮುದಾಯದ ಮೂಲಕ ಕರ್ನಾಟಕವನ್ನು ಬೆಸೆಯುತ್ತೇವೆ.',
  'Meet our leadership',
  'ನಮ್ಮ ನಾಯಕತ್ವದ ಪರಿಚಯ',
  '#founder',
  'Portrait composite of Sri Raasaa Abhaya Eshwara and Smt. Hema',
  'ಶ್ರೀ ರಾಸಾ ಅಭಯ ಈಶ್ವರ ಮತ್ತು ಶ್ರೀಮತಿ ಹೇಮಾ ಅವರ ಸಂಯೋಜಿತ ಭಾವಚಿತ್ರ',
  '/leadership-banner.png',
  1,
  true
) on conflict(slug) do nothing;
commit;
