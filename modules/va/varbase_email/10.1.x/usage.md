<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Varbase Email is the mail-experience feature of the Varbase distribution. Enabling it runs a Drupal recipe that wires up Symfony Mailer and Easy Email, ships a branded HTML email template, an `email_html` CKEditor 5 text format, ready-made mailer policies for every core user/update mail, and a set of Easy Email notification types.

---

The module is a thin package whose real payload is a recipe. `varbase_email.info.yml` declares no Drupal dependencies; the coupling lives in `composer.json` (Symfony Mailer `~1||~2`, Easy Email `~3`, Ace Editor, Pathologic, Token Filter, Blazy, Slick and a stack of CKEditor 5 plugin packs). On install, `varbase_email_install()` calls `RecipeRunner::processRecipe()` on `recipes/default`, which installs `symfony_mailer` + `easy_email` and imports config: a `sendmail` transport set as default, a `_` default mailer policy (inline-CSS + URL-to-absolute), twelve `symfony_mailer.mailer_policy.*` policies overriding core user/update/test mails, an `email_html` filter format + CKEditor 5 editor, and five `easy_email_type` notification templates (login, blocked-users, inactive-users, role-changed, draft-content). Its only PHP is `src/Hook/VarbaseEmailHooks.php`, which registers a themeable `email` hook backed by `templates/varbase_emails.html.twig` and a `preprocess_email` handler that injects the site logo, name and slogan and attaches the LTR/RTL style library. Pathologic is load-bearing: mail renders outside a page request, so relative URLs in bodies must be rewritten to absolute. `includes/updates/` carries cross-release update hooks (e.g. uninstalling the old `symfony_mailer_bc` backward-compat submodule). It has no routes, permissions, config forms, plugin types or Drush commands of its own — configuration happens through Symfony Mailer's and Easy Email's admin UIs.

---

- Give a Varbase (or any Drupal 10/11) site a branded, responsive HTML email template out of the box.
- Replace Drupal's plain-text transactional mail with a designed layout showing the site logo, name and slogan.
- Bootstrap Symfony Mailer and Easy Email together with sensible defaults via a single recipe.
- Ship a default `sendmail` mail transport that an admin can swap for SMTP/API in the Mailer UI.
- Override every core user-account email (register, password reset, activate, block, cancel) with themed policies.
- Provide a themed "test email" mailer policy for verifying delivery.
- Send an update-status notification (`update.status_notify`) with matching styling.
- Author reusable, token-driven notification emails through Easy Email types.
- Send a "new sign-in" login notification email capturing time, IP, user-agent and location.
- Email admins a monthly report of automatically blocked (long-inactive) user accounts.
- Notify admins of inactive users or of role changes via ready-made Easy Email templates.
- Provide editors an `email_html` CKEditor 5 format tuned for email (emoji, bidi, paste-cleanup, media embed, advanced links, source editing).
- Rewrite relative links in email bodies to absolute URLs via Pathologic so links work in delivered mail.
- Inline CSS and convert URLs automatically on every message through the default mailer policy.
- Insert Drupal tokens into email subjects and bodies with Token Filter.
- Support right-to-left languages in email through direction-aware style libraries.
- Enforce email attachment safety with Easy Email's blocked-extension / blocked-MIME defaults.
- Keep mail styling consistent across many Varbase sites by exporting the same recipe config.
- Edit raw email HTML with a syntax-highlighted Ace editor filter when needed.
- Migrate a site from core mail formatting onto Symfony Mailer without hand-building policies.
- Match transactional mail to a site's visual identity for better brand recognition and lower spam scoring.
- Apply configuration changes across module releases through the `includes/updates/` hook pattern.
