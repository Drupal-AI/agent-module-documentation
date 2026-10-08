# Video Embed HTML5 — configuration

The module's only settings control the **placeholder** shown while a client-side thumbnail is
being generated (i.e. when `php_ffmpeg` is not installed).

| Item | Value |
|---|---|
| Config object | `video_embed_html5.config` |
| `add_placeholder` | bool, default `true` — show a placeholder image while the JS thumbnail renders. |
| `placeholder` | managed-file id array, default `null` — a custom placeholder image (jpg/png). |
| Form route | `video_embed_html5.config.form` → `/admin/config/media/video-embed-html5` |
| Permission | `administer video_embed_html5` |
| Menu link | *Administration » Configuration » Media » Video Embed HTML5* |

Behaviour (`Html5::renderThumbnail()`):

- If a local FFmpeg-generated thumbnail exists, it is used and no placeholder logic runs.
- Otherwise, if `add_placeholder` is true, a placeholder `<img>` is rendered inside the
  canvas-thumbnail container: the uploaded `placeholder` file if set, else the module's bundled
  `img/placeholder.png`.
- If `add_placeholder` is false, no image shows until the JS canvas thumbnail appears.

When you upload a placeholder via the form, the module records file usage
(`file.usage` → `video_embed_html5/settings/0`) so the file is not garbage-collected.

## Read / set via Drush

```bash
drush config:get video_embed_html5.config
drush config:set video_embed_html5.config add_placeholder 0 -y   # disable placeholder
drush config:set video_embed_html5.config add_placeholder 1 -y   # enable placeholder
```

The `placeholder` value is an array of file ids (as saved by the `managed_file` element);
set it through the form rather than by hand so file-usage is tracked.
