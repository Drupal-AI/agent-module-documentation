# Audio derivative Action

## `generate_audio_derivative` — `type = node`

`GenerateAudioDerivative extends \Drupal\islandora\Plugin\Action\AbstractGenerateDerivative`
(`src/Plugin/Action/GenerateAudioDerivative.php`). An *event emitter*: it builds a JSON payload and pushes it
onto the `islandora-connector-homarus` queue; the **Homarus** (FFmpeg) microservice fetches the source audio,
transcodes it, and PUTs the result back through Islandora's media-source REST routes. Nothing is transcoded in
PHP. Configure at `/admin/config/system/actions`, or as the Action of a **Context → Derivative reaction** —
see parent [plugins/context.md](../../../../../2.18.x/agent/plugins/context.md).

Default configuration (own overrides on top of the core base):

| key | default | meaning |
|---|---|---|
| `queue` | `islandora-connector-homarus` | STOMP/AMQP destination the FFmpeg connector listens on |
| `mimetype` | `audio/mpeg` | target mimetype; validated to start with `audio/` |
| `destination_media_type` | `audio` | Drupal media type created for the derivative |
| `args` | `-codec:a libmp3lame -q:a 5` | extra FFmpeg command-line args |
| `path` | `[date:custom:Y]-[date:custom:m]/[node:nid]-[term:name].mp3` | token path within the scheme |
| `event` | `Generate Derivative` | (disabled in form) |
| `source_term_uri` / `derivative_term_uri` | `''` | taxonomy-term URIs identifying source and output `field_media_use` |
| `scheme` | `system.file` `default_scheme` | output stream scheme |

Runtime is the inherited `AbstractGenerateDerivative::generateData()`: resolves source term → media → file
(`source_uri`), resolves the derivative term, sets `destination_uri` via
`Url::fromRoute('islandora.media_source_put_to_node', {node, media_type, taxonomy_term})`, and token-replaces
`path` into `file_upload_uri = scheme://path`. Same-source-and-target media throws `IslandoraDerivativeException`.

## Config schema

`action.configuration.generate_audio_derivative` (mapping, all `type: text`): `queue`, `event`,
`destination_media_type`, `source_term_uri`, `derivative_term_uri`, `mimetype`, `args`, `scheme`, `path`.
