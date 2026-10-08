# Tokens

Defined in `paragraphs_summary_token.tokens.inc` (`hook_token_info_alter` + `hook_tokens`).

## Registration

For **every** content entity type that has at least one `entity_reference_revisions` field, the
module adds tokens under that field's token, named `<entity-token>-<field_name>`:

- `summary` — always added.
- `image` — added only when core `image` module is enabled. Its type is a dynamic
  `paragraphs_summary_token_image_styles` token group, so every configured image style plus the
  image properties are exposed as chained tokens.

So for a `node` with field `field_paragraphs` you get, among others:

```
[node:field_paragraphs:summary]
[node:field_paragraphs:image]                 # absolute URL, original image (default property)
[node:field_paragraphs:image:<style>]         # <style> = an image style machine name, e.g. large
[node:field_paragraphs:image:<style>:<prop>]  # explicit property
```

## Image properties

`<prop>` (3rd chained part, default `url`) maps to `ImageBuilder::build()`:

| Property | Returns |
|---|---|
| `url` | Absolute URL (styled derivative URL if a style is given) — **default** |
| `uri` | Relative URL / stream URI (`buildUri` for a style) |
| `width` / `height` | Pixel dimensions (style-transformed if a style is given) |
| `mimetype` | MIME type (of the derivative if a style is given; creates it if missing) |
| `filesize` | Byte size (of the derivative if a style is given; creates it if missing) |

Parsing: the token name after `image` is split on `:` — `name_parts[1]` = image style id
(loaded with `ImageStyle::load()`), `name_parts[2]` = property. `[…:image]` alone → style NULL,
property `url`.

## How the values are computed

- `summary` → `paragraphs_summary_token.text_summary_builder->build($field, 300)`.
- `image…` → `paragraphs_summary_token.image_builder->build($field, $style, $property)`.

Both walk the paragraph tree (see [../services.md](../services.md) for the exact search order) and
use the **current language** translation of each paragraph. If nothing matches, the token resolves
to an empty string.

## Usage

These are ordinary core tokens — usable in Metatag, Pathauto, mail bodies, and any token-aware
field, or resolved in code via `\Drupal::token()->replace('[node:field_paragraphs:summary]', ['node' => $node])`.
The token only exists on fields of type `entity_reference_revisions` (Paragraphs fields); it is not
restricted to a `paragraph` target type in registration, but the builders only extract data from
referenced paragraph / paragraphs-library entities.
