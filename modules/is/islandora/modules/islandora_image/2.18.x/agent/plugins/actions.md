# Image derivative Actions

Two core-Action plugins (`src/Plugin/Action/`). Both are *event emitters*: they build a JSON payload and
push it onto a STOMP/AMQP queue that the **Houdini** microservice consumes; Houdini fetches the source,
runs ImageMagick, and PUTs the converted file back through Islandora's media-source REST routes. They do **not**
convert anything in PHP. Configure them as standalone actions at `/admin/config/system/actions`, or (usual case)
as the Action of a **Context → Derivative reaction** — see parent
[plugins/context.md](../../../../../2.18.x/agent/plugins/context.md).

## `generate_image_derivative` — `type = node`

`GenerateImageDerivative extends \Drupal\islandora\Plugin\Action\AbstractGenerateDerivative`. Given a node,
finds the source media (by `source_term_uri`), asks Houdini to convert it, and creates a **new media** of
`destination_media_type` on the node.

Default configuration (own overrides on top of the core base):

| key | default | meaning |
|---|---|---|
| `queue` | `islandora-connector-houdini` | STOMP/AMQP destination the connector listens on |
| `mimetype` | `image/jpeg` | target mimetype; validated to start with `image/` |
| `destination_media_type` | `image` | Drupal media type created for the derivative |
| `path` | `[date:custom:Y]-[date:custom:m]/[node:nid].jpg` | token path within the scheme |
| `event` | `Generate Derivative` | (disabled in form) |
| `args` | `''` | extra ImageMagick `convert` args, e.g. `-resize 50%` |
| `source_term_uri` / `derivative_term_uri` | `''` | taxonomy-term URIs identifying source and output `field_media_use` |
| `scheme` | `system.file` `default_scheme` | Flysystem/stream scheme for the output |

Runtime (`AbstractGenerateDerivative::generateData()`): resolves the source term → source media → source file,
sets `source_uri` to the file's download URL; resolves the derivative term; sets `destination_uri` to
`Url::fromRoute('islandora.media_source_put_to_node', {node, media_type, taxonomy_term})`; token-replaces `path`
into `file_upload_uri = scheme://path`; strips the term/path/scheme/media-type keys and emits the rest.
If source and derivative media resolve to the same media it throws `IslandoraDerivativeException` (halts quietly).

## `generate_image_derivative_file` — `type = media`

`GenerateImageDerivativeFile extends \Drupal\islandora\Plugin\Action\AbstractGenerateDerivativeMediaFile`.
Attaches the converted file to an **image field on the emitting media itself** ("multi-file media") rather than
creating a new media. Use for JPEG-into-an-image-field; for TIFF/JP2 use the core `generate_derivative_file`.

Default configuration overrides: `path = [date:custom:Y]-[date:custom:m]/[media:mid]-ImageService.jpg`,
`queue = islandora-connector-houdini`, `scheme = default_scheme`. The build form forces `mimetype`'s
`#value` to `image/jpeg` and adds a required **Destination Image field** select (`destination_field_name`) listing
the `image`-type fields on media (minus `thumbnail`). Base default `source_term_uri = http://pcdm.org/use#OriginalFile`,
`source_field_name = field_media_file`. Runtime `destination_uri` uses
`Url::fromRoute('islandora.attach_file_to_media', {media, destination_field})`; the output scheme is taken from the
destination field's `uri_scheme` storage setting.

## Config schema

`action.configuration.generate_image_derivative` (mapping): `queue`, `event`, `destination_media_type`,
`source_term_uri`, `derivative_term_uri`, `mimetype`, `args`, `scheme`, `path` — all `type: text`.
(The media-file action reuses the core `generate_derivative_file` schema from Islandora Core.)
