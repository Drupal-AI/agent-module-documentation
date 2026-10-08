<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Plus Gemini (ai_plus_gemini) — submodule

**Gemini-specific image-dimension vocabulary for AI Plus.** Package `AI`, core `^10.3 || ^11`, lifecycle `experimental`. Version 1.0.2. Depends on `ai_plus` and `gemini_provider`. No routes, permissions, config, schema, or event subscribers — it registers **one service**: an image-dimension adapter (`ai_plus_gemini.services.yml`, autowired, tagged `ai_plus.image_dimension_adapter` at priority 0, so it is chosen ahead of the parent's catch-all `AspectRatioDimensionAdapter` at −100).

Enable it when your configured `text_to_image` provider is Gemini so the AI requests images with Gemini's own aspect-ratio conventions.

## `GeminiDimensionAdapter` — `src/ImageDimension/GeminiDimensionAdapter.php`

Implements `ImageDimensionAdapterInterface` (defined by the parent module):

- `supports(string $provider_id)` → TRUE only when `$provider_id === 'gemini'`.
- `getGuidance()` → returns a prompt fragment (appended by `ImageDimensionHandler`/manager to the image-generation field guidance the AI sees) telling the model to add an `aspectRatio` (default `16:9`) chosen from the image's layout role: `16:9` hero/banner, `4:3` standard/medium block, `1:1` thumbnail/grid tile, `9:16` tall sidebar/portrait.
- `extractConfiguration(array $item, string $model_id)` → reads the AI-supplied **camelCase `aspectRatio`** key (Gemini's images API convention, distinct from the default adapter's snake_case `aspect_ratio`), validates it against Gemini's accepted set `{1:1, 2:3, 3:2, 3:4, 4:3, 9:16, 16:9}` (mirrors `gemini_provider`'s `api_defaults.yml`), and returns `['aspectRatio' => $value]` for `AiProviderInterface::setConfiguration()`, or `[]` (provider default) when absent/invalid.

The returned configuration is opaque to `ImageGenerationProcessor`, which just passes it to `$provider->setConfiguration()` before `textToImage()`. Contract: how the parent selects and uses adapters is in [../architecture/overview.md](../architecture/overview.md).
