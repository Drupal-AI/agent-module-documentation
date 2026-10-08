<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User current paths — agent index

Adds UID-neutral URLs for the logged-in user that redirect to the equivalent `/user/{uid}/…`
page, plus an "Edit my account" link in the `account` menu. **No config, no permissions, no
plugins, no config schema, no Drush** — it is purely routes + one static menu link.

- **The routes, the redirect logic, and the menu link** → [api/routes.md](api/routes.md)

Key facts:
- `/user/edit` → current user's edit form (`entity.user.edit_form`).
- `/user/current` → `/user/{uid}` (action defaults to `view`).
- `/user/current/{wildcardaction}` → `/user/{uid}/{wildcardaction}` (e.g. `/user/current/cancel`).
- All routes require `_user_is_logged_in: TRUE`. Targets are validated with `path.validator`;
  invalid/inaccessible → `NotFoundHttpException` (404). Controller: `UserCurrentPathsController`.
- Menu link "Edit my account" (weight -9) in the `account` menu → route `user_current_paths.edit_redirect`.
