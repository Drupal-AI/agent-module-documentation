<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Envoke (envoke) — agent index

Routes Drupal outgoing mail through the **Envoke** email-marketing platform's API, and provides a
service to create/update Envoke contacts and read their subscription interests. Package `Mail`.
Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version dir 1.0.x (installed release
**1.0.0-beta3**, a beta pre-release). No contrib/Composer dependencies.

## What it actually provides (from source)

- **Mail plugin** `EnvokeMailer` (id **`envoke_mail`**, label "Envoke mailer"), in
  `src/Plugin/Mail/EnvokeMailer.php`, implementing core `MailInterface`. Select it as the mail
  backend to send site mail via Envoke. → [mail/mailer.md](mail/mailer.md)
- **Service** `EnvokeService` (service id **`envoke.envoke_service`**, `src/EnvokeService.php`):
  `sendEmail()`, `insertContactIfNotExist()`, `getContactSubscriptions()`. Guzzle client over the
  Envoke REST API. → [api/service.md](api/service.md)
- **Settings form** `EnvokeAdminSettingsForm` (`ConfigFormBase`), config object **`envoke.settings`**,
  route **`envoke.admin`** at `/admin/config/services/envoke`. → [config/settings.md](config/settings.md)
- **Permission** `administer envoke` (`envoke.permissions.yml`, `restrict access: true`) — gates the
  settings route.
- **Theme hook** `envoke_mail` (`envoke.module` `hook_theme()`) + template
  `templates/envoke-mail.html.twig` — the HTML email wrapper (overridable in a theme).
- One menu link (`envoke.links.menu.yml`) under Configuration → Services.

## Not present

No blocks, no subscribe form/route, no webhook/callback route, no Drush commands, no config schema
(`config/schema/` absent), no submodules, no plugin types, no fields, no entities. The only route is
the admin settings form.

## Docs

- [config/settings.md](config/settings.md) — settings form, `envoke.settings` keys, route, permission.
- [api/service.md](api/service.md) — `EnvokeService` methods, endpoints, auth.
- [mail/mailer.md](mail/mailer.md) — the `envoke_mail` Mail plugin and how to route mail through it.
