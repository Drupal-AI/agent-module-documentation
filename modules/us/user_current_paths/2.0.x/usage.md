<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User current paths adds UID-neutral URLs for the logged-in user — `/user/current`, `/user/current/{action}` and `/user/edit` — that redirect to the equivalent `/user/{uid}/…` page, plus an "Edit my account" link in the account menu.

---

The module is a small routing convenience with no configuration, permissions, plugins or config schema. It defines three routes, all requiring `_user_is_logged_in: TRUE`: `/user/edit` (`editRedirect`) redirects to the current user's edit form (`entity.user.edit_form`); `/user/current` (`wildcardActionRedirect` with default action `view`) redirects to `/user/{uid}`; and `/user/current/{wildcardaction}` redirects to `/user/{uid}/{wildcardaction}` (e.g. `/user/current/edit` → `/user/{uid}/edit`, `/user/current/cancel` → `/user/{uid}/cancel`). The controller (`UserCurrentPathsController`) builds the target path by substituting the current user's id for "current", validates it with the core `path.validator` service, and only redirects if the resulting internal path is a valid, access-checked route — otherwise it throws a `NotFoundHttpException`. Because it redirects to real routes, all normal access checks still apply. It also registers a static menu link "Edit my account" (weight -9) in the `account` menu pointing at `/user/edit`. This lets you build menus, blocks and templates that link to a stable "the current user's X" URL without knowing the uid or writing a controller.

---

- Link to "Edit my account" from any menu using the stable `/user/edit` path.
- Give users a "My profile" link via `/user/current` that resolves to their own `/user/{uid}`.
- Build a "Cancel my account" link with `/user/current/cancel` without knowing the uid.
- Add a UID-neutral "My content" style link using `/user/current/{action}` for a routed sub-path.
- Use `/user/edit` in a block placed for authenticated users so everyone edits their own account.
- Avoid writing a custom controller just to redirect to the current user's pages.
- Provide the account-menu "Edit my account" link out of the box for logged-in users.
- Create theme/Twig links to the current user's profile that work for any visitor.
- Reference `/user/current` in documentation or onboarding flows as "your profile".
- Point a post-login destination at `/user/edit` to send users to their own edit form.
- Add a consistent header link to the current user's dashboard-style page via a routed action.
- Use `/user/current/edit` as an alias-style shortcut to the current user's edit form.
- Keep links working across environments where user ids differ (staging vs prod).
- Let contributed modules that expose `/user/{uid}/{something}` routes be reached UID-neutrally.
- Redirect safely: invalid or inaccessible targets return 404 instead of leaking pages.
- Simplify multisite menu configuration by using UID-neutral user links.
- Provide anonymous-safe menu items (the routes require login, so anonymous users don't see broken links).
- Offer a quick "manage your account" entry point in a user-facing navigation region.
- Wire a "my settings" call-to-action to `/user/current/edit`.
- Use the `account` menu's "Edit my account" item as the basis for a custom user menu.
- Give SSO/registration flows a fixed self-service edit URL (`/user/edit`).
- Support Drupal 8.9 through 11 with the same lightweight redirects.
