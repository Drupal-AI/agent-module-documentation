<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User current paths — routes & redirects

Controller: `Drupal\user_current_paths\Controller\UserCurrentPathsController`
(injects core `path.validator`). Every route requires `_user_is_logged_in: TRUE`.

| Route | Path | Redirects to | Method |
|---|---|---|---|
| `user_current_paths.edit_redirect` | `/user/edit` | `entity.user.edit_form` for the current uid | `editRedirect()` |
| `user_current_paths.current_redirect` | `/user/current` | `/user/{uid}` (action defaults to `view`) | `wildcardActionRedirect('view')` |
| `user_current_paths.wildcardaction_redirect` | `/user/current/{wildcardaction}` | `/user/{uid}/{wildcardaction}` | `wildcardActionRedirect($wildcardaction)` |

## Redirect logic

`wildcardActionRedirect()` builds the target path `"/user/" . currentUser()->id()`, and for any
action other than `view` appends `"/" . $wildcardaction` (there is no `/user/{uid}/view` route, so
`current` alone → the canonical user page). It then calls
`path.validator->getUrlIfValid($path)`; if valid it redirects to that route with its parameters and
options, otherwise it throws `NotFoundHttpException`. Because the target is a real, access-checked
route, all normal permission checks apply — the module never bypasses access.

Examples (as the logged-in user, uid 42):
- `/user/current` → `/user/42`
- `/user/current/edit` → `/user/42/edit`
- `/user/current/cancel` → `/user/42/cancel`
- `/user/edit` → `/user/42/edit`
- `/user/current/nonexistent` → 404 (path.validator rejects it)

## Menu link

`user_current_paths.links.menu.yml` adds a static link **"Edit my account"** (weight -9) in the
`account` menu, route `user_current_paths.edit_redirect`. Logged-in users see it in the user menu.

## Using these paths

Link to them anywhere (menus, blocks, Twig) as stable "current user" URLs — e.g.
`Url::fromRoute('user_current_paths.edit_redirect')` or simply the path `/user/current`. There is
nothing to configure; the module has no settings, permissions, plugins, config schema or Drush
commands. Its only dependency is core `user`.
