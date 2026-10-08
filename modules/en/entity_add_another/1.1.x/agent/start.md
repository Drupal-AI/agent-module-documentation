<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Add Another (entity_add_another) — agent index

Adds a **"Save and Add Another" button** to content-entity add forms: after saving, the editor is returned to
a fresh add form to speed up bulk creation. Package `Other`. No module dependencies. Core
`^10.1 || ^11 || ^12`. License GPL-2.0-or-later. Version 1.1.0. Provides two permissions and a config object;
no entities, plugins, services API, or Drush.

- **How it hooks the form, the redirect, config object + settings form, and permissions** →
  [config/settings.md](config/settings.md)

## What it actually is
- OOP hook class `Drupal\entity_add_another\Hook\EntityAddAnotherHooks` (`#[Hook]` attributes; thin
  `#[LegacyHook]` wrappers in `entity_add_another.module`), registered in `entity_add_another.services.yml`.
- `formAlter()` (ordered after `inline_entity_form`) clones the form's existing `actions.submit` into
  `actions.entity_add_another`, relabels it *"Save and Add Another"*, and appends a submit handler — only when
  the user has `use entity add another`, the form is a `ContentEntityFormInterface` on a **new**
  `ContentEntityInterface` (op add/edit/default), and the `<entity_type>` or `<entity_type>__<bundle>` key is
  enabled in config `entity_add_another.add_another_entities`.
- `submitEntityAddAnother()` strips the `destination` query param and redirects back to the current **internal**
  path (`path.current`) via `Url::fromUserInput()` — i.e. the same add form. The button reuses the entity form's
  own save path, so creation is still governed by normal entity create access.

## Config & permissions
- Config object `entity_add_another.add_another_entities` → `add_another_entities` (sequence of strings;
  default `[]` — button appears nowhere until enabled). Schema in `config/schema/entity_add_another.schema.yml`.
- Settings form `EntityAddAnotherSettingsForm` (`ConfigFormBase`) at route `entity_add_another.settings`,
  `/admin/config/content/entity_add_another` — checkboxes of all content entity types + bundles.
- Permissions: `administer entity add another` (settings route), `use entity add another` (see/use the button).

See `../../1.0.x/` for the previous branch. Branch 1.1.x moves the hooks onto the attribute-based OOP hook
system, drops Drupal 9, and adds Drupal 12 (core now `^10.1 || ^11 || ^12`).
