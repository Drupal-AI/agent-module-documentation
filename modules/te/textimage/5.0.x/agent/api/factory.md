<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Textimage API (`textimage.factory`)

Service id `textimage.factory` — interface `Drupal\textimage\TextimageFactoryInterface`
(the canonical service id is the interface FQN; `textimage.factory` is a still-working but
deprecated alias). It returns fluent `Drupal\textimage\TextimageInterface` builder objects.
Throws `Drupal\textimage\TextimageException` — wrap calls in try/catch.

## Build an image

```php
use Drupal\Core\Render\BubbleableMetadata;
use Drupal\image\Entity\ImageStyle;

$meta = new BubbleableMetadata();
$textimage = \Drupal::service('textimage.factory')->get($meta)
  ->setStyle(ImageStyle::load('my_textimage_style'))  // style with Text overlay effect(s)
  ->process(['Hello world'])                           // array: one string per overlay effect
  ->buildImage();

$uri    = $textimage->getUri();     // e.g. public://textimage/…
$url     = $textimage->getUrl();    // \Drupal\Core\Url
$w = $textimage->getWidth();
$h = $textimage->getHeight();
```

## Factory methods (`TextimageFactoryInterface`)

- `get(?BubbleableMetadata): TextimageInterface` — new builder.
- `load(string $tiid): TextimageInterface` — load cached Textimage metadata by id.
- `processTextString($text, $token_data = [], $meta = null): string` — detokenise one string.
- `isTextimage(ImageStyleInterface): bool` — does the style have Text overlay effects.
- `getTextimageStyleOptions(bool $limit_to_textimage = false): array` — style options list.
- `flushStyle(ImageStyleInterface)`, `flushAll()` — clear generated files/metadata.
- `getStoreUri(?string $path, ?string $scheme = null): string` — URI in the textimage_store tree.
- `processTokens($key, $tokens, $data, $meta): array` — implements the textimage tokens.
- `getTextFieldText(FieldItemListInterface): array` — sanitized text of a text field.

## Builder input methods (call BEFORE `process()`)

`setStyle(ImageStyle)`, `setEffects(array)` (dynamic effects instead of a stored style),
`setTargetExtension($ext)`, `setGifTransparentColor($hex)`,
`setSourceImageFile(FileInterface $file, ?$w, ?$h)` (background image),
`setTokenData(array)`, `setTemporary(bool)` (uncached, cron-cleaned preview),
`setTargetUri($uri)` (explicit output path, uncached),
`setBubbleableMetadata(?BubbleableMetadata)`.

## Producing / reading

`process(array|string|null $text)` → sets id/uri/url; `buildImage()` writes the file;
`load($id)` then `buildImage()` defers generation to another request. After processing:
`id()`, `getText()`, `getUri()`, `getUrl()`, `getHeight()`, `getWidth()`,
`getBubbleableMetadata()`.

Caching is on by default (keyed on style+text); opt out with `setTemporary(true)` or
`setTargetUri()`. Render the result with the `textimage_formatter` theme hook
(see `theming/formatter.md`).
