# Custom Configuration — manual setup guide

**Custom Configuration** (`custom_configuration`) gives you a place to store an
unlimited number of small configuration values — keyed by **machine name**, and
optionally varied by **language** and **domain**. Think of the settings you'd
otherwise scatter across `settings.php` or one‑off config forms: a Facebook app ID,
a Google Auth key, a support phone number, a feature toggle. Here they live in one
managed list, each retrievable by its machine name, and each able to hold a
different value per language and per domain.

The value comes into its own on **multi‑domain, multi‑site, and multilingual**
builds, where the same logical setting needs a different value depending on the
current domain or language. You store the variants once and the module returns the
right one for the active context. Each entry can also be flagged **Active** or
**Inactive** — an inactive entry returns `null` when accessed, so you can switch a
value off without deleting it. Entries can carry a set of optional extra values
alongside the primary one, and everything is read back through a service in code.

Developers read values with the module's service — for example
`\Drupal::service('custom.configuration')->getValue('mobile')` returns the value for
the current language and domain, and `getValues('mobile')` returns the full record
including its optional values. Accessing a machine name that doesn't exist (or that
is inactive) returns `null`. One important caveat: this is **configuration, not a
secret store** — don't put passwords, private API secrets, or tokens in it. Use a
Key entity or an environment variable for real secrets.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create and manage configuration
   entries, field by field.

## Where it lives in the admin menu

Once enabled, the configuration list sits at **Administration → Configuration →
System → Custom Configuration** (route `custom_configuration.configuration_list`).
That's where you add, edit, activate, and deactivate your configuration entries.
