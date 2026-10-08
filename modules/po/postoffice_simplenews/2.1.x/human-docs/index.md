# Postoffice Simplenews — manual setup guide

**Postoffice Simplenews** (`postoffice_simplenews`) is a bridge that makes **Simplenews**
newsletter emails go out through the **Postoffice** module and **Symfony Mailer**, instead of
Drupal's legacy mail formatting. It provides a mail plugin (`postoffice_simplenews_mail`) that
maps each Simplenews mail type to a dedicated email builder — newsletter issues (test, node,
and extra sends), double‑opt‑in subscription confirmations, and subscription‑settings /
validation emails — each rendered from its own Twig template, with per‑newsletter and
per‑language template overrides available.

The result is modern, themed HTML/plain‑text newsletters sent over any Symfony Mailer transport,
while Simplenews keeps handling all the subscription and access logic exactly as before. This is
a developer‑oriented module with **no forms, routes, permissions, or configuration schema of its
own** — you switch it on with a single Drush command.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it
   alongside Postoffice and Simplenews.

There is no configuration page — setup is a Drush command, described under "How to use it"
below.

## How to use it

1. Make sure Postoffice itself is configured — its transport DSN and mail theme, set on the
   **Postoffice** module's settings form at `/admin/config/system/postoffice`.
2. Point Simplenews's mail interface at this plugin:

   ```bash
   drush config:set system.mail interface.simplenews postoffice_simplenews_mail
   ```

   After this, `system.mail` maps `simplenews` to `postoffice_simplenews_mail`, and all
   newsletter, confirmation, and subscription‑settings mail flows through Postoffice.

### Theming your newsletters

Copy the module's `templates/*.html.twig` files into your theme to override the output. The
available templates are the issue email, the confirmation email, and the subscription‑settings
email, and template suggestions let you target a specific newsletter and/or language — for
example `postoffice_simplenews_issue_email__{newsletter_id}__{langcode}`. The transport
(SMTP and so on) is configured in Postoffice / Symfony Mailer, not here.
