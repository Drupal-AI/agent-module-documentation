<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Varbase Social Single Sign-On (varbase_auth) — agent index

Thin **Varbase** feature that bundles the **Social Auth** provider ecosystem and puts a
social-login block on the login/register pages. Version **10.1.2** (doc series `10.1.x`).
Core **`~11.4.0`** — pinned to one Drupal minor, as with the rest of the Varbase family.
Depends on `system`, `block`, `social_auth:social_auth`. **No routes, permissions, config
schema, or config_rewrite of its own.**

## What it actually contains

- `varbase_auth.info.yml` — deps: `system`, `block`, `social_auth`.
- `composer.json` — pulls `social_api ~4.1`, `social_auth ~4.2`, and provider modules
  `social_auth_google`, `social_auth_facebook`, `social_auth_linkedin` (all `~4`), plus
  `vardot/varbase-patches`.
- `varbase_auth.services.yml` — registers the single hook class, injecting
  `current_route_match` and `module_handler`.
- `src/Hook/VarbaseAuthHooks.php` — the only PHP logic. One D11 `#[Hook('preprocess_page')]`
  method: on the `user.login` / `user.register` routes it scans the enabled-module list for
  any `social_auth_*` module and sets the template boolean
  `varbase.we_do_have_enabled_social_auth_modules` so a theme can show/hide the social
  buttons. No auth, token, or account logic.
- `varbase_auth.install` — `hook_install()` runs the recipe in `recipes/default/`, which
  installs **`social_auth_google`**. Update `varbase_auth_update_90001()` deletes the stale
  `simple.settings` config left over from an older install.
- `config/optional/block.block.vartheme_bs4_socialauthlogin.yml` — optional `social_auth_login`
  block ("Login with"), placed by theme `vartheme_bs4` in the content region, visible on
  `/user/login` and `/user/register`.
- `tests/varbase_auth_test/recipe.yml` — **test-only** recipe (installs the three providers and
  sets `user.settings register: visitors_admin_approval`); not shipped/enabled in normal use.

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
