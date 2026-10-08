<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Buttons & wiring into a text format

An **Embedded content button** is a config entity (`embedded_content_button`, config name
`embedded_content.button.<id>`, config_prefix `button`) that becomes a CKEditor 5 toolbar item. The
module ships one button, `default`.

## Button config entity

`config_export`: `id`, `label`, `settings`. Settings (schema `embedded_content.button.*`):

| Setting key | Meaning |
|---|---|
| `label_singular` | Singular name of the thing being embedded (shown in the button/modal). |
| `submit_button_text` | Text of the dialog's submit button. |
| `modal_title` | Title of the insert modal. |
| `icon` | Raw SVG markup used as the toolbar button icon. |
| `conditions` (a.k.a. `condition`) | Newline-separated glob/regex patterns of plugin ids this button may insert; empty = all plugins. Matched by `EmbeddedContentButton::meetsCondition()`. |
| `dialog_settings.width` | Dialog width (default `800px`). |
| `dialog_settings.height` | Dialog height (default `auto`). |
| `dialog_settings.type` | Dialog type. |

Admin UI routes (`embedded_content.routing.yml`): collection
`/admin/config/content/embedded-content/button`, add
`/admin/config/content/embedded-content/button/add`, edit `…/{embedded_content_button}`.

### Create one in code

```php
use Drupal\embedded_content\Entity\EmbeddedContentButton;
EmbeddedContentButton::create([
  'id' => 'components',
  'label' => 'Components',
  'settings' => [
    'label_singular' => 'component',
    'modal_title' => 'Insert a component',
    'submit_button_text' => 'Insert',
    'icon' => '<svg …></svg>',
    'condition' => '',                 // or e.g. "callout\ncard*" to restrict plugins
    'dialog_settings' => ['width' => '800px', 'height' => 'auto'],
  ],
])->save();
```

Each saved button is turned into a **CKEditor 5 plugin derivative** (via `EmbeddedContentDeriver`),
producing a toolbar item id **`embeddedContent__<button_id>`**.

## Wire it into a text format (the required round trip)

A button only works in a text format where **both** the toolbar item and the filter are on:

1. Edit a text format/editor (`/admin/config/content/formats/manage/<format>`) using **CKEditor 5**.
2. Drag the button's toolbar item (**`embeddedContent__<button_id>`**, labelled with the button's
   label) into the active toolbar.
3. Enable the **Embedded content** filter (`embedded_content`) under *Enabled filters*.

In config terms, the `filter_format`'s `filters.embedded_content.status` must be `true` and the
editor's `settings.toolbar.items` must include `embeddedContent__<button_id>`. The CKEditor plugin
declares the allowed elements (`<embedded-content …>` / `<embedded-content-inline …>` with
`data-plugin-id`, `data-plugin-config`, `data-button-id`), so you do **not** need to loosen the
format's allowed-HTML for editors.

See [../api/filter.md](../api/filter.md) for what the filter does on output, and
[../permissions/permissions.md](../permissions/permissions.md) for who may use a button.
