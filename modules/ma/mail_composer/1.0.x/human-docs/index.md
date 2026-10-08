# Mail composer — manual setup guide

**Mail composer** (`mail_composer`) is a **pure API module for developers**. It
lets other modules compose and send emails through a clean, object‑oriented,
Twig‑template‑based interface instead of Drupal core's scattered, hook‑based mail
system. There is no admin UI, no settings form, and no configuration of its own —
you use it entirely from code.

Core's `hook_mail()` approach spreads a single email's definition across
procedural hooks. Mail composer wraps the core mail manager behind a
`mail_composer.manager` service and an `Email` value object. You subclass
`Drupal\mail_composer\Email` to declare a message's subject, from, to, reply‑to,
langcode, key, headers, and body (or a Twig body template named after the class),
then call something like
`$manager->compose($email)->setTo('user@example.com')->send()`. Setters on the
manager override any values from the `Email` class, and without a custom class you
can build the whole message with fluent setters on the default `Email`. Sending
requires at least `to`, `langcode`, and `key`; a `MailingException` is thrown if a
required property is empty.

Because it delegates to Drupal's `plugin.manager.mail`, your site's **configured
mail plugin still handles actual delivery** — so pairing it with a module like
Symfony Mailer or SwiftMailer gives you HTML email. Multilingual bodies are
supported via per‑language Twig templates (for example `welcome.de.html.twig`) or
`t()`. It is a thin, credential‑free wrapper over core mail, so it introduces **no
network endpoints and no secrets** of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module so other modules can depend on its API.

There is **no configuration page** — Mail composer is a code‑only API with no
settings, routes, permissions, or forms of its own.

## Where it lives in the admin menu

Nowhere — Mail composer adds no admin page. It exposes the `mail_composer.manager`
service and the `Email` class for other modules to use programmatically.

## How to use it

Mail composer is used from PHP in your own modules. The essentials:

1. Install and enable the module (see [Installation](installation/index.md)).
2. In your module, either subclass `Drupal\mail_composer\Email` to define a
   reusable email type (subject, from, and a body — optionally a Twig template
   named after the class), or use the default `Email` and set everything with
   fluent setters.
3. Inject the `mail_composer.manager` service and send:
   `$manager->compose($email)->setTo('user@example.com')->send();`. Provide at
   least `to`, `langcode`, and `key`, and catch `MailingException` for missing
   required fields.
4. For HTML delivery, pair with **Symfony Mailer** / **SwiftMailer**; for
   multilingual mail, provide per‑language Twig templates or localise with `t()`.

See the module's own developer documentation for full usage examples.
