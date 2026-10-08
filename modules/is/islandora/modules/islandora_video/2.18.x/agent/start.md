# Islandora Video — agent index

Adds a video derivative-generation **Action** plus an HTML5 video **field formatter** (with WebVTT captions and
size/muted settings) to [Islandora Core](../../../../2.18.x/agent/start.md). Transcoding is done by the
**Homarus** (FFmpeg) microservice, not in PHP. Config-light: one Action class, one formatter, a `hook_theme`, a
config schema. **No settings page, no permissions, no services, no drush.** Depends only on `islandora`.

- **The `generate_video_derivative` Action (id, defaults, config keys, runtime data flow)** →
  [plugins/actions.md](plugins/actions.md)
- **The `islandora_file_video` formatter (muted/width/height settings) + `<video>` template** →
  [fields/formatter.md](fields/formatter.md)
- **How derivatives are wired up (Context Condition + Derivative reaction, the microservice round-trip)** →
  parent [plugins/context.md](../../../../2.18.x/agent/plugins/context.md)

## Key facts

- Action `generate_video_derivative` (`type = node`, extends core `AbstractGenerateDerivative`). Defaults:
  `queue = islandora-connector-homarus`, `mimetype = video/mp4`, `destination_media_type = video`,
  `path = …/[node:nid].mp4`. `args` = extra FFmpeg args; `mimetype` validated to start with `video/`.
- Field formatter `islandora_file_video` ("Video with Captions"), field type `file`, extends core
  `IslandoraFileMediaFormatterBase`; `getMediaType()` = `video`. Extra settings: `muted` (bool), `width` (640),
  `height` (480).
- Theme hook `islandora_file_video` (vars: `files`, `tracks`, `attributes`) → `templates/islandora-file-video.html.twig`.
- Config schema keys: `action.configuration.generate_video_derivative`;
  `field.formatter.settings.islandora_file_video` (extends core `field.formatter.settings.file_video`).
- No `config/install/` — media types / Contexts come from the full Islandora install, not this submodule.
