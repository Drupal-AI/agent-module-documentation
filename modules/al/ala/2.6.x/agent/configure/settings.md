# Configure Advanced Link Attributes — global settings

**Route:** `ala.admin_settings` → `/admin/config/ala` (menu link under Configuration → Content authoring).
**Permission:** `administer site configuration` (core). **Form:** `Drupal\ala\Form\ModuleConfigurationForm`.
**Config object:** `ala.settings`.

## Fields

- **Define possibles classes** (`ala_default_classes`, textarea) — the site-wide "Global List" of
  allowed link classes. One entry per line as `key|label`:
  ```
  btn btn-default|Default button
  btn btn-primary|Primary button
  ```
  The `key` is the class string put on the link (space-separate multiple classes); the `label` is shown
  in edit forms (optional — a bare line is used as both key and label). Widgets set to class mode
  "Global List" read this via `getSelectOptions()`.

- **Extra attributes** (`ala_extra_attributes`, textarea) — comma-separated attribute **names**
  (e.g. `title,data-test`) that the widget will expose as editable textfields when a widget instance
  has "Enable extra attributes" turned on.

Default install value: `ala_default_classes: ''` (see `config/install/ala.settings.yml`).

## Where per-field settings live (not here)

The class list *mode* (Disabled / Global / Custom), the custom class list, and the icon/color/roles/
target/extra toggles are **widget** settings stored on the entity form display, not in `ala.settings`.
Formatter options (class position, icon position, role visibility, plus inherited trim/rel/target) are
stored on the entity view display. See [plugins/field.md](plugins/field.md).

## Scripting

```php
\Drupal::configFactory()->getEditable('ala.settings')
  ->set('ala_default_classes', "btn btn-primary|Primary\nbtn btn-secondary|Secondary")
  ->set('ala_extra_attributes', 'title,data-track')
  ->save();
```
