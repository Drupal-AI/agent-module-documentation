<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Envoke mailer plugin (`envoke_mail`)

`src/Plugin/Mail/EnvokeMailer.php` — `@Mail(id = "envoke_mail", label = "Envoke mailer")`, implements
core `MailInterface`. Constructor pulls `envoke.settings` config, `\Drupal::httpClient()`, and the
`envoke.envoke_service` service via static calls (no DI).

## Enabling it as the mail backend

There is no UI toggle in this module — select the plugin through core's mail system. Either use the
Mail System / Symfony Mailer UI, or set it in `system.mail`, e.g.:

```yaml
# config: system.mail
interface:
  default: envoke_mail
```

(or per-module/per-key keys). Then configure credentials on the Envoke settings form
([config/settings.md](../config/settings.md)).

## `format(array $message)`
Joins the `body` array into a single string with `\n\n` (no sanitization/wrapping beyond that).

## `mail(array $message)`
1. If `envoke_filter_format` is set, runs the body through `check_markup($body, $format)`.
2. If the body has no HTML tags, converts `\n` to `<br>` (and strips `\r`); converts `&amp;` back to `&`.
3. Renders the body into the `envoke_mail` theme (`templates/envoke-mail.html.twig`, which outputs
   `{{ body|raw }}` inside a fixed 600px HTML shell) via `\Drupal::service('renderer')->render()`.
4. Builds the Envoke message array: `to_email`, `message_subject`, `message_html` (templated body +
   `{@pref-99}`), `message_text` (`MailFormatHelper::htmlToText($body)` + `{@pref-99}`).
5. `campaign_name` = `envoke_campaign` or, if empty, the `system.site` name.
6. Sender fields: `from_email` from `$message['from']` then overridden by `envoke_email_from` if set;
   `from_name` from `envoke_name_from`; `reply_email` from `$message['reply-to']` else
   `envoke_email_reply`.
7. If `$message['to']` contains commas, it explodes and calls
   `EnvokeService::sendEmail()` once per recipient (with an increasing `usleep`, `SLEEP_INCREMENT=80000`),
   returning `FALSE` on the first failure; otherwise a single `sendEmail()` call.

## Template override
Copy `templates/envoke-mail.html.twig` into your theme to change the HTML wrapper (registered by
`envoke_theme()` in `envoke.module`; variables `body`, `base_url`).
