<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Atoms lets you define small, globally reusable content pieces — an atom is a named, typed value (text, number, checkbox, link, date/time, entity reference, formatted text) that editors fill in once and templates or code reuse everywhere.

Atoms are declared in code via `*.atoms.yml` files or the `hook_atoms_alter()` alter hook (not created ad-hoc through the UI); editors then edit their values on an admin overview under Content → Atoms. Each atom type is an `Atoms` annotation plugin (`Plugin/Atoms/*`) managed by `plugin.atoms.manager`, values are stored by `atoms.storage` in the database, and a `hook_modules_installed` rebuild picks up new definitions when modules are enabled. Rendering is done through a Twig extension exposing `atom()`, `atomString()` and `atomLazy()` functions, an `AtomsViewBuilder` service, and a Views area handler. Atoms are translatable via dedicated translate forms and permissions.

Typical setup: ship a `mymodule.atoms.yml` (or implement `hook_atoms_alter()`) declaring atoms, rebuild, then let editors fill values at `/admin/content/atoms` and reference them in Twig with `{{ atom('machine_name') }}`.

---

Short summary: named, typed, translatable global content snippets rendered via a Twig `atom()` function.

It solves the problem of scattering small pieces of site-wide content (a phone number, a promo blurb, a CTA link) across nodes, blocks and config: define them once as atoms and reuse them anywhere by machine name, with proper types and translation. It works via a plugin type for atom value-types, a database storage service, a builder that reconciles YAML/hook definitions, and a Twig extension for output.

Operationally: atoms are defined in code and only their *values* are editable in the UI; permissions are *administer atoms*, *configure atoms*, *edit atom*, *translate atom*, all on admin `/admin/content/atoms*` and `/admin/config/content/atoms/settings` routes. The optional **Atoms Media Library** submodule adds a media atom type. All routes are permission-gated; no anonymous or mutating endpoints.

---

- Define reusable content atoms in a `mymodule.atoms.yml` file.
- Define or alter atoms programmatically with `hook_atoms_alter()`.
- Edit atom values as an editor at `/admin/content/atoms`.
- Output an atom in a Twig template with `{{ atom('machine_name') }}`.
- Get an atom as a plain string with `atomString('machine_name')`.
- Lazy-render an atom with `atomLazy('machine_name')` for cacheable placeholders.
- Store a site-wide phone number / email as a text atom.
- Store a call-to-action link as a link atom.
- Use a checkbox atom as a global feature toggle in templates.
- Store a formatted (rich-text) blurb as a text-format atom.
- Reference an entity from an atom via the entity atom type.
- Use number and date/time atom types for typed values.
- Translate atom values per language via the translate form.
- Group atoms and edit them together on the overview form.
- Render an atom inside a view using the Atoms Views area handler.
- Add a media atom by enabling the Atoms Media Library submodule.
- Control who edits atoms with the *edit atom* permission.
- Grant translators the *translate atom* permission only.
- Configure module behaviour at `/admin/config/content/atoms/settings`.
- Rebuild atom definitions automatically when a module is installed.
- Extend the system with a custom atom type plugin (`Plugin/Atoms`).
- Fetch atom render arrays in PHP via the `atoms` view-builder service.
