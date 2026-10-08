<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A pure API module that lets other modules compose and send emails with an object-oriented, chainable, Twig-template-based interface instead of Drupal core's hook-based mail system.

Core's `hook_mail()` approach scatters email definition across procedural hooks. Mail composer wraps the core mail manager behind a `mail_composer.manager` service and an `Email` value class. Developers subclass `Drupal\mail_composer\Email` to declare subject, from, to, reply-to, langcode, key, headers, and body (or a Twig body template named after the class), then call `$manager->compose($email)->setTo(...)->send()`. Setters on the manager override any values from the Email class. Without a custom class, `compose()` uses the default `Email` and everything is set via fluent setters. Sending requires `to`, `langcode`, and `key`; a `MailingException` is thrown if any required property is empty. The manager delegates to `@plugin.manager.mail`, so the site's configured mail plugin (and modules like Symfony Mailer/SwiftMailer for HTML) still handle actual delivery.

The service takes the mail manager, language manager, and config factory. It is used entirely from code — there are no routes, permissions, forms, or config of its own. Multilingual bodies are supported via per-language Twig templates (`name.de.html.twig`) or `t()`. Because it is a thin, credential-free wrapper over core mail, it introduces no network endpoints or secrets.
---
Programmatic OOP/Twig email composition wrapper over Drupal's core mail manager.
---
- Send a transactional email from custom module code in a few lines.
- Define a reusable `Email` subclass per email type (subject/from/body).
- Use a Twig template for the email body with variables.
- Override Email-class values at send time via manager setters.
- Send without a custom class using only fluent setters.
- Set reply-to, headers, key, and langcode per message.
- Localize subject and body with `t()` for multilingual sites.
- Provide per-language body templates like `welcome.de.html.twig`.
- Throw/handle `MailingException` when required fields are missing.
- Route delivery through the site's configured mail plugin.
- Send HTML emails when paired with Symfony Mailer/SwiftMailer.
- Compose order/notification emails from an e-commerce module.
- Centralize email templates in a module's `templates/emails/` dir.
- Set a custom Drupal mail `key` for per-key mail alterations.
- Build the body from an array of paragraphs via `setBody()`.
- Inject `mail_composer.manager` into your own services.
- Replace legacy `hook_mail()` implementations with Email classes.
- Send the same email in different languages by changing langcode.
- Add custom headers (e.g. `X-` tags) for downstream filtering.
- Unit-test email composition by asserting on the manager state.