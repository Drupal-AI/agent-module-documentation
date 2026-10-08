# Islandora Image — agent index

Adds image derivative-generation **Actions** to [Islandora Core](../../../../2.18.x/agent/start.md).
An image "master" media is fetched by the **Houdini** (ImageMagick `convert`) microservice, converted, and
the result PUT back into Drupal as a new media or as a file on an existing media. Config-light: two Action
plugin classes + a config schema + `hook_help()`. **No settings page, no permissions, no services, no drush.**
Depends only on `islandora`.

- **The two derivative Actions (ids, defaults, config keys, runtime data flow)** → [plugins/actions.md](plugins/actions.md)
- **How derivatives are wired up (Context Condition + Derivative reaction, the microservice round-trip)** →
  parent [plugins/context.md](../../../../2.18.x/agent/plugins/context.md)

## Key facts

- Action `generate_image_derivative` (`type = node`, extends core `AbstractGenerateDerivative`) — creates a
  **new derivative media** on the node. Defaults: `queue = islandora-connector-houdini`, `mimetype = image/jpeg`,
  `destination_media_type = image`, `path = [date:custom:Y]-[date:custom:m]/[node:nid].jpg`.
- Action `generate_image_derivative_file` (`type = media`, extends core `AbstractGenerateDerivativeMediaFile`) —
  attaches the converted file to an **image field on the emitting media** (multi-file media). Defaults:
  `queue = islandora-connector-houdini`, form forces `mimetype = image/jpeg`,
  `path = …/[media:mid]-ImageService.jpg`; `destination_field_name` is required.
- `args` = extra ImageMagick `convert` args (e.g. `-resize 50%`). `mimetype` is validated to start with `image/`.
- Config schema key: `action.configuration.generate_image_derivative` (in `config/schema/islandora_image.schema.yml`).
- No `config/install/` — the module ships no media type or Context; those come from `islandora_core_feature`
  / `islandora_tags` migration in a full install. The image field **formatter** lives in Islandora Core, not here.
