<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Forgot Password Block (forgot_password_block) — agent index

Renders Drupal core's **password-reset request form** (`Drupal\user\Form\UserPasswordForm`, the
form at `/user/password`) as a **placeable block**. Version **8.x-2.2**. Package `User`. License
GPL-2.0-or-later. Core requirement `^8 || ^9 || ^10 || ^11`.

- Dependencies: core **`user`** and **`block`** only. No Composer deps beyond core. No PHP constraint.
- Provides: **one block plugin**, nothing else. No routes, no permissions, no services, no config
  objects, no schema, no Drush, no submodules, no install/update hooks.

## What it actually is

- `src/Plugin/Block/ForgotPasswordBlock.php` — `ForgotPasswordBlock extends BlockBase implements
  ContainerFactoryPluginInterface`. `@Block(id = "forgot_password_block", admin_label = "Forgot
  Password", category = "Forms")`. Injects the `form_builder` service. Its `build()` is one line:
  `return $this->formBuilder->getForm('Drupal\user\Form\UserPasswordForm');` — so it emits the core
  reset-request form unchanged (core CSRF token, flood control, generic confirmation message).
- `forgot_password_block.module` — only `hook_help()` for `help.page.forgot_password_block`, which
  `file_get_contents(README.md)` and either wraps it in `<pre>` or, if the optional contrib
  `markdown` module is present, runs it through the markdown parser with `render_strategy: none`.
- No `.routing.yml`, `.permissions.yml`, `.services.yml`, `.links.*.yml`, `.install`, or `config/`.

## Operate it

- **The block plugin, install, placement, and the core form it wraps** →
  [plugins/forgot_password_block.md](plugins/forgot_password_block.md)
