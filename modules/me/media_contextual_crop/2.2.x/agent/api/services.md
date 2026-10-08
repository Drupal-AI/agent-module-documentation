# Service `media_contextual_crop.service` + derivative delivery

`Drupal\media_contextual_crop\MediaContextualCropService` is the engine: it turns an image +
crop settings into a **context-specific crop entity** and a **context-specific derivative URL**,
and cleans those derivatives up. Constructor args: `plugin.manager.media_contextual_crop`,
`file_system`, `stream_wrapper_manager`, `entity_type.manager`, `entity.repository`,
`file_url_generator`, `request_stack`, `config.factory`.

## Methods

| Method | What it does |
|---|---|
| `generateContextualizedImage(array $old_image, array $settings): string` | Loads the `@MediaContextualCrop` plugin `$settings['plugin_id']`, calls its `saveCrop($settings['crop_setting'], $settings['image_style'], $old_image['#uri'], $settings['context'], w, h)` to get a `crop_id`, then returns `createContextualizedDerivativePath(...)`. |
| `createContextualizedDerivativePath($old_uri, $image_style, $crop_id, $just_uri = FALSE): string` | Builds the derivative URI (below). With `$just_uri` returns the bare URI; otherwise a full URL with the core `itok` token (unless `image.settings:suppress_itok_output`) plus an `h` cache-buster. |
| `getCropHashToken(Crop $crop): string` | `substr(md5(position . anchor), 0, 8)` — the `h` query used to bust CDN/proxy caches when a crop changes. |
| `styleUseMultiCrop(string $style_name): bool` | TRUE if the image style contains an effect whose `data.crop_type` belongs to a registered crop plugin (`image_style_effect`). |
| `flushStyle(ImageStyle $style, ?string $path)` | Delete contextual derivatives for a style (all, or for one source image). Called from `hook_image_style_flush`. |
| `buildContextualFolderPath($style_id, $image_uri): string` | `public://contextual/styles/{style}[/{scheme}/{target_as_folder}]`. |
| `deleteDerivative(Crop $crop)` | Delete every derivative generated from a crop across all styles using its crop type. Called from `hook_crop_delete`. |
| `getBaseContext(EntityInterface $e, string $field_name='', ?int $delta=NULL): string` | Build a context string `entity_type:bundle:id.field.delta`. |
| `getContextualCrops($entity, $field_name)` / `getContextualCropsFromBaseContext(string $base)` | Load crops matching `context LIKE "{base}%"` (accessCheck FALSE). |

## Derivative URI shape

```
{scheme}://contextual/styles/{image_style}/{source_scheme}/{target_as_folder}/{crop_id}.{new_ext}
```

`target_as_folder` = the source image's path target with every `.` replaced by `__`;
`new_ext` = the style's derivative extension for the source extension; `scheme` = the source
image's scheme (e.g. `public`).

## How a contextual derivative is served

Pretty URL → path processor → route/controller:

1. **Routes** (`_access: 'TRUE'`, like core's own image routes):
   - `media_contextual_crop.style_private` — `/system/files/contextual/styles/{image_style}/{context}/{scheme}` (`*.routing.yml`).
   - `media_contextual_crop.style_public` — `{public_files_dir}/contextual/styles/{image_style}/{context}/{scheme}` with `context: \d+`, added by `Routing\ImageStyleRoutes::routes()` (extends core `image` route provider).
2. **Path processor** `path_processor.media_contextual_crop` (`PathProcessor\PathProcessorImageStyles`, inbound priority 350): parses the pretty URL, loads the `crop` by id, **verifies the requested image path matches the crop's stored `uri`** (else `NotFoundHttpException`), sets `?file={crop_uri}` for private-file access checks, and rewrites to the controller route.
3. **Controller** `Controller\ContextualImageStyleDownloadController::process(Request, int $context, ImageStyleInterface $image_style, $scheme)` extends core `ImageStyleDownloadController` and reuses its refactored helpers `checkToken()` / `authorizedDerivativeGeneration()` / `isSchemePublic()` / `checkNormalizedScheme()` / `sourceImageExists()` (added by the core patch `2685905` this module requires). It: loads the crop, derives the **original** image URI from `$crop->uri`, validates the `itok` token against that original image + style, for non-public schemes runs `hook_file_download` (denies on `-1`/empty), then generates (with a lock) and streams the derivative via `BinaryFileResponse`.

Access therefore mirrors core image-derivative delivery: the `itok` token gates public
derivatives; `hook_file_download` gates private ones. The `{context}` param is a stored crop
entity id, not free-form input, and the path processor rejects crop/image mismatches.

## Config read & install

Only reads core `image.settings` (`suppress_itok_output`). The module defines no config object
and no schema.

`hook_install` / `update_10220` add the DB index **`idx_crop_context_cid`** on
`crop_field_data(context, cid)` (MySQL/MariaDB uses a 191-char prefix on `context`) to speed up
the `context LIKE "{base}%"` prefix lookups and joins used by `getContextualCropsFromBaseContext()`.
`update_10202` / `update_10210` delete legacy public derivative folders left by 1.x/2.0.x.
