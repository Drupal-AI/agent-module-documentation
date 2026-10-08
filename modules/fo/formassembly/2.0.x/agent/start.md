<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FormAssembly (formassembly) — agent index

Integrates the FormAssembly SaaS form platform. Each remote form is mirrored as a `fa_form`
**content entity**; the module OAuth-authorizes the site, syncs the form list from the FormAssembly
REST API, then fetches a form's HTML on demand and renders it inline (parsed with
`symfony/dom-crawler`, not iframed) either on the entity's own path or via an entity-reference field.

- Hard dep: `drupal:map_widget`. Composer also pulls `fathershawn/oauth2-formassembly`,
  `symfony/dom-crawler`, `symfony/css-selector` (+ `ext-libxml`, `ext-json`). Optional: `key`,
  `token`, `scrivo/highlight.php`, `gajus/dindent`. Core `^10 || ^11`.
- Settings/configure route: **`fa_form.settings`** → `/admin/structure/fa_form/settings`.
- Defines 5 permissions, a Drush command, config schema; defines **no** plugin type (it does ship a
  Key module KeyType plugin `formassembly_oauth`).

Solution docs:
- **Configure the API, credentials and OAuth authorization** → [configure/settings.md](configure/settings.md)
- **Permissions & entity access** → [permissions/permissions.md](permissions/permissions.md)
- **Sync forms from the CLI** → [drush/commands.md](drush/commands.md)
- **Services & public API (sync / markup / authorize / key / batch)** → [api/services.md](api/services.md)
- **Hook the module invokes for you + hooks it implements** → [hooks/hooks.md](hooks/hooks.md)
- **The `fa_form` entity, its fields, routes and how a form is embedded** → [fields/fa_form-entity.md](fields/fa_form-entity.md)

Key facts:
- Config object: **`formassembly.api.oauth`** — keys `endpoint` (uri), `admin_index` (bool),
  `credentials.provider` (`formassembly`|`key`), `credentials.data.{cid,secret}` or
  `credentials.data.id` (Key id).
- Access token is stored in **State** `fa_form.access_token` (a League `AccessToken`), never config.
- Services: `formassembly.sync`, `formassembly.markup`, `formassembly.authorize`, `formassembly.key`,
  `formassembly.batch`; logger channel `formassembly`; cache bin `fasync`.
- Entity: `fa_form` (base table `fa_form`), canonical `/formassembly/fa_form/{fa_form}`, collection
  `/formassembly/fa_form`, view mode `fa_form.markup`.
- Permissions: `administer formassembly form entities` (restrict access), `edit formassembly form
  entities`, `access formassembly form overview`, `view formassembly form entities`,
  `reference formassembly`.
- Drush: `formassembly:sync` (alias `fas`).
- Integrator hook: `hook_formassembly_form_params_alter(&$params)`.
