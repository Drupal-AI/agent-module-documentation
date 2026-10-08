<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Automatic Configuration Form (auto_config_form) — agent index

A developer helper: one **abstract base class** that generates a Drupal settings form from a
config object's **typed-config schema**. You extend it in your own module and implement a single
method. Core requirement `^11` (Drupal 10 → use the module's 1.x branch). License
GPL-2.0-or-later. Version 2.0.0. No composer requirements, no Drupal module dependencies.

- **How to build a form from your schema — the base class, its methods, constraints, override
  messages, and how you wire the route/access yourself** → [api/base-class.md](api/base-class.md)

## What it actually is

- One class: `Drupal\auto_config_form\AutoConfigFormBase` (`src/AutoConfigFormBase.php`),
  `abstract`, extending core `ConfigFormBase`. You subclass it in your module.
- **No routes, no `*.permissions.yml`, no `*.services.yml`, no `config/`, no config schema of its
  own, no Drush, no plugins.** The only hook is `hook_help()` in `auto_config_form.module`.
- The single required override is `getSchemaKey(): string` — returns the name of a `config_object`
  schema (e.g. `my_module.settings`) that the form edits.

## Mechanism (from source)

- `getEditableConfigNames()` returns exactly `[$this->getSchemaKey()]` — the editable config is the
  subclass's hard-coded schema key, **not** anything request- or user-supplied.
- `create()` injects the `config.typed` service (`TypedConfigManagerInterface`).
- `buildForm()` reads `typedConfigManager->getDefinition(getSchemaKey())` and iterates its
  `mapping` (skipping `langcode`/`_core`), calling `createFormElementFromConfigSchemaDefinition()`
  which `match`es the schema `type`: `string`→textfield, `boolean`→checkbox,
  `integer`/`float`→number, `mapping`→recursive fieldset, anything else→a read-only
  "not yet implemented" placeholder.
- Each editable element gets `#config_target => "<schema_key>:<dotted.key.path>"`, so core's
  `ConfigFormBase` handles save; the subclass needs no `submitForm()`.
- Schema `constraints` map to widget props: `Length`→`#maxlength`, `NotBlank`/`NotNull`→`#required`,
  `Range`→`#min`/`#max`.
- Values overridden in `settings.php` are detected (immutable vs. editable config compare) and
  shown inline via `getOverriddenMessage()`.

## What you supply

- The `config_object` **schema file** in your module (`config/schema/*.schema.yml`) — labels/titles
  and descriptions there become the form's field labels and help text.
- A **route** to the form and its **access** (`_permission`, typically
  `administer site configuration`) and, optionally, a menu link. This module provides none of that.
