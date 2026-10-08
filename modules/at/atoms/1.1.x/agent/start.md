<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Atoms (atoms) — agent index

**Small, typed, translatable, globally reusable content pieces defined in code and rendered in templates via a Twig `atom()` function.**

- **Version:** 1.1.x · **Core:** ^10 || ^11 · **Configure:** `atoms.settings`
- **Permissions:** *administer atoms*, *configure atoms*, *edit atom*, *translate atom*.
- **Routes** (all permission-gated): `/admin/content/atoms` (overview), `/admin/content/atoms/edit/{group_id}`, `.../edit/{group_id}/{langcode}` (translate), `/admin/config/content/atoms/settings`.
- **Services:** `atoms` (`AtomsViewBuilder`), `plugin.atoms.manager` (`AtomsManager`), `atoms.storage` (DB), `atoms.builder` (reconciles YAML/hook defs), `atoms.twig.extension`.
- **Twig:** `atom()`, `atomString()`, `atomLazy()`. **Plugin type:** `Atoms` annotation (`Plugin/Atoms/*` — Text, TextFormat, Number, Checkbox, DateTime, Link, Entity). **Alter hook:** `hook_atoms_alter()`. **Views:** area plugin.
- **Definitions** come from `*.atoms.yml` / `hook_atoms_alter()`; UI edits values only. Rebuild on `hook_modules_installed`.
- **Submodule:** `atoms_media_library` (media atom type).
- **Security:** every route is permission-gated; no anonymous or mutating endpoints; no outbound HTTP.

See [api/atoms.md](api/atoms.md)
