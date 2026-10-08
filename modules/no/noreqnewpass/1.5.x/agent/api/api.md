<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# noreqnewpass — API / internals

All behavior keys off the config flag `noreqnewpass.settings_form:noreqnewpass_disable`.
When it is FALSE every hook below no-ops and core behaves normally. There is no public API
to call — these are the internal mechanisms an agent may need to reason about.

## Services (`noreqnewpass.services.yml`)

| Service id | Class | Role |
|---|---|---|
| `noreqnewpass.route_subscriber` | `Drupal\noreqnewpass\Routing\RouteSubscriber` | Event subscriber; denies the reset routes. |
| `noreqnewpass.form_hooks` | `Drupal\noreqnewpass\Hook\Form` | Login-form `hook_form_alter` + replacement validator. |
| `noreqnewpass.theme_hooks` | `Drupal\noreqnewpass\Hook\Theme` | Login-block `hook_preprocess` that hides the reset link. |

`noreqnewpass.module` wires the two hook services via `#[LegacyHook]` shims
(`noreqnewpass_form_alter`, `noreqnewpass_preprocess_block__user_login_block`); the classes
themselves carry `#[Hook(...)]` attributes for Drupal 11's OOP hook system.

(There is also an unused `Services/NoreqnewpassFlood` wrapper class, not registered as a
service and not part of the active code path.)

## 1. Route denial — `RouteSubscriber::alterRoutes`

When the flag is TRUE, sets `_access` = `'FALSE'` on the core routes `user.pass`
(`/user/password`) and `user.pass.http` (the REST reset endpoint), making both return
access-denied for everyone. Because route access is compiled, a **router rebuild** is
required after changing the config (the settings form does this automatically; do
`drush cr` after a manual `config:set`).

## 2. Login form alter — `Hook\Form::formAlter`

Fires only for `form_id` `user_login_form` or `user_login_block`, and only when the flag is
TRUE. It finds core's `::validateFinal` entry in `$form['#validate']` and replaces it with
the module's own `[$this, 'validateForm']`. That replacement validator re-implements the
final login validation: it registers IP and per-user flood events (`user.failed_login_ip`,
`user.failed_login_user`) using windows from `user.flood` config, clears prior per-user
failures on success, emits the flood "temporarily blocked" messages, and otherwise sets the
generic `Unrecognized username or password.` error — deliberately without pointing the user
at a password-reset link. Core flood protection is preserved.

## 3. Login block preprocess — `Hook\Theme::preprocessBlockUserLoginBlock`

`#[Hook('preprocess_block__user_login_block')]`. When the flag is TRUE and
`$variables['content']['user_links']['#items']['request_password']` is set, it unsets that
item so the "Request new password" link disappears from the user login block.
