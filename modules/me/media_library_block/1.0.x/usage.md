Media Library Block provides one block plugin per media type, letting an editor pick a single media entity via the core Media Library and render it in that block using a chosen view mode.

---

The module defines a single derivative block plugin, `media_library_block`, whose deriver
(`MediaLibraryBlockDeriver`) creates one block variant for **every media bundle** on the site (labeled
with the bundle name, in the *Media* block category). Its block form uses the
[Media Library form element](https://www.drupal.org/project/media_library_form_element) (`#type =>
media_library`) restricted to that bundle with cardinality 1, plus a *View mode* select populated from
the bundle's configured view modes. On submit it stores the selected media id (taking the first if the
element returns several) and the view mode in the block's configuration. When rendered, `build()` loads
the media, checks the current user's `view` access to it, and — only if allowed — renders it through the
media view builder in the selected view mode, merging the media's and the render array's cacheable
metadata. `calculateDependencies()` adds config dependencies on the media entity, its view-display, and
the media type so the block travels correctly in config exports. There is no admin settings page and no
permissions of its own; placement is done through the normal Block layout UI or Layout Builder.

---

- Place a specific image, video, or document from the Media Library into a region as a block.
- Add a "featured media" block to a sidebar or footer, chosen per placement.
- Offer editors a media-picker block for each media type (image, video, audio, remote video, …).
- Render the selected media in a specific view mode (thumbnail, full, teaser, custom).
- Drop a media block into a Layout Builder section.
- Show a promotional video block on the front page without a custom block type.
- Reuse an existing Media Library asset in block form instead of re-uploading.
- Let content teams swap the media in a block placement without touching code.
- Add a logo or hero image block sourced from managed media.
- Build a poster/banner region driven by a single media entity.
- Present a document (PDF) download block via a Document media type.
- Respect per-media view access — restricted media simply won't render in the block.
- Keep media block placements portable via automatic config dependencies.
- Provide a remote-video (oEmbed) block using the Remote video media type.
- Use different view modes of the same media type in different regions.
- Give site builders a no-code way to feature curated media.
- Add an audio-clip block using an Audio media type.
- Show the same media entity in multiple placements, each with its own view mode.
- Combine with Media Library's upload/browse UI so editors can add new media inline while placing the block.
