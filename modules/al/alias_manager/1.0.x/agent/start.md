<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alias Manager (alias_manager) — agent index

Adds a collapsible **"Alias manager"** section to an entity's edit form that lists every URL path
alias pointing at that entity (alias string + language, plus Edit/Delete links to core path routes).
Version **1.0.0**. Core `^10 || ^11`. Package: Other. No dependencies.

## What it provides

- **No entities/routes/services/config of its own.** Pure hook-driven UI over core's `path_alias`.
- **Hooks** (`alias_manager.module`):
  - `alias_manager_help()` — renders `README.md` on `help.page.alias_manager` (via Markdown filter
    if the `markdown` module is enabled, else `<pre>`).
  - `alias_manager_form_alter()` — the core behavior; adds the alias list to entity edit forms.
  - `alias_manager_get_entities_definitions()` — helper returning all entity type IDs that declare
    a `canonical` link template.
- **Permission** (`alias_manager.permissions.yml`): `administer alias_manager` (restrict access:
  true). The Edit/Delete row links additionally require core's `create url aliases`.

## Details

- [Alias list on entity forms](config/entity-form-list.md) — how the form_alter builds the table,
  which forms it targets, the two permissions involved, and the operation links.
