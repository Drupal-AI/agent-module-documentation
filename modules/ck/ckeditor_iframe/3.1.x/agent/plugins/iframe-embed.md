<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Iframe Embed CKEditor 5 plugin

The module does **not define a new Drupal plugin type**; it provides one CKEditor 5 plugin
(consuming core's `ckeditor5` plugin type). Definition lives in
`ckeditor_iframe.ckeditor5.yml`, PHP class in
`src/Plugin/CKEditor5Plugin/Iframe.php`, JS under
`js/ckeditor5_plugins/iframeembed/` (built to `js/build/iframeembed.js`).

## Identity

| Thing | Value |
|---|---|
| CKEditor 5 plugin id (Drupal) | `ckeditor_iframe_embed_iframeembed` |
| CKEditor 5 JS plugin used | `iframeembed.IframeEmbed` |
| Toolbar item | **`iframeEmbed`** (label "Iframe Embed") |
| Drupal label | `Iframe embed` |
| PHP class | `Drupal\ckeditor_iframe\Plugin\CKEditor5Plugin\Iframe` |
| Library | `ckeditor_iframe/iframeembed` (+ `admin.iframeembed` CSS) |
| Provided elements | `<iframe>` and `<iframe>` with the enabled attributes |
| Settings key | `settings.plugins.ckeditor_iframe_embed_iframeembed` on `editor.editor.<format>` |
| Setting | `enabled_optional_attributes` (sequence of attribute names) |

## Static definition (`ckeditor_iframe.ckeditor5.yml`)

- `toolbar_items: { iframeEmbed: { label: "Iframe Embed" } }` — the single button.
- `elements:` statically advertises `<iframe>` and the full attribute superset
  `<iframe align frameborder height width longdesc name scrolling src tabindex title
  allowfullscreen>`; the PHP class narrows this per format at runtime.

## PHP class behaviour (`Iframe.php`)

Extends `CKEditor5PluginDefault`, uses `CKEditor5PluginConfigurableTrait`, implements
`CKEditor5PluginElementsSubsetInterface`.

- **`getOptionalAttributes()`** (private) — the ten configurable attributes:
  `align`, `frameborder`, `height`, `width`, `longdesc`, `name`, `scrolling`, `tabindex`,
  `title`, `allowfullscreen`.
- **`getDeprecatedOptionalAttributes()`** — `align`, `frameborder`, `longdesc`, `scrolling`
  (rendered with a "(deprecated)" label in the form).
- **`defaultConfiguration()`** — enables all optional attributes *except* the deprecated
  ones, i.e. `height`, `width`, `name`, `tabindex`, `title`, `allowfullscreen`.
- **`buildConfigurationForm()`** — a `checkboxes` element titled *Allowed optional
  attributes*, one box per optional attribute.
- **`getElementsSubset()`** — returns `['<iframe>', '<iframe src …enabled attrs…>']`.
  `src` is always required; the enabled optional attributes are appended. This subset is
  what the allowed-HTML (`filter_html`) filter uses, so ticking a box also permits that
  attribute through the filter — no manual allowed-tags editing needed.
- **`getDynamicPluginConfig()`** — passes `iframe.enabled_optional_attributes` to the JS
  plugin so the insert form/upcast honour the same attribute list.

## Config schema

`config/schema/ckeditor_iframe.schema.yml` defines
`ckeditor5.plugin.ckeditor_iframe_embed_iframeembed` — a mapping whose single key
`enabled_optional_attributes` is a `sequence` of strings.

## Legacy CKEditor 4 plugin

`src/Plugin/CKEditorPlugin/IFrame.php` is the old CKEditor 4 plugin, kept so a site can run
CKE4 and CKE5 side by side during migration. `ckeditor_iframe_requirements()` (in
`.install`) warns if the CKE4 `/libraries/iframe/plugin.js` is absent. On Drupal 11 the CKE5
plugin above is the active one; there are no services, hooks-for-others, Drush commands, or
permissions.
