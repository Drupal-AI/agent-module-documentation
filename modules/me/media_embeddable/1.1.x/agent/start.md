<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media: Embeddable (media_embeddable) — agent index

A Media type whose **source is a block of embed/iframe HTML code**, so a third-party embed becomes
a reusable media entity instead of markup pasted into a body field. Core `^10 || ^11`; depends on
core `media`. Installed version **1.1.2** (docs track `1.1.x`).

## Mechanism (read the source, not the tagline)
- **Media source plugin** `media_embeddable` — `src/Plugin/media/Source/HTMLEmbed.php`
  (`@MediaSource id="media_embeddable"`, `allowed_field_types={"text_long"}`,
  `media_library_add` form = `EmbeddableForm`). `getMetadata()` returns the media UUID as the
  default name.
- **Media type + field** are installed as config: `media.type.media_embeddable`, storage/field
  `field_media_embeddable` (text_long). Standard add/edit form
  (`/media/add/media_embeddable`) uses a plain `text_textarea` widget.
- **Media Library add form** — `src/Form/EmbeddableForm.php` (extends
  `media_library\Form\AddFormBase`). `validateHtml()` parses input with `DOMDocument`/`DOMXPath`
  and applies `media_embeddable.settings` rules to `<script>` tags only.
- **Field formatter** `html_field_formatter` — `src/Plugin/Field/FieldFormatter/HTMLFieldFormatter.php`.
  Renders the stored field value via `Markup::create($item->value)` through
  `templates/media-embeddable.html.twig` (output as-is; no text-format filter). Optional
  "Responsive" setting attaches `media_embeddable/responsive` (CSS + `js/responsive.js`, which
  reads iframe width/height client-side to set an aspect-ratio wrapper, skipping Facebook iframes).
- **No server-side fetching.** There is no HTTP client, `file_get_contents`, or oEmbed resolver.
  Embedded scripts/iframes load in the visitor's browser.

## Config / admin
- Settings form `MediaEmbeddableSettings` at route `media_embeddable.settings`
  = `/admin/config/media_embeddable`, permission **`administer media embeddable`**
  (`restrict access: true`). Menu link under `system.admin_config_media`.
- `media_embeddable.settings` keys: `allow_tag_without_src` (default 0),
  `allow_tag_with_content` (default 0), `only_allowed_hosts` (default 1),
  `allowed_hosts` (default `instagram.com`, `twitter.com`, `x.com`). These constrain only
  `<script src>` in the Media Library add flow.
- No Drush commands. No config schema file ships. `hook_uninstall()` refuses to uninstall while
  any `media_embeddable` media entities still exist, then deletes `field_media_embeddable`.

## Operational note
The stored HTML is rendered verbatim and does **not** pass through a text format's filtering — so
granting create/edit on the `media_embeddable` bundle is equivalent to granting raw-HTML output.
Scope the core media create/update permissions for this bundle to editors you would trust with a
Full HTML text format, and put third-party embed scripts behind your consent manager (the
provider's script sees every visitor).

## Solution-type detail
- `media-sources/embeddable-source.md` — the media source + type, the two input paths, the
  script-tag settings, and the formatter/rendering behaviour.
