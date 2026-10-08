<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor Media Embed adds CKEditor 5's native **Media Embed** feature to Drupal, letting authors paste a media URL (YouTube, Vimeo, Twitter/X, Instagram, Google Maps, …) into a rich-text field and have it render as an embed. It stores an `<oembed url="…">` tag and converts it to embed HTML at render time via a text-format filter, resolving each URL through a configurable oEmbed provider (Iframely by default).

---

The module ships a CKEditor 5 plugin definition (`ckeditor_media_embed_embed_media`) that exposes an **Insert media** toolbar button backed by CKEditor's `mediaEmbed.MediaEmbedEditing`/`MediaEmbedUI` plugins; you add it to a text editor's toolbar on the *Text formats and editors* page. The CKEditor JavaScript for the feature is **not bundled** — it must be downloaded into the site's `libraries/ckeditor5/plugins/` directory, which the module automates with `drush ckeditor_media_embed:install` (and `:update` to refresh it to the current core CKEditor version); a `hook_requirements()` check and a dblog error warn when the plugin JS is missing or a version-mismatched. When an author inserts media, CKEditor writes an `<oembed url="…">` element into the saved markup; the **"Convert Oembed tags to media embeds"** filter (`filter_ckeditor_media_embed`) must be enabled on that text format so the stored tag is transformed to real embed HTML on output. Which oEmbed service resolves the URLs is a single **Provider URL** template (`embed_provider`) set at `/admin/config/media/ckeditor-media-embed/settings` — it defaults to Iframely's proxy and accepts `{url}`/`{callback}` tokens, so you can point it at Noembed, embed.ly, or any oEmbed endpoint. The module also provides a **link field formatter** (`ckeditor_media_embed_link_formatter`) that renders a Link field's URL through the same provider, and a `hook_ckeditor_media_embed_object_alter()` hook to post-process the returned embed object (it ships a default implementation that copies the media title onto the iframe's `title` attribute for accessibility). All persistent configuration lives in the `ckeditor_media_embed.settings` config object.

---

- Let content authors embed a YouTube or Vimeo video by pasting its URL into a rich-text body field.
- Embed tweets / X posts, Instagram posts, or Imgur images inline in article content.
- Embed a Google Map, a SoundCloud track, or a CodePen into a page without writing HTML.
- Add an **Insert media** button to a specific text format's CKEditor 5 toolbar.
- Support 1700+ media providers at once through the default Iframely oEmbed proxy.
- Switch the oEmbed provider to Noembed (`//noembed.com/embed?url={url}&callback={callback}`) to avoid an API key.
- Use an Iframely account/API token for HTTPS embeds by editing the Provider URL template.
- Point the provider at embed.ly or a self-hosted oEmbed proxy for full control of embeds.
- Restrict embeds to a single service (e.g. only YouTube) by configuring that provider's oEmbed endpoint.
- Convert stored `<oembed>` tags to embed HTML at render time via the reversible text filter.
- Keep the database clean by persisting only the `<oembed url>` tag rather than provider markup.
- Render a Link field's value as an embedded media object using the provided link formatter.
- Download/refresh the required CKEditor 5 media-embed plugin JS with `drush ckeditor_media_embed:install`.
- Update the downloaded plugin to match core's current CKEditor version with `drush ckeditor_media_embed:update`.
- Pin a specific CKEditor version for the downloaded plugin via the `ckeditor_version` config key.
- Add accessible `title` attributes to embedded iframes automatically via the shipped object-alter hook.
- Implement `hook_ckeditor_media_embed_object_alter()` to rewrite or sanitize provider-returned embed HTML.
- Diagnose missing-plugin problems through the module's Status Report (`hook_requirements`) entry.
- Provide editors a consistent embedding UX across every content type that uses the text format.
- Migrate a Drupal 7 site's media embeds into CKEditor 5 oEmbed markup.
- Standardize social/media embedding on a single provider policy across the whole site.
- Present remote media in article listings by rendering embeds through the field formatter in a view mode.
- Let editorial teams embed rich media without granting Full HTML or raw-markup permissions.
