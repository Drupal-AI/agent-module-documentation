# Field Tokens — manual setup guide

**Field Tokens** (`field_tokens`) adds two powerful new families of tokens to Drupal's Token
system, so you can drop rendered field output and raw field values into any token‑aware text
— emails, Pathauto URL patterns, Views rewrites, messages — without writing a line of PHP.

The first family is **formatted‑field** tokens: they run a field through any field formatter
and return the rendered markup. For example,
`[node:field_image-formatted:0:image:image_style-thumbnail]` outputs the first image of a
field through the *Image* formatter at the *thumbnail* image style. The second family is
**field‑property** tokens, which read a raw property such as a link URI, an image's alt text,
or an entity‑reference target id, e.g. `[node:field_image-property:0:alt]`. There is also a
`[<entity>:delta]` token that reports an item's position within a multi‑value field (used, for
instance, by [filefield_paths] to build per‑item filenames).

The token grammar supports single items, comma lists (`0,2,4`), ranges (`0-3`), a wildcard
(`*`), inline formatter settings (including nested settings via dot notation), and chaining
into referenced entities. It also integrates with the
[Custom Formatters](https://www.drupal.org/project/custom_formatters) HTML + Token engine.

There is **no configuration UI** — enable the module and the new tokens appear on every
fieldable entity (node, taxonomy term, user, media, paragraph, file, and so on). The easiest
way to discover them is the Token browser dialog that appears next to token‑enabled fields.
Field Tokens depends on the [Token](https://www.drupal.org/project/token) module and needs
PHP 8.2 or newer.

This guide is written for a **human** clicking through the admin UI. If you want the full
token grammar, the delta specification, chaining rules and internals for an AI coding agent,
read the sibling [`agent/`](../agent/start.md) docs.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.

## How to use it

There is nothing to configure — you write the tokens directly wherever tokens are accepted.
A few common patterns:

- **Render a field through a formatter:**
  `[node:field_image-formatted:0:image:image_style-thumbnail]` — first image, *Image*
  formatter, *thumbnail* style. Omit the delta to render all items; use `:*:` for the same.
- **Use the field's default formatter:** leave the formatter segment empty, e.g.
  `[node:field_image-formatted:image]`.
- **Read a raw property:** `[node:field_ref-property:0:target_id]` (the referenced id),
  `[node:field_image-property:0:alt]` (alt text).
- **Chain into a referenced entity:** `[node:field_author-property:0:entity:name]`.
- **Pass a formatter setting inline:** append `SETTING-VALUE` pairs, e.g.
  `image_style-large`; nested settings use dot notation like `image_loading.attribute-eager`.

When editing a field that shows a **Browse available tokens** link, open it to see the new
`…-formatted` and `…-property` tokens listed for each field. For the complete grammar (delta
lists, ranges, mixed specs, and edge cases) see the [`agent/`](../agent/start.md) docs.
