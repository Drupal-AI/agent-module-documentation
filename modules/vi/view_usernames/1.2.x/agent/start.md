<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# View Usernames (view_usernames) — agent index

Turns username visibility into a permission instead of an implicit right. Core Drupal exposes every
username (author fields, comment bylines, `getDisplayName()`, `#theme => 'username'`, JSON:API user
resources). This module hardens all those paths: a username is shown to another user only when a
chain of pluggable "deciders" allows it. Depends only on core `user`. No settings form
(`configure` null), no config schema, no Drush. PHP >= 8.1.6; core `^10.5.8 || ^11.2.8`.

- **The `view usernames` permission** → [permissions/view-usernames.md](permissions/view-usernames.md)
- **Extending who may see whose username (the decider API)** → [api/deciders.md](api/deciders.md)
- **The enforcement hooks + the correct `view label` access pattern + JSON:API/mail behavior** →
  [hooks/enforcement.md](hooks/enforcement.md)
- **Leak-proof user entity-reference autocomplete (selection handler)** →
  [fields/user-selection.md](fields/user-selection.md)

Key facts:
- Permission string: **`view usernames`** (`view_usernames.permissions.yml`).
- Default policy — `DefaultViewUsernameAccessDecider` (service
  `view_usernames.view_username_access_decider.default`, priority **1024**): username visible if the
  account is **anonymous**, the viewer **is** that account, or the viewer holds **`administer users`**
  or **`view usernames`**; otherwise **forbidden**.
- Extension point — tag a service with **`view_username_access_decider`** (optional `priority`)
  implementing `Drupal\view_usernames\Contracts\ViewUsernameAccessDeciderInterface::canViewUserName(AccountInterface $acting_user, UserInterface $other_user): AccessResultAllowed|AccessResultForbidden`.
  The collector service `view_usernames.view_username_access_decider`
  (`ViewUsernameAccessDeciderCollector`, a `service_id_collector`, `required: true`) runs them in
  priority order; first allow wins.
- Enforcement (all in `view_usernames.module`, most delegating to `EntityHooks`):
  `hook_entity_access` (`view label` op) → `EntityHooks::userEntityAccess()`;
  `hook_entity_field_access` (`view` op on the user `name` field) → `EntityHooks::entityFieldAccess()`;
  `hook_preprocess_username` (last-resort blank of `#theme => 'username'` output);
  `hook_user_format_name_alter` (last-resort blank of `getDisplayName()`);
  `hook_module_implements_alter` makes the format-name hook run last.
- Correct caller pattern: `$user->access('view label', NULL, TRUE)` as `#access` on a
  `#theme => 'username'` element (see hooks doc).
- Entity-reference selection handler id: `default:strict_user_filtered_by_view_usernames`
  (`Plugin/EntityReferenceSelection/UserSelection`).
- Internal automatic behavior: the mail plugin manager is decorated
  (`MailManagerDecorator` via `MailPluginDecoratorPass`) so emails still resolve real usernames; an
  event subscriber (`event_subscriber.view_usernames.jsonapi_early_rendering_fix`) relaxes the
  format-name guard on JSON:API entity requests (JSON:API enforces field access itself).
- Everything except the two `Contracts\*` interfaces is `final` / `@internal`. The supported
  extension point is the decider tag — never subclass or decorate the internal services
  (`view_usernames.user_format_name_hardening_bypasser`, the JSON:API subscriber).

Operational notes:

```bash
drush role:perm:add editor 'view usernames'
# List roles that currently hold it:
drush php:eval 'foreach (\Drupal\user\Entity\Role::loadMultiple() as $r) { if ($r->hasPermission("view usernames")) print $r->id() . "\n"; }'
```

Enabling the module changes existing displays: author names, comment bylines, Views username fields
and JSON:API user resources start rendering blank for viewers who lack access. Audit public-facing
displays afterward.
