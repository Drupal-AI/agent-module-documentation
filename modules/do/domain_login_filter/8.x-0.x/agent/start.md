<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Login Filter (domain_login_filter) — agent index

Blocks a user from logging in on a **Domain (Domain Access)** they are not assigned to. On a
multi-domain site it scopes *interactive login* to each user's Domain Access assignments. Package
`Domain`. Declares dependency `domain:domain`; in practice also needs the **`domain_access`**
submodule enabled (it calls the `domain_access.manager` service). Core requirement
`^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Documented version dir `8.x-0.x` (release
`8.x-0.1-rc4`). **Not** covered by Drupal's security advisory policy.

- **The hook, the validator, and how to operate it** → [hooks/login-filter.md](hooks/login-filter.md)

## What it actually is

- One file of logic: `domain_login_filter.module`. No `src/`, no routes, no permissions, no
  services, no Drush, no config objects/schema, no submodules.
- `domain_login_filter_form_alter()` (`hook_form_alter`) appends the validator
  `_domain_login_filter_domain_check` to the `#validate` array of **two** forms:
  `user_login_form` (login) and `user_pass` (password-reset **request** form). It inserts the
  validator immediately after the form's first (`$source_id == 0`) validator.
- `_domain_login_filter_domain_check()` (form validator): loads the account by the submitted
  `name` value via `user_load_by_name()`, falling back to `user_load_by_mail()`. Returns (no
  block) if no account matches or if the account is **user 1**. Otherwise it reads the account's
  assigned domains via `\Drupal::service('domain_access.manager')->getAccessValues($user)` and the
  active domain via `\Drupal::service('domain.negotiator')->getActiveDomain()->getDomainId()`, and
  calls `$form_state->setErrorByName('name', …)` when the active domain is **not** in the assigned
  set (strict `array_search(..., TRUE) === FALSE`).

## Configuration

- **None.** No settings form, no config object, `configure` is null. Behaviour is driven entirely
  by each user's Domain Access assignments (set on the user account, or in bulk via Domain Access).
  It works as soon as the module is enabled.

## Operational notes

- The validator only fires on the two named form IDs; it is a **login-time form check**, not a
  per-request re-check. See [hooks/login-filter.md](hooks/login-filter.md) for the exact scope and
  the runtime dependency on `domain_access`.
