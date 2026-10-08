Provides a field formatter that displays core Media remote (oEmbed) videos in an accessible modal popup built with the micromodal.js library, triggered from a thumbnail, the media name, a caption, or custom link text.

---

The module adds a single field formatter, `micromodal_field_formatter`, applicable to `string`, `image`, and `entity_reference` fields on `media` entities. You attach it on the *Manage display* tab of the `remote_video` media type (or any media type that has the core `field_media_oembed_video` field). Depending on the field it decorates it renders either the oEmbed-generated **thumbnail**, a **custom uploaded thumbnail** (image or media reference, with a selectable image style), or a **text link** (the media *Name*, a per-media *caption*, or custom *Link text* that supports tokens when the Token module is present). Clicking the rendered trigger opens a micromodal dialog containing an `<iframe>` whose `src` is a locally generated `media.oembed_iframe` URL — the formatter rebuilds the same hashed/signed core Media oEmbed iframe URL (using `IFrameUrlHelper` + the site private key) rather than embedding the remote URL directly. The micromodal library itself is loaded as an **external asset from `unpkg.com`** (`micromodal@0.4.10`); the init script stops video playback by resetting the iframe `src` on close. An optional "Caption Swap" setting swaps a text link's contents for the media's `<figcaption>` at runtime (useful inside CKEditor embeds). Formatter settings are stored per display component with schema `field.formatter.settings.micromodal_field_formatter`. There is no global config page, no permissions, and no Drush.

---

- Show a remote video (YouTube/Vimeo via core Media oEmbed) as a clickable thumbnail that opens in a modal.
- Play videos in an accessible, keyboard-friendly popup instead of inline on the page.
- Use the auto-generated oEmbed thumbnail as the modal trigger, with a chosen image style.
- Use a custom uploaded thumbnail (image field or media reference) instead of the oEmbed thumbnail.
- Turn the media Name field into a text link that opens the video modal.
- Use custom per-display link text (e.g. "Watch video") in place of the media name.
- Insert tokens into the link text when the Token module is enabled.
- Swap the link text for the media's caption using the "Caption Swap" option.
- Embed modal videos inside CKEditor content via the core "Embed media" filter and view modes.
- Render modal videos in a View using "Rendered entity" plus a view mode that uses the formatter.
- Add extra CSS classes to the text-link `<span>` for styling.
- Automatically stop video playback when the modal is closed (iframe src reset on close).
- Serve videos through Drupal's signed local oEmbed iframe endpoint rather than the raw remote URL.
- Provide a lightweight modal experience without jQuery (micromodal is vanilla JS).
- Configure different modal triggers per view mode (thumbnail in a teaser, name link elsewhere).
- Give each modal a unique DOM id derived from media id, delta, and field name.
- Reuse the same formatter across multiple media display modes for varied layouts.
- Present a gallery of video thumbnails that each open their own modal.
- Warn editors in the settings summary when an image/media trigger has no image style set (nothing renders).
- Override the modal markup by supplying a `media-video-micromodal` template suggestion per bundle/view mode.
