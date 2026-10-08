<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Audio Embed Field adds a field type for audio hosted elsewhere: paste a SoundCloud track URL or a direct HTML5 audio file URL (`.mp3`, `.mp4`, `.m4a`, `.aac`, `.ogg`, `.oga`, `.wav`) and get an embedded player, an optional thumbnail, and an optional Colorbox modal. A submodule turns the same field into a core Media source.

---

It is the audio counterpart to `video_embed_field` and shares its architecture. The field stores a single URL string (varchar 256). A `ProviderManager` gathers `@AudioEmbedProvider` provider plugins from `Plugin/audio_embed_field/Provider`; two ship. **SoundCloud** resolves the pasted URL to a numeric track ID by calling `https://api.soundcloud.com/resolve` (authenticated with an OAuth 2.1 `client_credentials` token minted from the site's Client ID + Client Secret and cached in state), then renders a `w.soundcloud.com/player` iframe and can fetch the track `artwork_url` as a thumbnail. **Custom URL** matches any `http(s)` URL containing a known audio extension and renders a plain HTML5 `<audio><source>` element (no thumbnail, no API call). The widget is a textfield whose validation runs the same provider matching, so an unrecognised URL is rejected on save; the field settings let you restrict which providers are allowed. Three formatters render field items: **Audio** (the player, sized or responsive, with an autoplay toggle that the `never autoplay audio` permission can veto per role), **Thumbnail** (downloads the remote artwork to `public://audio_thumbnails/<id>.jpg` and renders it through an image style, optionally linked), and **Colorbox Modal** (thumbnail that opens the player in a modal; requires the contrib `colorbox` module). Render output goes through the `audio_embed_iframe` / `audio_embed_html5` theme hooks, both overridable and preprocessable via `hook_preprocess_audio_embed_iframe[__PROVIDER]` and alterable via `hook_audio_embed_field_provider_info_alter`. The **`audio_embed_media_core`** submodule adds a `MediaSource` plugin so the same URLs become core Media entities usable in the Media Library and, through it, in a WYSIWYG; that matters because audio is usually episodic (a podcast series, a lecture archive, an interview set) and content arriving in sequence needs to be referenceable, listable and searchable rather than pasted into a body field. Version **11.1.1** on core `^10.3 || ^11`, depending only on core `field` and `image` (image is for the thumbnails). Two attachments worth remembering: a **third-party embed is a consent question** — the SoundCloud player sets cookies and reports the play to its host, so treat it like an analytics tag behind the consent manager — and **audio needs a transcript**, a WCAG requirement for pre-recorded audio and the only thing that makes the content searchable. Configure the SoundCloud credentials at `/admin/config/media/audio-embed-field`.

---

- Embed a SoundCloud track in a node.
- Play a direct `.mp3`/`.ogg` file with the native HTML5 audio player (Custom URL provider).
- Publish a podcast episode with a player and cover art.
- Add an audio clip to an article body via a field.
- Restrict a field to only the SoundCloud provider (or only Custom URL) in field settings.
- Show an audio thumbnail (SoundCloud artwork) in a listing or teaser.
- Open the player in a Colorbox modal from a thumbnail.
- Make the player responsive so it fills its container on mobile.
- Suppress autoplay for accessibility by granting the `never autoplay audio` permission to a role.
- Expose audio URLs as core Media entities (via `audio_embed_media_core`).
- Add audio from the Media Library and reference it across pages.
- Insert an embedded audio media item into CKEditor content.
- Build a lecture or conference recording archive as a content type.
- Support an oral-history / interview archive that is listable and searchable.
- Add a recorded reading alongside a poem or story.
- Publish a radio-style programme with episode thumbnails.
- Theme the player by overriding `audio-embed-iframe.html.twig` / `audio-embed-html5.html.twig`.
- Add a per-provider CSS class via `hook_preprocess_audio_embed_iframe__soundcloud`.
- Register a new streaming platform by writing a custom `@AudioEmbedProvider` plugin.
- Swap the shipped SoundCloud provider for a custom class via `hook_audio_embed_field_provider_info_alter`.
- Link an audio thumbnail to the host node or to the provider URL.
- Configure SoundCloud OAuth (Client ID + Secret) once at the admin settings page.
