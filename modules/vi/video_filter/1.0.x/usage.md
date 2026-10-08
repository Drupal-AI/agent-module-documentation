Video Filter is a text-format input filter that converts a simple `[video:URL ...]` tag in body/content into an embedded video player (usually an `<iframe>`), matching the URL against a pluggable set of provider "codecs" (YouTube, Vimeo, Dailymotion, and ~45 others).

---

Enable the filter on a text format (*Text formats and editors*) and authors can write `[video:https://www.youtube.com/watch?v=ID]` instead of raw embed HTML. The `video_filter` filter plugin (`TYPE_TRANSFORM_REVERSIBLE`) scans text for `[video:...]` tags, tries each **enabled** provider plugin's regexp against the URL, and when one matches renders one of three Twig templates — `video-filter-iframe.html.twig` (the common case, an `<iframe src>`), `video-filter-html.html.twig` (raw HTML/oEmbed via `{{ video.html|raw }}`), or the deprecated `video-filter-flash.html.twig`. Providers are plugins of the module's own `video_filter` plugin type (annotation `@VideoFilter`, namespace `Plugin/VideoFilter`, base class `VideoFilterBase`), each declaring `id`, `name`, `regexp`, aspect `ratio`, and implementing `iframe()`/`html()` to build the embed URL from the regexp capture groups. Per-format settings (schema `filter_settings.video_filter`) are default `width`/`height`, the checkbox list of enabled `plugins`, and `allow_multiple_sources` (comma-separated URLs, one picked at random). Per-video inline options — `width:`, `height:`, `ratio:`, `align:`, `autoplay:`, etc. — are parsed from the tag (values restricted by regex to `[0-9a-zA-Z/]`). A `hook_video_filter_video_alter()` lets modules adjust the final `$video` array. The module also ships a legacy CKEditor 4 plugin/dialog and a preview route for the WYSIWYG button; on Drupal 11 (no CKEditor 4) the filter itself still works when typed. A `video_filter_example` submodule demonstrates adding a custom codec.

---

- Let content authors embed a YouTube video by pasting `[video:https://youtu.be/ID]` into a body field.
- Embed Vimeo, Dailymotion, Twitch, Spotify, Instagram, and dozens of other providers via one tag syntax.
- Give non-technical editors a consistent embed syntax instead of provider-specific `<iframe>` code.
- Restrict which video providers are allowed on a given text format via the enabled-plugins checkboxes.
- Set a default player width/height per text format.
- Override width, height, or aspect ratio for a single video inline (`[video:URL width:640 height:360]`).
- Force an aspect ratio with `ratio:16/9` or `ratio:4/3` on a specific embed.
- Align an embedded player left/right/center with `align:right`.
- Enable autoplay or other provider options per video (`autoplay:1`) where the codec supports it.
- Offer a random video from several sources using comma-separated URLs and `allow_multiple_sources`.
- Add a new/unsupported provider by writing a `@VideoFilter` codec plugin (see the example submodule).
- Adjust an existing embed's parameters globally with `hook_video_filter_video_alter()`.
- Support a YouTube start time / playlist via URL parameters (`?t=2m3s`, `&list=...`).
- Provide oEmbed/raw-HTML embeds through a codec's `html()` method for providers without a simple iframe.
- Migrate legacy `[video:...]` content from older Drupal sites (filter syntax is compatible).
- Keep video markup out of stored content (reversible filter) so embeds re-render on each view.
- Localize/limit embeds by enabling the filter only on trusted formats used by specific roles.
- Show usage tips to editors automatically via the filter's long tip text listing supported sites.
- Serve a WYSIWYG "Video Filter" button/dialog for editors on a CKEditor 4 setup (legacy).
