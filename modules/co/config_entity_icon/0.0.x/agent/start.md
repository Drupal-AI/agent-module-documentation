<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Entity Icon (config_entity_icon) — agent index

Adds an **icon picker to config-entity edit forms** and stores the chosen icon on the entity as a
**third-party setting** (`config_entity_icon.icon_id`). One generic mechanism for every config
entity type — content types, taxonomy vocabularies, menus, media types, custom config entities —
replacing per-entity-type icon modules. Built on core's **Icon API** via the contributed
**UI Icons** (`ui_icons`) module; any installed icon pack (Lucide, Bootstrap Icons, Font Awesome,
custom SVG packs) works. Package `Administration`. Core `^11.1`. PHP `>=8.3`. License
GPL-2.0-or-later. `lifecycle: experimental`. Installed **0.0.1** (version dir `0.0.x`).

info.yml name: **Config Entity Icon**.

## Dependencies

- `drupal:system` and `ui_icons:ui_icons` (`.info.yml`). Composer also requires
  `drupal/ui_icons:^1.1` and `drupal/core:^11.1`. Needs **at least one installed icon pack** to have
  anything to pick. No external PHP libraries.

## What it provides (from source)

- **Settings form** `Form\SettingsForm` at `/admin/config/user-interface/config-entity-icon`
  (`.routing.yml`, `.links.menu.yml`), gated by permission **`administer config_entity_icon`**
  (`.permissions.yml`, `restrict access: true`). Lists every config entity type that has an
  `edit-form` link template, minus a hard-coded `SKIP_LIST` of technical types (`action`,
  `base_field_override`, `date_format`, `editor`, `entity_form_display`/`_mode`,
  `entity_view_display`/`_mode`, `field_config`, `field_storage_config`, `filter_format`,
  `image_style`, `responsive_image_style`, `search_page`, `shortcut_set`, `tour`, `rdf_mapping`).
  `paragraphs_type` is shown **disabled** (`EXTERNALLY_MANAGED` — "managed by the Paragraphs
  module"). Ticked types are saved to `config_entity_icon.settings:enabled_entity_types`
  (a `sequence` of strings; config schema in `config/schema`, default `{}` in `config/install`).
- **Form alter** `Hook\FormAlterHooks` (OOP `#[Hook('form_alter')]`, registered as a
  `drupal.hook`-tagged service in `.services.yml`; `skip_procedural_hook_scan: true`, no `.module`
  file). Fast-exits unless the form is an `EntityFormInterface`, its entity is a
  `ConfigEntityInterface`, and the entity type is in `enabled_entity_types`. Then injects a
  `details` element `config_entity_icon` containing a `#type => 'icon_autocomplete'` field
  `config_entity_icon_id` (default = current TPS value, `#required => FALSE`,
  `#allowed_icon_pack => []` = all packs). Placement: joins the **`additional_settings`** vertical
  tab (`#group`, collapsed) when the form has one, else `#weight => 50`. Registers an entity builder.
- **Entity builder** `FormAlterHooks::buildEntity` — on save, `extractIconId()` normalizes the
  submitted value (handles `IconDefinitionInterface`, arrays with `target_id`/`icon`/`icon_id`, or a
  plain string) to a `"pack_id:icon_name"` string, then `setThirdPartySetting('config_entity_icon',
  'icon_id', …)` — or `unsetThirdPartySetting` when empty. Schema wildcard
  `*.*.third_party.config_entity_icon` (`config/schema`) covers any entity storing it.
- **Resolver service** `config_entity_icon.resolver` = `ConfigEntityIconResolver`
  (arg `@plugin.manager.icon_pack`):
  - `getIconId(ConfigEntityInterface): ?string` — the stored `"pack:name"` string, or NULL.
  - `renderIcon(ConfigEntityInterface, array $settings = []): array` — a `#type => 'icon'` render
    array (`#icon_pack`, `#icon_id`, plus merged `$settings` e.g. `#size`), or `[]` when unset or the
    id has no `:`.
- No update/install hooks, no Drush commands, no templates/CSS/JS, no plugin types.

## Reading the icon from PHP

```php
$resolver = \Drupal::service('config_entity_icon.resolver');
$id = $resolver->getIconId($entity);                    // "lucide:home" or NULL
$build['icon'] = $resolver->renderIcon($entity, ['#size' => 24]);
// Or directly:
$id = $entity->getThirdPartySetting('config_entity_icon', 'icon_id');
```

## More

- Human setup guide: [../human-docs/index.md](../human-docs/index.md) (installation, configuration).
- One-line summary + capabilities list: [../usage.md](../usage.md).

Single-file module surface — no subdocs warranted.
