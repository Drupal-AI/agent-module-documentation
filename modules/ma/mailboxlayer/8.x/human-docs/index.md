# Mailbox Layer Integration — manual setup guide

**Mailbox Layer Integration** (`mailboxlayer`) checks the email addresses people
type into your **Webform** email fields against the
[mailboxlayer](https://mailboxlayer.com/) email-verification API before the form
is submitted. That lets you catch typos, non-existent domains, disposable
throwaway addresses, and undeliverable mailboxes at the point of entry, so you
collect fewer fake or invalid email addresses.

The integration is opt-in per field: once the module is enabled, every email field
in a webform gains a checkbox. Tick it, save the webform, and that field is
validated through mailboxlayer. To keep your API usage down, the module **caches**
each address's result in the database so it doesn't call the API twice for the
same address, and it automatically purges those stored responses after a
configurable number of days (one day by default).

Mailbox Layer Integration depends on the **Webform** module and supports Drupal 8
through 11. Using it means sending the email addresses your visitors enter to a
third-party service (mailboxlayer) and holding an **API key** — both of which have
handling implications covered in [Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (Webform is required).
2. [Configuration](configuration/index.md) — set your mailboxlayer API key
   securely, tune the cache retention, and turn validation on for specific fields.

## Where it lives in the admin menu

The module's settings page is at **Configuration → Mailbox Layer**
(`/admin/config/mailboxlayer`), where you set the API key and the cache retention
period. The per-field "validate with mailboxlayer" checkbox appears on each email
field inside the **webform build** UI. See
[Configuration](configuration/index.md) for both.
