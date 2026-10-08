Cincopa Multimedia Platform embeds Cincopa-hosted video/photo/audio galleries into Drupal content through a `[cincopa <gallery-id>]` text-format filter.

---

The module integrates the hosted Cincopa media platform (cincopa.com) with Drupal by providing a text-format filter (`filter_cincopa`, "Parse Cincopa Tags") that turns a `[cincopa 123456789]` inline tag anywhere in filtered body text into a placeholder `<div>` that Cincopa's client-side runtime (`libasync.js`, loaded from cincopa.com) fills with the actual gallery/video/slideshow/audio player. Rendering happens entirely in the visitor's browser via Cincopa's JavaScript widget loader, so Drupal never stores API credentials or fetches media server-side; the gallery ID references content authored in the editor's Cincopa account. The project also ships legacy CKEditor 4 button plugins (`cincopagallery`, `cincopaselgallery`) and an admin help banner; those editor buttons target Drupal 9's CKEditor 4 and are inert on CKEditor 5 (Drupal 10/11), where the tag filter remains the working integration path. Enable the module, add the "Parse Cincopa Tags" filter to the desired text format(s), and place `[cincopa <id>]` tags in content.

---

- Embed a Cincopa-hosted photo gallery inside a node body.
- Embed a Cincopa-hosted video player in filtered rich-text content.
- Embed an audio player / podcast playlist from Cincopa.
- Display a Cincopa slideshow (Cooliris, Lightbox, and other skins) in content.
- Offload media hosting, streaming, and bandwidth to the Cincopa platform.
- Add rich media to any field that uses a text format (body, custom long-text fields).
- Reuse one gallery ID across many pages by pasting the same `[cincopa <id>]` tag.
- Keep media managed in the Cincopa account while publishing it through Drupal.
- Avoid installing separate lightbox/gallery/audio display modules.
- Enable the "Parse Cincopa Tags" filter only on selected formats to scope where embeds are allowed.
- Let content editors insert galleries without writing HTML or iframe markup.
- Serve responsive, template-styled media players chosen from Cincopa's skin library.
- Insert multiple distinct galleries in a single piece of content (each gets a unique widget div).
- Present marketing/landing pages with rich hosted media.
- Deliver client-side lazy media loading (widget JS runs after page load).
- Show a one-time admin welcome/help banner linking to the Cincopa registration and docs.
- Provide CKEditor 4 toolbar buttons for gallery insertion on legacy Drupal 9 sites.
- Migrate media presentation off Drupal's file system onto a hosted CDN-backed platform.
- Support Drupal 9.3+, 10, and 11 for the tag-filter embedding path.
