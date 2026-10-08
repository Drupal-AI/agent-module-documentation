# Services & code entry points

Services declared in `openseadragon.services.yml`.

## `openseadragon.config` — `\Drupal\openseadragon\Config`
Reads `openseadragon.settings`. Implements `ConfigInterface`, cacheable.
- `getSettings(bool $filterNull = FALSE)` — `viewer_options + default_options` (user over defaults),
  optionally null-filtered (nulls are stripped to avoid JS issues).
- `getDefaultSettings(bool $filterNull = FALSE)` — just `default_options`.
- `getIiifAddress()` — the `iiif_server` base URL (viewers early-return if null/empty).
- `getManifestView()` — the configured manifest View id.

## `openseadragon.manifest_parser` — `\Drupal\openseadragon\IIIFManifestParser`
Args: `token`, `current_route_match`, `http_client` (Guzzle), logger channel.
- `getTileSources($manifest_url)` →
  1. If a `node` route param exists, `token->replace($manifest_url, ['node' => $node])`.
  2. If the URL doesn't start with `http`, make it absolute against `<front>`.
  3. `httpClient->get($url)`, `json_decode`; on empty/undecodable JSON logs a warning, returns FALSE.
  4. Walks `sequences[].canvases[].images[]` and collects each `resource.service.@id` as a tile source.
  5. `RequestException` → warning logged, returns FALSE.
- The manifest URL originates from the block's admin config (`administer blocks`); tokens only
  substitute the current node's values into an admin-defined template — the request host is not
  end-user controlled. This is the module's intended outbound fetch (a IIIF viewer).
- Note: the parser assumes `$manifest['sequences']` exists (IIIF Presentation v2 shape); a manifest
  lacking it will error rather than return `[]`.

## `openseadragon.fileinfo` — `\Drupal\openseadragon\File\FileInformation`
Args: `file.mime_type.guesser`, `stream_wrapper_manager`.
- `getFileData(File $file)` → `['mime_type' => ..., 'full_path' => $file->createFileUrl(FALSE)]`,
  only for image mime types (falls back to the extension guesser; non-images return `[]`).

## Plugins (core plugin types, no custom manager)
- **Field formatter** `openseadragon_image`
  (`src/Plugin/Field/FieldFormatter/OpenSeadragonImageFormatter.php`), extends core
  `ImageFormatterBase`, field types `image`, `file`. `viewElements()` emits one
  `#theme => 'openseadragon_formatter'` element per file (with the file's cache tags).
  `template_preprocess_openseadragon_formatter()` builds tile sources and `drupalSettings`.
- **Block** `openseadragon_block` (`src/Plugin/Block/OpenseadragonBlock.php`). `blockForm()` collects
  `iiif_manifest_url` (token-validated, `node` token type). `build()` themes
  `openseadragon_iiif_manifest_block`, with cache tags `node_list`, `media_list`, the manifest View's
  tags, and the current node; cache context `route`.

## Render-time flow
`template_preprocess_openseadragon_formatter` / `template_preprocess_openseadragon_iiif_manifest_block`
(in `openseadragon.module`) attach `openseadragon/init` and set
`drupalSettings.openseadragon[<viewer_id>] = ['basePath' => Url::fromUri(iiif_server), 'fitToAspectRatio' => …, 'options' => ['id','prefixUrl','tileSources'] + viewer_settings]`.
`js/openseadragon_viewer.js` instantiates the viewer from that settings blob.
