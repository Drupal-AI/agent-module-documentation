# Configuring the TinyPNG processor

There is no standalone settings page; TinyPNG is a **processor** added to an Image Optimize pipeline
provided by the required `imageapi_optimize` module.

## Steps
1. Go to *Configuration → Media → Image Optimize pipelines*
   (`/admin/config/media/imageapi-optimize-pipelines`).
2. Add or edit a pipeline, then **Add a new processor → TinyPNG**.
3. Enter the **TinyPNG API key** (get one at https://tinypng.com). It is required and validated on
   save via `\Tinify\validate()`; an invalid key sets a form error.
4. Save the pipeline, then assign it to one or more image styles (image style edit form → optimize
   pipeline) so their derivatives are processed.

## Configuration keys
Processor config schema `imageapi_optimize.processor.tinypng`:

| Key | Type | Default | Notes |
|---|---|---|---|
| `api_key` | string | `NULL` | TinyPNG/Tinify API key; `defaultConfiguration()` returns `['api_key' => NULL]` |

Form: `buildConfigurationForm()` renders a required `#type => textfield` (`#size` 32).
`validateConfigurationForm()` calls `\Tinify\setKey()` + `\Tinify\validate()`.
`submitConfigurationForm()` saves `api_key` into the processor configuration.

## Behavior
`applyToImage($image_uri)` (called by the pipeline when an image style generates a derivative):
- `\Tinify\setKey($api_key)`, `file_get_contents($image_uri)`,
  `\Tinify\fromBuffer($bytes)->toBuffer()`, then `FileSystem::saveData(..., $image_uri, EXISTS_REPLACE)`.
- Catches `AccountException` (verify key / account limit), `ClientException`, `ServerException`,
  `ConnectionException`, and generic `\Exception`; logs each to the `imageapi_optimize` logger channel
  and returns FALSE (leaving the un-optimized derivative in place).

## Operational notes
- Requires the `tinify/tinify` Composer library (installed with the module); missing library →
  `hook_requirements` install/runtime error.
- Every optimized derivative is one metered TinyPNG API call — scope the pipeline to the styles that
  benefit most to control cost/quota.
- To re-run optimization, flush the image style so derivatives regenerate.
- The key is stored in config; override it per-environment from `settings.php`
  (`$config['imageapi_optimize.pipeline.<id>']...`) rather than committing a real key.
