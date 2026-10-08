<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Varbase Social Single Sign-On (varbase_auth) — agent index

Thin **Varbase** feature that bundles the **Social Auth** provider ecosystem and themes a
social-login block plus per-provider buttons onto the login/register pages. Version **11.0.0**
(doc series `11.0.x`). Core **`~11.4.0`** — pinned to one Drupal minor, as with the rest of the
Varbase family. Info.yml declares one dependency: `social_auth:social_auth`. **No routes,
permissions, config schema, services, or config_rewrite of its own.**

## What it actually contains

- `varbase_auth.info.yml` — dep: `social_auth:social_auth`; `core_version_requirement: ~11.4.0`.
- `composer.json` — pulls `social_api ~4.1`, `social_auth ~4.2`, and providers
  `social_auth_google`, `social_auth_facebook`, `social_auth_linkedin` (all `~4`). Note: this
  11.0.x release **no longer requires `vardot/varbase-patches`** (10.1.x did). README also
  mentions Twitter, but composer does not require a Twitter provider.
- `varbase_auth.module` — all logic is here, procedural (no `src/`, no `.services.yml`):
  - `hook_preprocess_page()` — on `user.login` / `user.register` scans the enabled-module list
    for any `social_auth_*` module and sets `varbase.we_do_have_enabled_social_auth_modules`
    (via `varbase_auth__add_template_variable()`) so a theme can show/hide the social buttons.
  - `hook_preprocess_login_with()` — for each Social Auth network, resolves the provider logo
    under `images/social_auth/<provider>/<img_path>` and exposes it as `custom_networks[$id]`.
  - `hook_theme()` — registers theme hooks `login_with` (template `templates/login-with.html.twig`)
    and `block_social_auth_html` (`templates/block--social-auth.html.twig`).
  - `hook_library_info_alter()` — when the active theme is `gin`, drops Social Auth's own
    `auth-icons` CSS and appends this module's `varbase_auth/auth-icons` library instead.
- `includes/helpers.inc` — `varbase_auth__add_template_variable()` helper (populates a `varbase`
  template variable namespace); included at the top of the `.module` file.
- `varbase_auth.libraries.yml` — one CSS-only library `auth-icons`
  (`css/theme/auth-icons.theme.css`; SCSS source under `scss/`).
- `images/social_auth/…` — branded logos for facebook/google/linkedin/twitter.
- No `.install`, no install recipe, no `config/optional/*` block, no `tests/` — all present in
  10.1.x are **gone** in this release; enabling providers and placing the block is left to the
  site/distribution.

## Solution docs

- [Theming & integration](theming/social-login.md) — the four hooks, the two templates, the
  `custom_networks` logo mapping, the gin `auth-icons` swap, and how it relies on Social Auth.

## Where the real behavior lives

This module holds no OAuth logic. Client IDs/secrets, redirect URIs, TLS, and — critically —
**account linking** are all configured in Social Auth and its per-provider modules, not here.

**Three things to raise for any social login (all decided in Social Auth, not this module):**

1. **Account linking is the security decision.** Whether a social identity whose email matches
   an existing local account logs into that account determines whether control of a provider
   account grants control of a local one. Review Social Auth's email-matching / verification
   settings before enabling where privileged local accounts exist.
2. **Provider outage = login outage** for anyone without a local password. Keep a local password
   path for staff.
3. **Each provider is a data-sharing relationship** — identity, usually email and profile data.
   Privacy notice, and on an EU site the lawful-basis analysis.
