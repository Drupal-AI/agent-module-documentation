<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Varbase Email

Varbase Email has **no config form of its own** (`configure: null`). All of its behaviour is
delivered as config imported by the install recipe, and you tune it through **Symfony Mailer** and
**Easy Email**. Read this to know exactly what the recipe creates and where to change it.

## How install works (recipe, not `config/install`)

`varbase_email.install` → `varbase_email_install()` runs the recipe at `recipes/default`:

```php
$default_recipe = Recipe::createFromDirectory(__DIR__ . '/recipes/default');
RecipeRunner::processRecipe($default_recipe);
```

`recipes/default/recipe.yml` is `type: install` and does two things:

```yaml
install:
  - symfony_mailer
  - easy_email
```

then imports every file under `recipes/default/config/`. Recipe config is imported **once** at
install; editing the module's YAML afterwards does nothing to a live site — change the active config
instead (UI or `drush cset`). Re-running the recipe re-imports it.

## Symfony Mailer config it ships

- **`symfony_mailer.settings`** — `default_transport: sendmail`, with `override: {user: 1, update: 1}`
  (Symfony Mailer takes over the core `user` and `update` mails).
- **`symfony_mailer.mailer_transport.sendmail`** — a `sendmail` plugin transport,
  `command: '/usr/sbin/sendmail -t'`. This is the default transport. **Change it for real delivery:**
  add an SMTP/API transport at `/admin/config/system/mailer` (Configuration → System → Mailer) and set
  it default, or `drush cset symfony_mailer.settings default_transport <id>`.
- **`symfony_mailer.mailer_policy._`** — the global default policy applied to all mail:
  `mailer_url_to_absolute`, `mailer_inline_css`, `mailer_wrap_and_convert` (plain/swiftmailer off),
  and `email_theme.theme: _active_fallback`.
- **11 per-mail policies** (`symfony_mailer.mailer_policy.<id>`), each overriding a specific message's
  subject/body:
  - `user.register_pending_approval`, `user.register_pending_approval_admin`,
    `user.register_no_approval_required`, `user.register_admin_created`
  - `user.password_reset`, `user.status_activated`, `user.status_blocked`, `user.status_canceled`,
    `user.cancel_confirm`
  - `update.status_notify` (available-updates mail)
  - `symfony_mailer.test` (themed test email; send it from the Mailer UI to verify delivery)

  Edit any of these under *Mailer → Policies*. Bodies use core tokens (`[user:display-name]`,
  `[user:one-time-login-url]`, `[site:name]`, …).

## The `email_html` text format + editor

- **`filter.format.email_html`** ("Email HTML") — the format used for HTML mail bodies. Enabled
  filters: `filter_align`, `filter_autop`, `filter_ckeditor_media_embed`, `filter_html_image_secure`,
  `filter_htmlcorrector`, **`filter_pathologic`** (`protocol_style: full` — rewrites relative URLs to
  absolute so links survive outside a page request), `filter_url`, `token_filter` (with
  `replace_empty: true`). Note `filter_html` (tag allow-listing) is **disabled** in this format, and
  `filter_html_escape` is not present — the format does not strip disallowed HTML, so treat any
  token/content rendered through it as trusted-author content.
- **`editor.editor.email_html`** — a CKEditor 5 editor bound to that format with an email-oriented
  toolbar: images, tables, links (advanced-link attributes), alignment, headings 2–6, bidi
  `direction`, emoji, paste-filter (strips Word/`<span>`/`<font>` cruft), source editing, find &
  replace. Inline image uploads go to `public://inline-images`.

## Easy Email config it ships

- **`easy_email.settings`** — attachment safety defaults worth knowing: `email_collection_access: true`
  (sent emails are saved/browsable), `allowed_attachment_paths: ['public://*']`, `max_attachment_size:
  10` (MB), and long **blocked** extension / MIME lists (executables, `php*`, `js`, shell scripts,
  etc.). `purge_on_cron: true`, `purge_cron_limit: 50`.
- **5 `easy_email.easy_email_type.<id>` templates**, each an HTML email (`format: email_html`) with
  `saveEmail: true`:
  - `login_notification` — "new sign-in" mail to `[logged_user:mail]`; body includes time,
    `[logged_user_ip_address]`, `[logged_user_agent]`, `[logged_user_location]`.
  - `blocked_users_notification` — monthly report to `[admin_user:mail]` of auto-blocked
    long-inactive accounts (`[blocked_users_html_table]`).
  - `inactive_users_notification`, `role_changed_notification`, `draft_content_notification`.

  Manage/edit these at *Structure → Email templates* (`/admin/structure/email-templates`); sent
  copies live at *Content → Emails*. The `logged_*` and `blocked_users_*` tokens are provided by
  companion Varbase/Easy Email add-ons, not by varbase_email itself.

## Cross-release update hooks

`includes/updates.inc` pulls in `includes/updates/v9.inc` and `v10.inc`:

- `varbase_email_update_90001` — sets the module's weight after `swiftmailer`/`mailsystem` via
  `Vardot\Installer\ModuleInstallerFactory` (legacy path).
- `varbase_email_update_100001` — uninstalls the deprecated `symfony_mailer_bc` backward-compat
  submodule if present.

Run with `drush updatedb`.
