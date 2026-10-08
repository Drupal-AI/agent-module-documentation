<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Embeddable" media source and type

## Source plugin
`src/Plugin/media/Source/HTMLEmbed.php`

```
@MediaSource(
  id = "media_embeddable",
  label = "Embeddable",
  allowed_field_types = {"text_long"},
  default_thumbnail_filename = "media-embeddable.png",
  forms = { "media_library_add" = "\Drupal\media_embeddable\Form\EmbeddableForm" }
)
```

`HTMLEmbed extends MediaSourceBase`. `getMetadataAttributes()` returns `[]`;
`getMetadata()` returns the media's UUID for `default_name` (so a new embeddable media's default
name is its UUID). There is no metadata extraction, no remote lookup.

## The media type and field (installed config)
- `config/install/media.type.media_embeddable.yml` → media type `media_embeddable`
  ("Embeddable"), `source: media_embeddable`, `source_configuration.source_field:
  field_media_embeddable`.
- `field.storage.media.field_media_embeddable` / `field.field.media.media_embeddable.…` →
  a `text_long` field holding the raw embed code.
- Form displays: `default` uses the `text_textarea` widget (5 rows); `media_library` uses the
  source's `media_library_add` form.
- View displays render `field_media_embeddable` with the `html_field_formatter`.

## Two input paths (important asymmetry)
1. **Standard media form** `/media/add/media_embeddable` and `/media/{id}/edit` — plain
   `text_textarea`; whatever HTML is typed is stored directly.
2. **Media Library "Add"** — `EmbeddableForm::buildInputElement()` shows a single `html` textarea;
   the "Add" button runs `EmbeddableForm::validateHtml()` before `processInputValues()`.

`validateHtml()` loads the HTML into `DOMDocument`, then for every `//script` node checks:
- `allow_tag_without_src` — reject `<script>` with no `src` unless enabled.
- `allow_tag_with_content` — reject `<script>` whose body is non-empty unless enabled.
- `only_allowed_hosts` + `allowed_hosts` — when on, each `script src` must match
  `/(https?:)?\/\/(\w+\.)?$host/` for some allowed host, else an error.

These checks target `<script>` tags only.

## Rendering
`src/Plugin/Field/FieldFormatter/HTMLFieldFormatter.php` (`html_field_formatter`,
`field_types={"text_long"}`):

```php
$elements[$delta] = ['#markup' => Markup::create($item->value)];
$render = ['#theme' => 'media_embeddable', 'elements' => $elements];
if ($this->getSetting('responsive')) {
  $render['#attached']['library'][] = 'media_embeddable/responsive';
}
```

The stored value is wrapped in `Markup::create()` (marked safe) and themed by
`templates/media-embeddable.html.twig` (`<div class="media-embeddable">{{ content }}</div>`), so
the embed markup is emitted verbatim — it is not run through a text-format filter. The optional
`responsive` setting (default TRUE) attaches CSS + `js/responsive.js`, which, client-side, reads
each `.media-embeddable > iframe` width/height and sets a `padding-bottom` aspect ratio on the
wrapper (Facebook iframes are skipped).

## Admin settings
`MediaEmbeddableSettings` (`ConfigFormBase`) at `/admin/config/media_embeddable`, permission
`administer media embeddable` (`restrict access: true`), edits `media_embeddable.settings`
(`allow_tag_without_src`, `allow_tag_with_content`, `only_allowed_hosts`, `allowed_hosts`).
`allowed_hosts` is a newline textarea, split/trimmed into an array on save.

## Notes for agents
- Nothing is fetched server-side; do not describe this as an oEmbed/URL-resolving source.
- The stored HTML renders as-is. Treat create/edit rights on this bundle like granting raw HTML
  output, and gate third-party embed scripts behind consent management.
