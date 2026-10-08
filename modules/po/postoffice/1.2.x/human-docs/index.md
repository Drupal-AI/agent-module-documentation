# Postoffice — manual setup guide

**Postoffice** (`postoffice`) is a small, developer‑facing API for sending **themed emails**
through **Symfony Mailer**. Instead of core's mail manager, your code builds a Symfony email and
hands it to Postoffice's mailer service, which runs the message through a tidy middleware
pipeline before the configured transport sends it. Along the way it renders the body in a
dedicated **mail theme**, switches to an anonymous account so mail rendering can't accidentally
leak the current user's access‑controlled content, and switches to the recipient's language for
localised output.

The transport itself is driven by a single **DSN** (connection string), so any Symfony Mailer
transport works — SMTP, sendmail, the native transport, or a third‑party bridge. This is a
code‑first module: it has one admin settings form and no public or mutating web endpoints.

A family of optional extension submodules layers on extras — routing core's user and contact
emails through Postoffice, wrapping HTML mail in a full document, generating a plain‑text part,
inlining CSS, and adding Twig helpers for subjects, embedded images, and file attachments.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable it, and
   pick the extension submodules you need.
2. [Configuration](configuration/index.md) — the settings form (transport DSN and mail theme),
   field by field.

## Where it lives in the admin menu

Postoffice's settings form is at **Configuration → System → Postoffice settings**
(`/admin/config/system/postoffice`), protected by the **Administer postoffice configuration**
permission.

## How to use it

Postoffice is aimed at developers. Once the transport DSN and mail theme are set (see
[Configuration](configuration/index.md)), send a themed email from custom code by building a
Symfony email and passing it to the `postoffice.mailer` service:

```php
use Symfony\Component\Mime\Email;

$email = (new Email())
  ->to('to@example.com')
  ->subject('Hello')
  ->html('<p>Themed body</p>');

\Drupal::service('postoffice.mailer')->send($email);
```

For richer, template‑driven messages, implement Postoffice's email interfaces/traits (under
`src/Email/`) on a message class; bodies are then rendered from Twig by the module's themed body
renderer. You can also add your own middleware by defining a service tagged
`postoffice.mailer_middleware`. If you'd rather manage mail from the UI than from code, the
project page suggests the Symfony Mailer module as an alternative.
