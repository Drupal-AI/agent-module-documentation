# Material Icons — settings, widget config, permissions

## Global settings — which font families load

| Item | Value |
|---|---|
| Config object | `material_icons.settings` |
| Key | `families` (sequence of strings) |
| Shipped default | `['baseline']` |
| Form route | `material_icons.settings` → `/admin/config/content/material_icons` |
| Permission | `administer material icons` |

Each string in `families` is attached site-wide (via `hook_page_attachments()`) as an
external Google Fonts stylesheet library of the same name (see `material_icons.libraries.yml`).
Only enabled families load, keeping page weight down.

Available family keys (from the `MaterialIconsSettings` trait / libraries):

- Material Icons set: `baseline` (Filled), `outlined`, `round`, `sharp`, `two-tone`.
- Material Symbols set: `symbols__outlined`, `symbols__rounded`, `symbols__sharp`.

```bash
drush config:get material_icons.settings families
# enable outlined + sharp in addition to baseline:
drush config:set material_icons.settings families.1 outlined -y
drush config:set material_icons.settings families.2 sharp -y
```

Or set the whole list with `drush php:eval`:

```php
\Drupal::configFactory()->getEditable('material_icons.settings')
  ->set('families', ['baseline', 'outlined', 'sharp'])->save();
```

## Per-widget settings

The `material_icons` field widget (`field.widget.settings.material_icons`) has three settings:

| Setting | Type | Default | Effect |
|---|---|---|---|
| `allow_style` | bool | `true` | Whether editors can pick the icon style (family) dropdown. |
| `default_style` | string | `''` | Pre-selected style for new values. |
| `allow_classes` | bool | `true` | Whether the extra-CSS-classes textfield is shown. |

Stored on the form-display component, e.g.
`core.entity_form_display.node.article.default` →
`content.<field>.settings.{allow_style,default_style,allow_classes}`.

## Permissions

| Permission | Gates |
|---|---|
| `administer material icons` | the settings form (`/admin/config/content/material_icons`). |
| `use material icons` | the icon-picker dialog (`material_icons.dialog`) and the autocomplete endpoint (`material_icons.autocomplete`). |
