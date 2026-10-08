<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block plugin: `forgot_password_block`

The module's entire functionality. Source: `src/Plugin/Block/ForgotPasswordBlock.php`.

## Definition

- Annotation: `@Block(id = "forgot_password_block", admin_label = @Translation("Forgot Password"),
  category = @Translation("Forms"))`.
- Class `ForgotPasswordBlock extends \Drupal\Core\Block\BlockBase implements
  ContainerFactoryPluginInterface`.
- `create()` injects `$container->get('form_builder')` (typed `\Drupal\Core\Form\FormBuilder`) into
  the constructor, stored as `$this->formBuilder`.
- `build()` (the whole implementation):
  ```php
  return $this->formBuilder->getForm('Drupal\user\Form\UserPasswordForm');
  ```
  It returns the render array of **core's** `UserPasswordForm` — the same form served at
  `/user/password`. The module does not subclass, alter, wrap, or post-process that form.

## What this means in practice

- The block is the stock core reset-request form: a "Username or email address" field plus a
  "Submit" button. Submitting mails the account a one-time login link.
- Because it is the core Form API form fetched through `form_builder->getForm()`, it carries core's
  behaviour with nothing added or removed:
  - The Form API **CSRF token** on submission.
  - Core's **password-reset flood control** (`user.flood.ip_limit` / `ip_window` and
    `user_limit` / `user_window`) — the block does not change the route, so the same limits apply.
  - Core's **generic confirmation** ("Further instructions have been sent to your email address" /
    the anti-enumeration message), i.e. the same response whether or not the account exists.
- The block does **not** define `blockAccess()`, so it uses `BlockBase`'s default (accessible);
  gate visibility/audience with the block's standard visibility conditions (roles, pages, content
  type) in Block Layout, exactly as for any block.
- No `defaultConfiguration()`, `blockForm()`, or `blockSubmit()` — the block has **no settings of
  its own** beyond the generic block config (label, region, visibility).

## Install and place

1. `composer require drupal/forgot_password_block` then enable: `drush en forgot_password_block -y`
   (pulls in core `user` and `block`, both usually already enabled).
2. Go to **Structure → Block layout** (`/admin/structure/block`).
3. Click **Place block** in the target region, find **"Forgot Password"** (category *Forms*), place
   it, set label/visibility, and save.
4. The core password-reset form now renders in that region.

## Help hook

`forgot_password_block_help()` in `forgot_password_block.module` shows the project `README.md` on
`admin/help/forgot_password_block`. If the contrib `markdown` module is enabled it renders the
README through `plugin.manager.markdown.parser` with `render_strategy => ['type' => 'none']`;
otherwise it returns the raw README wrapped in `<pre>`. Purely informational.

## Notes

- Uninstall is clean: no schema, no stored config object, no database tables, no update hooks.
- To change reset behaviour (flood limits, mail text, form fields) you edit **core user** settings,
  not this module — it only relocates the existing form.
