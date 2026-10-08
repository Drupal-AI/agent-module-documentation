<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming: link + description templates

Two theme hooks are registered in `link_description_theme()`; override the templates in your
theme to change the markup.

## `link_with_description` (used by the `link_description` formatter)

Template `link-with-description.html.twig`. Variables:
- `link` — the already-built core `Drupal\Core\Link` render.
- `description` — the description (rendered with `nl2br`).

Default markup:
```twig
<div class="link-item">
  {{ link }}
  {% if description %}<p class="link-description">{{ description }}</p>{% endif %}
</div>
```

## `link_with_description_separate_text_url` (used by the `link_separate_description` formatter)

Template `link-with-description-separate-text-url.html.twig`. Variables:
- `link` — built in `template_preprocess_link_with_description_separate_text_url()` via
  `Link::fromTextAndUrl($url_title, $url)`.
- `title` — optional descriptive/alternate title.
- `url_title`, `url` — anchor text and `Url` object (inputs to the preprocess).
- `description` — the description (`nl2br`).

Default markup: a `.link-item` wrapper with `.link-title`, `.link-url`, and `.link-description`.

## Styling

Both templates expose `.link-item` and `.link-description` (and `.link-title` / `.link-url` for
the separate variant) as CSS hooks. To customise, copy the template into your theme's
`templates/` dir and edit; no preprocess override is needed for the compact variant.
