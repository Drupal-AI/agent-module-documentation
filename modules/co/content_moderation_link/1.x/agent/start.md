<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Moderation Link (content_moderation_link) — agent index

Moves a moderated entity into a new workflow state by visiting a crafted URL. Builds on core
**`content_moderation`** (declared dependency). Core requirement `^8 || ^9 || ^10 || ^11`.
License GPL-2.0-or-later. Version 1.1.0. Package *Other*.

- **The moderate route, its controller logic, the settings form/config, the token and hooks** →
  [api/moderate.md](api/moderate.md)

## What it actually is

- **One functional route** `content_moderation_link.moderate` at
  `/content-moderation-link/process/{state}/{type}/{id}` →
  `ContentModerationLinkController::moderate()` (`src/Controller/`). Loads the entity, requires an
  authenticated user, and only performs the transition if core's
  `content_moderation.state_transition_validation` service lists it among the user's valid
  transitions. Then `$entity->set('moderation_state', $state)->save()`.
- **One admin route** `content_moderation_link.settings_form` at
  `/admin/config/content/content-moderation-link` → `Form\SettingsForm` (a `ConfigFormBase`),
  writing config object **`content_moderation_link.settings`**. Menu link under
  *Configuration → Workflow* (`content_moderation_link.links.menu.yml`).
- **A token** `[node:moderation-link:<state>]` (`content_moderation_link.tokens.inc`) that builds
  the absolute moderate URL for a node.
- **Two alter hooks** `hook_content_moderation_link_alter_entity()` and
  `hook_content_moderation_link_alter_account()` (`content_moderation_link.api.php`), invoked just
  before save.
- **No entities, no plugins, no services, no Drush, no own `*.permissions.yml`.** Provides a
  config object + schema only.

## Config keys (`content_moderation_link.settings`)

`allow_multiple` (int, default 0 — process comma-separated IDs), `skip_errors` (int, default 1 —
skip un-loadable IDs vs. halt), `destination` (string route name, default `''` → `<front>`),
`entity_types` (sequence — allowlist; empty permits any type), `moderation_states` (sequence of
`{workflow}-{state}`, e.g. `editorial-published`; empty permits any state). See
[api/moderate.md](api/moderate.md).

## Notes

- The settings route requires permission `administer content_moderation_link configuration`, but the
  project ships **no `*.permissions.yml`** defining it — an undefined permission is denied to
  everyone except user 1 (fails closed). Details in [api/moderate.md](api/moderate.md).
