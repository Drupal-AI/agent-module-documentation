# image_url_formatter — agent start

Adds field formatters that render an image (or file) field as just its URL in plain text,
optionally through an image style, instead of an `<img>` tag. Useful for `og:image` meta
tags, data attributes, Twig templates, and JSON/data Views. Depends only on core `image`.
No admin settings form, no permissions, no drush commands (`configure` is null); the
formatter is configured per-field on **Manage display**.

- Apply the formatter, pick image style + URL type (full/absolute/relative), link options,
  and consume the URL output → [configure/image_url_formatter.md](configure/image_url_formatter.md)
