<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FeaturedImageGenerator service

Service id **`ai_featured_image.generator`**, class
`Drupal\ai_featured_image\Service\FeaturedImageGenerator` (`ai_featured_image.services.yml`).
Constructor args: `@http_client` (Guzzle), `@file.repository`, `@stream_wrapper_manager`,
`@config.factory`.

## `generateImageForNode(NodeInterface $node): ?File`

Single public method. Steps, from `src/Service/FeaturedImageGenerator.php`:

1. Read `ai_featured_image.settings`: `openai_api_key` and `prompt_template`
   (default `'Header image about: [title]'`).
2. Read the node body (`body.value` if the field exists and is non-empty, else `''`).
3. Build the prompt: `strtr($prompt_template, ['[title]' => $node->getTitle(), '[body]' => $body])`.
4. `POST https://api.openai.com/v1/images/generations` via the injected Guzzle client with
   headers `Authorization: Bearer <openai_api_key>` and `Content-Type: application/json`, and
   JSON body `{ prompt, n: 1, size: "1024x1024" }`.
5. Decode the response; if `data[0].url` is empty, return `NULL`.
6. `file_get_contents($image_url)` to download the generated PNG from the provider-returned URL.
7. Ensure `public://ai_images` exists (`file_system->prepareDirectory(..., CREATE_DIRECTORY)`),
   then persist as `featured-<time>.png` (it calls both `file_system->saveData()` and
   `file.repository->writeData()` with `EXISTS_REPLACE`; the File returned by `writeData()` is
   the return value).
8. Any `\Exception` is caught, logged to the `ai_featured_image` channel, and `NULL` is returned.

## Calling it directly

```php
$file = \Drupal::service('ai_featured_image.generator')
  ->generateImageForNode($node);
if ($file) {
  $node->set('field_image', ['target_id' => $file->id()]);
}
```

The presave hook is the only in-module caller; a custom module can invoke the service the same
way (e.g. from a queue worker) to move generation out of the synchronous save path.

## Provider details

- Hard-wired to OpenAI's DALL-E image endpoint; the model/size are not configurable in 1.0.x
  (`n=1`, `1024x1024`). There is no drupal/ai abstraction here.
- TLS is Guzzle's default (certificate verification on); the endpoint and the download are both
  HTTPS.
