<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Video Embed Rutube adds Rutube as a provider for Video Embed Field, so a Rutube URL pasted into a video field renders as an embedded player and a thumbnail the same way a YouTube or Vimeo URL does.

---

Video Embed Field's design is one provider plugin per platform, and the contrib ecosystem fills in the platforms core contributors do not ship — this is the Rutube one. The whole module is a single class, `Rutube` (a `@VideoEmbedProvider` plugin id `rutube`). It matches `rutube.ru/video/<id>` and `rutube.ru/shorts/<id>` URLs with a regex, pulls out the video id (Rutube's 32-character hex hash, constrained to `[a-z0-9]`), and from that builds an `https://rutube.ru/play/embed/<id>` iframe via Video Embed Field's `video_embed_iframe` render element — carrying the field formatter's width, height and `frameborder`/`allowfullscreen`/`allow` attributes, adding `autoplay` to the `allow` list when the formatter enables it, and appending a `?t=<seconds>` start offset when the source URL had one. Thumbnails are resolved through Rutube's oEmbed endpoint (`https://rutube.ru/api/oembed/?url=https://rutube.ru/video/<id>/&format=json`): the plugin reads `thumbnail_url` from that JSON and hands it to the parent module, which downloads and caches the poster locally under `video_thumbnails`. Everything else — the field type, the formatters, the WYSIWYG/CKEditor integration and the Media source — comes from `video_embed_field` itself; Rutube is just the adapter. Version **3.0.1** on core `^10.3 || ^11`, requiring `video_embed_field:^3`. Two things worth stating whenever it is recommended. **Any third-party video embed is a privacy and consent question**, because the player sets cookies and reports the view to its host, so it belongs behind the site's consent manager the same way an analytics script does. And **provider plugins are thin and fragile**: when Rutube changes its embed-URL format or its oEmbed endpoint the plugin quietly breaks until someone updates it, so check the release date against the platform's current behaviour rather than assuming it still works.

---

- Embed a Rutube video in a content field.
- Serve a Russian-speaking audience where YouTube is unreliable or inappropriate.
- Add a regional video platform alongside the built-in YouTube and Vimeo providers.
- Paste a `rutube.ru/video/...` URL into a Video Embed Field and get a player.
- Embed a Rutube `shorts` URL.
- Show a Rutube-sourced thumbnail as a teaser or listing image.
- Start a Rutube embed at a specific time using a `?t=` offset in the URL.
- Enable autoplay for a Rutube embed through the field formatter.
- Set a fixed width and height for the Rutube player via the formatter.
- Use Rutube as a Media source (through Video Embed Field's media integration).
- Embed a Rutube video inside a WYSIWYG/CKEditor body.
- Keep video handling consistent across providers on a multi-platform site.
- Add a lazy-loaded video thumbnail that links to the player.
- Embed a training or webinar video hosted on Rutube.
- Support a regional news or media site that publishes to Rutube.
- Add Rutube video to a Views listing or grid.
- Localise a media strategy for markets where Rutube dominates.
- Show a responsive Rutube player in a full-width content region.
- Gate a Rutube embed behind a cookie-consent manager.
- Migrate existing Rutube links stored as plain URLs into rendered embeds.
- Provide editors a paste-a-URL workflow instead of hand-writing iframe markup.
- Reuse Video Embed Field's thumbnail caching for Rutube posters.
