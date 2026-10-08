<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Language Access (entity_language_access) — agent index

Adds one **route access check** (`_entity_language_access`) to the **canonical route** of every
translatable content entity type and returns **403** when the current content language is neither the
entity's original language nor an available translation. Package `Multilingual`. Depends only on core
**`language`**. Core `^10.2 || ^11`. License GPL-2.0-or-later. Version 1.0.0. No Drush, no plugins, no
fields.

## What it actually is (from source)

- **Access check** `EntityLanguageAccess` (`src/Access/EntityLanguageAccess.php`), service
  `entity_language_access.language_access`, tagged `access_check` with `applies_to: _entity_language_access`.
- **RouteSubscriber** (`src/Routing/RouteSubscriber.php`) sets the requirement
  `_entity_language_access: 'true'` on `entity.<type>.canonical` for each content entity type that is
  translatable and has a `canonical` link template.
- **FallbackContent** event subscriber (`src/EventSubscriber/FallbackContent.php`) optionally replaces
  the 403 with a configured fallback node.
- **AdminSettingsForm** (`src/Form/AdminSettingsForm.php`) at `/admin/config/regional/entity_language_access`.
- Two **permissions**, one **config object** `entity_language_access.settings`. `.module` / `.install`
  are empty stubs (`skip_procedural_hook_scan: true`).

## Solution docs

- **The access check — how the language rule is evaluated, coverage, bypass, cache** →
  [access/language-access.md](access/language-access.md)
- **Settings form, config object/schema, fallback content, permissions, routes** →
  [config/settings.md](config/settings.md)

## Scope caveats (documented behaviour)

- Guards the **canonical view only** — edit/delete/other routes are not affected.
- Does **not** filter listings (Views, EntityQuery, JSON:API collections); add a language filter there.
- Only works for canonical routes named `entity.<type>.canonical` (Drupal best-practice naming).
