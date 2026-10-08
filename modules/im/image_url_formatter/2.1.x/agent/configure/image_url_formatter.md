# Configure the Image URL Formatter

This module has **no admin settings form** and no config route (`configure` is null).
Everything is set per-field on the entity's **Manage display** page, or in a View's field
settings. It provides two field formatters:

| Formatter id | Field types | Base class | Label |
|---|---|---|---|
| `image_url_formatter` | `image` | `ImageFormatterBase` (core image) | Image URL Formatter |
| `file_url_formatter` | `file` | `UrlPlainFormatter` (core file) | File URL Formatter |

## Apply it (UI)

1. Go to **Structure → Content types → [type] → Manage display** (or Media type, or any
   entity display), or add the image field to a **View**.
2. For the image field, change the **Format** to **Image URL Formatter** (for a plain file
   field, choose **File URL Formatter**).
3. Click the gear to open the settings, set the options below, and **Save**.

The rendered output becomes the image's URL as plain text (via the `image_url_formatter`
theme hook / `image-url-formatter.html.twig`) instead of an `<img>` tag.

## Settings (formatter settings, stored on the display config)

Config schema: `config/schema/image_url_formatter.schema.yml`
(`field.formatter.settings.image_url_formatter`). Default values are all empty strings.

| Setting | Values | Meaning |
|---|---|---|
| `url_type` | `0` Full URL / `1` Absolute file path / `2` Relative file path | `0` = full URL with scheme + host; `1` = root-relative path (leading `/`), `$base_url` stripped; `2` = relative path with `$base_url . '/'` stripped (no leading slash). Empty/`0` behaves as full URL. |
| `image_style` | image style machine name, or empty | Run the URL through an image-style preset (its derivative URL). Empty = **None (original image)**. Only on `image_url_formatter`. |
| `image_link` | `content` / `file` / empty | Wrap the printed URL in a link to the host **Content** entity, to the **File**, or **Nothing** (empty). |

## How the URL is built (facts from source)

- `viewElements()` loads the referenced files via `getEntitiesToView()`; empty fields render
  nothing.
- The base URL comes from the `file_url_generator` service; with an `image_style` set, the
  style's `buildUrl()` is used and the style's cache tags are merged into the element.
- `url_type` `1`/`2` are produced in `template_preprocess_image_url_formatter()` by
  `str_replace`-ing `$GLOBALS['base_url']` (type 1) or `$base_url . '/'` (type 2) out of the
  full URL.
- With `image_link` = `content` the entity's canonical URL is used; with `file` the file's
  own URL is used; the template then prints that URL (or wraps it in a `Link`).

## Consume the output

- **Twig template:** render the field, e.g. `{{ content.field_image }}` or
  `{{ content.field_image.0 }}`, to emit the raw URL string — usable inside `style=""`,
  `data-*` attributes, or `<img src="…">` you build yourself.
- **Meta tags / `og:image`:** point a meta-tag token or template at the field value to output
  the image URL.
- **Views (JSON / data feed):** add the image field, choose the **Image URL** format and a
  URL type; the field column becomes the plain URL for API/data consumers.
- The README notes "Global: Custom Text" in Views may not pick up the value; prefer the
  Twig template or a template override for formatting.
