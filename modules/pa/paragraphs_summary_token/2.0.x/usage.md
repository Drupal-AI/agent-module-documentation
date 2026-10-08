Paragraphs Summary Token adds token replacements that derive a plain-text summary and a representative image from a Paragraphs (entity_reference_revisions) field, so you can populate things like meta description or a teaser image from paragraph content that has no single "summary" field.

---

The module has no configuration UI (`configure` is null) and no permissions or Drush commands. It works purely through the core Token system: `hook_token_info_alter()` registers, for every entity type that has an `entity_reference_revisions` field, a `summary` token and (when the core Image module is on) an `image` token under that field, e.g. `[node:field_paragraphs:summary]` and `[node:field_paragraphs:image]`. `hook_tokens()` resolves them by delegating to two services. `paragraphs_summary_token.text_summary_builder` walks the referenced paragraphs, finds the first non-empty `text_long` field, strips tags and trims to 300 characters via core `text_summary()`. `paragraphs_summary_token.image_builder` finds the first `image` field or `media` reference (image source) and returns the requested property. Both builders recurse into nested paragraph fields and into Paragraphs Library items, and both respect the current language's translation of each paragraph. The image token accepts an optional image style and property, so `[node:field_paragraphs:image:large:url]` returns the URL of the `large` derivative; supported properties are `url` (absolute, default), `uri` (relative), `width`, `height`, `mimetype` and `filesize`. Because these are ordinary tokens they can be used anywhere tokens are supported (Metatag, Pathauto, mail bodies, Views token-aware fields, custom code via the token service). The old `paragraphs_summary_token.summary_builder` service is a deprecated alias of the text builder.

---

- Populate a node's Metatag meta description from the first text paragraph via `[node:field_paragraphs:summary]`.
- Generate an Open Graph / Twitter card description from paragraph content.
- Provide a teaser/summary string for content types that build their body entirely from paragraphs.
- Derive a representative social-share image from the first image in a paragraphs field with `[node:field_paragraphs:image]`.
- Output an image-style-specific URL for a card thumbnail: `[node:field_paragraphs:image:medium:url]`.
- Get image dimensions for a token-driven template: `[node:field_paragraphs:image:large:width]` / `:height`.
- Get the image MIME type or file size token for structured metadata.
- Use the summary token as a Pathauto pattern component.
- Feed a paragraphs-based summary into an outgoing email body token.
- Show a computed summary in a View using a token-aware field or rewrite result.
- Pull a summary out of deeply nested paragraphs (paragraph-in-paragraph) automatically.
- Pull a summary/image out of a Paragraphs Library item referenced from a paragraph.
- Get a language-correct summary on translated content (uses the current-language translation).
- Build a summary programmatically by calling `paragraphs_summary_token.text_summary_builder->build($field, $trim, $format)`.
- Retrieve the first paragraph image file/URL in custom code via `paragraphs_summary_token.image_builder->build($field, $style, $property)`.
- Provide a fallback description when editors do not fill a dedicated summary field.
- Standardise teaser text length (300 chars) across paragraph-built pages.
- Reuse an existing image style derivative for a token-driven `<img>` in a mail template.
- Feed a summary token to a schema.org / JSON-LD structured-data module.
- Avoid adding a redundant "summary" field to every paragraph-based content type.
