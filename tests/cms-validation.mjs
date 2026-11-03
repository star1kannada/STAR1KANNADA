import assert from 'node:assert/strict';
import {safeLink,validImageUrl,toISTInput,fromISTInput,imageFields,IMAGE_TYPES} from '../lib/cms-types.ts';
for(const url of ['javascript:alert(1)','data:text/html,anything','//evil.example/a','file:///tmp/a'])assert.equal(safeLink(url),'');
assert.equal(safeLink('#events'),'#events');assert.equal(safeLink('https://example.com/path'),'https://example.com/path');
assert.equal(validImageUrl('//evil.example/image.jpg'),false);assert.equal(validImageUrl('/event-food.jpg'),true);
assert.equal(validImageUrl('data:image/svg+xml,anything'),false);
assert.equal(toISTInput('2026-11-03T12:30:00Z'),'2026-11-03T18:00');assert.equal(fromISTInput('2026-11-03T18:00'),'2026-11-03T12:30:00.000Z');
assert.deepEqual(imageFields('partners'),{url:'logo_url',path:'logo_path'});assert(!IMAGE_TYPES.includes('image/svg+xml'));
console.log('PASS: unsafe links/images rejected, public image paths allowed, IST/UTC round trip, image field mapping.');
