<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Varbase Email (varbase_email) — agent index

The mail-experience feature of the **Varbase** distribution. Enabling the module runs a Drupal
**recipe** (`recipes/default`) that installs **Symfony Mailer** + **Easy Email** and imports a full
set of themed mail config; the module's own code is one Twig template plus a preprocess hook. Works
on any Drupal 10/11 site, best with Varbase. `core_version_requirement: ~11.4.0`. Package `Varbase`.

No routes, permissions, config forms, plugin types, or Drush commands of its own — you configure it
through **Symfony Mailer** (`/admin/config/system/mailer`) and **Easy Email**
(`/admin/content/email`, `/admin/structure/email-templates`).

## What you'd do → where

- **Understand what the install recipe wires up, and change the transport / mailer policies / Easy
  Email types / `email_html` format** → [configure/varbase_email.md](configure/varbase_email.md)
- **Understand/override the HTML email template, the `email` theme hook, the `preprocess_email`
  variables (logo, site name/slogan) and the LTR/RTL style libraries** →
  [theming/varbase_email.md](theming/varbase_email.md)

## Key facts (real machine names)

- **No module dependencies in `info.yml`** (`dependencies: {}`); coupling is in `composer.json`:
  `drupal/symfony_mailer ~1||~2`, `drupal/easy_email ~3`, `drupal/pathologic ~2`,
  `drupal/token_filter ~2`, `drupal/ace_editor ~2`, `drupal/blazy ~3`, `drupal/slick ~3`,
  `drupal/ckeditor_media_embed ~2`, `drupal/ckeditor5_plugin_pack ~1.5`, `drupal/ckeditor_emoji ~2`,
  `drupal/ckeditor_bidi ~5`, `drupal/ckeditor5_paste_filter ~1`, `drupal/editor_advanced_link ~2.3`.
  Also needs the `vardot/varbase-patches` composer plugin allowed. `drush en varbase_email` alone,
  without composer-installing the project, gives a template with nothing to render it.
- **Install is a recipe, not `config/install`:** `varbase_email_install()` (in `varbase_email.install`)
  calls `RecipeRunner::processRecipe(Recipe::createFromDirectory(__DIR__.'/recipes/default'))`.
  `recipes/default/recipe.yml` installs `symfony_mailer` + `easy_email` then imports
  `recipes/default/config/*`.
- Hook class: `Drupal\varbase_email\Hook\VarbaseEmailHooks` (attribute `#[Hook(...)]`) —
  `theme()` registers theme hook `email` (template `varbase_emails`, `mail theme => TRUE`);
  `preprocess_email()` sets `logo`, `site_name`, `site_slogan`, `body` and attaches
  `varbase_email/default.email-style.{ltr,rtl}`.
- Template: `templates/varbase_emails.html.twig`. Libraries: `varbase_email/default.email-style.ltr`
  and `.rtl` (`css/theme/email-style.theme.{ltr,rtl}.css`).
- Shipped config: `symfony_mailer.settings` (`default_transport: sendmail`),
  `symfony_mailer.mailer_transport.sendmail`, `symfony_mailer.mailer_policy._` (default: inline-CSS +
  URL-to-absolute), 11 more `symfony_mailer.mailer_policy.*` (user.*, update.status_notify,
  symfony_mailer.test), `filter.format.email_html` + `editor.editor.email_html` (CKEditor 5),
  `easy_email.settings`, and 5 `easy_email.easy_email_type.*` (login_notification,
  blocked_users_notification, inactive_users_notification, role_changed_notification,
  draft_content_notification).
- `includes/updates/{v9,v10}.inc` (loaded via `includes/updates.inc`) hold cross-release update hooks
  — v9 sets module weight via `Vardot\Installer\ModuleInstallerFactory`; v10 uninstalls the legacy
  `symfony_mailer_bc` submodule.
- Test-only modules under `tests/` (`varbase_email_test*`) are Behat/Playwright fixtures, not
  shipped submodules.
