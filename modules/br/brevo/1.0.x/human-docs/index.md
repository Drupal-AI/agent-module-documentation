# Brevo — manual setup guide

**Brevo** (`brevo`) connects your Drupal site to
[Brevo](https://www.brevo.com/) — the CRM and transactional-email platform
formerly known as **Sendinblue**. It uses Brevo's official PHP SDK
(`getbrevo/brevo-php`) to talk to Brevo's API, so once you paste in an API key
your site can send transactional email, manage contacts and lists, fire SMS or
WhatsApp messages, and load Brevo's marketing-automation tracking script.

The base module gives you three things: a **settings form** where you enter and
validate your API key, a **client factory** that hands any Brevo API client to
custom code, and a **Webform handler** that can send a form submission through a
Brevo transactional template. Two optional submodules build on it — **Brevo
Mailer** (`brevo_mailer`) routes all of Drupal's outgoing mail through Brevo, and
**Brevo Commerce** (`brevo_commerce`) adds a newsletter-list opt-in checkbox to a
Drupal Commerce checkout.

A key detail: Brevo sends mail **via the Brevo API**, not through your server's
local mail transport. The API key is the one secret you must supply. It is stored
in configuration, but you should keep the real value out of version control and
inject it from an environment variable instead (see
[Configuration](configuration/index.md)).

This guide is written for a **human** clicking through the admin UI. If you want a
terse, token-cheap reference for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the SDK and module with
   Composer, enable it, and pick the submodules you need.
2. [Configuration](configuration/index.md) — connect your Brevo account with an
   API key, the settings field by field, and how to keep the key in an environment
   variable.

## Where it lives in the admin menu

The settings form sits at **Configuration → Web services → Brevo → Settings**
(`/admin/config/services/brevo/settings`). It is gated by the **Administer Brevo**
(`administer brevo`) permission. The same permission also controls the Brevo Mailer
settings and test forms if you enable that submodule.
