<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Web Security (websecurity) — agent index

Security **meta-package** (part of the Webship `web*` suite). Version **12.0.2**, core `^11.4 || ^12`.
License GPL-2.0-or-later. No admin UI, routes, permissions, or config schema of its own.

## What it is
Requiring `drupal/websecurity` with Composer pulls in a curated security/anti-spam bundle. On install
(`websecurity.install` → `websecurity_install()`) it applies the bundled `recipes/default` recipe, which
enables those modules, imports their config, and applies hardening defaults. It ships one PHP class that
generates random local Friendly Captcha keys after any recipe is applied.

## Dependencies
- Enable-time module dependency (`websecurity.info.yml`): `friendlycaptcha`.
- Composer bundle (`composer.json` require, minus core): `recaptcha_v3 ~2.0.0`, `flood_control ~3.0`,
  `seckit ~2.0.0`, `security_review ~3.1.0`, `honeypot ~2.2.0`, `antibot ~2.0.0`, `klaro ^3.0`,
  `captcha ^2.0.7`, `friendlycaptcha ^1.1`, `friendly_captcha_challenge ^0.9`, `bpmn_io ^2.0.2||^3`,
  `eca ^2.1.0-beta1||^3`, `login_emailusername ^3`, `token ^1`.
- The recipe additionally installs the ECA submodules `eca_base`, `eca_form`, `eca_misc`, `eca_user`.

## What it provides
- **No** entities, plugins, routes, permissions, drush commands, or settings form.
- **1 service** (`websecurity.services.yml`): the event subscriber below.
- **1 class**: `Drupal\websecurity\EventSubscriber\FriendlyCaptchaKeysSubscriber` — subscribes to
  `RecipeAppliedEvent`, saves random keys into `friendlycaptcha.settings`.
- **1 recipe**: `recipes/default` (module installs + config import + config actions).
- **2 ECA models** + **14 Security Review check** config entities shipped by the recipe.

## Solution docs
- [The default recipe (what it installs & configures)](config/recipe.md)
- [Security Review checks enabled](config/security-review-checks.md)
- [ECA workflow models (auth_redirects, user_register)](workflows/eca-models.md)
- [Friendly Captcha key generation (FriendlyCaptchaKeysSubscriber)](api/friendlycaptcha-keys.md)
