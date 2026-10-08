# Islandora Audio — agent index

Adds an audio derivative-generation **Action** plus an HTML5 audio **field formatter** (with WebVTT captions)
to [Islandora Core](../../../../2.18.x/agent/start.md). Transcoding is done by the **Homarus** (FFmpeg)
microservice, not in PHP. Config-light: one Action class, one formatter, a `hook_theme`, a JS library, a config
schema. **No settings page, no permissions, no services, no drush.** Depends only on `islandora`.

- **The `generate_audio_derivative` Action (id, defaults, config keys, runtime data flow)** →
  [plugins/actions.md](plugins/actions.md)
- **The `islandora_file_audio` formatter + `<audio>` template + captions JS** → [fields/formatter.md](fields/formatter.md)
- **How derivatives are wired up (Context Condition + Derivative reaction, the microservice round-trip)** →
  parent [plugins/context.md](../../../../2.18.x/agent/plugins/context.md)

## Key facts

- Action `generate_audio_derivative` (`type = node`, extends core `AbstractGenerateDerivative`). Defaults:
  `queue = islandora-connector-homarus`, `mimetype = audio/mpeg`, `destination_media_type = audio`,
  `args = -codec:a libmp3lame -q:a 5`, `path = …/[node:nid]-[term:name].mp3`. `mimetype` validated to start with `audio/`.
- Field formatter `islandora_file_audio` ("Audio with Captions"), field type `file`, extends core
  `IslandoraFileMediaFormatterBase`; `getMediaType()` = `audio`.
- Theme hook `islandora_file_audio` (vars: `files`, `tracks`, `attributes`) → `templates/islandora-file-audio.html.twig`.
- Library `islandora_audio/audio` (`js/audio.js`) parses WebVTT `media_track` files and shows synced captions.
- Config schema keys: `action.configuration.generate_audio_derivative`;
  `field.formatter.settings.islandora_file_audio` (extends core `field.formatter.settings.file_audio`).
- No `config/install/` — media types / Contexts come from the full Islandora install, not this submodule.
