# Drupal Symfony Mailer Lite — manual setup guide

**Drupal Symfony Mailer Lite** (`symfony_mailer_lite`) lets your Drupal site send
proper HTML‑formatted emails — and emails with attachments — using the modern
Symfony Mailer library. It is designed as a drop‑in successor to the deprecated
Swiftmailer module, deliberately mirroring Swiftmailer's approach so existing sites
can switch with minimal changes.

The module registers a Mail plugin that you assign — through the required **Mail
System** module — as the formatter and/or sender, either sitewide or for specific
modules and mail keys. Outgoing mail is delivered through configurable
**transport** entities: Native (php.ini sendmail), SMTP, Sendmail, Null (for
development), and a raw DSN transport. Along the way it converts render arrays and
HTML into well‑formed messages, inlines CSS so your styles survive in mail clients,
generates a plain‑text alternative automatically, and can embed images. A Twig
template controls the HTML wrapper, with per‑module and per‑key theme suggestions,
and a built‑in test form lets you fire off a sample email to check everything
works.

If you need a larger templating and API system, the separate full "Symfony Mailer"
project is the heavier sibling; this "Lite" version keeps things close to
Swiftmailer's familiar model.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (note the Mail
   System and library requirements) and enable the module.
2. [Configuration](configuration/index.md) — assign the mailer, set up transports,
   message settings, and the test form.

## Where it lives in the admin menu

Transports are managed at **Configuration → System → Symfony Mailer Lite**
(`/admin/config/system/symfony-mailer-lite/transport`), with a message‑settings
form and a test‑email form alongside. Crucially, the module only *starts sending*
once you select it in the **Mail System** UI at **Configuration → System → Mail
System** (`/admin/config/system/mailsystem`).

## How to use it

The essential flow is: install, tell Drupal to use it, then configure how mail
goes out.

1. **Assign the mailer** in Mail System — set Symfony Mailer Lite as the default
   *Formatter* and/or *Sender* (sitewide, or just for certain modules/keys). Until
   you do this, it sends nothing. See [Configuration](configuration/index.md).
2. **Choose a transport** — a `native` transport is installed by default; add an
   SMTP, Sendmail, Null, or DSN transport and pick the default that fits your
   environment.
3. **Send a test email** from the built‑in test form to confirm mail is flowing.

Developers can add a custom transport type with a transport plugin, and customize
the email HTML wrapper via the `symfony-mailer-lite-email.html.twig` template with
theme suggestions — see the [`agent/`](../agent/start.md) docs.
