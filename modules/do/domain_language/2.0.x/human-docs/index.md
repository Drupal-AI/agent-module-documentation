# Domain Language — manual setup guide

**Domain Language** (`domain_language`) lets a multilingual site running
**Domain Access** give each domain its own language rules. On a normal Domain
Access setup every domain shares the site's default language and every enabled
language. With this module you can, per domain, choose a **default language** and
restrict which languages that domain offers — so your `.fr` domain can default to
French and only expose French and German, while the main site keeps all
languages.

It works entirely through Drupal's configuration override system — there are no
new content types or database tables. Saving the per-domain form writes two small
config objects, and three mechanisms then enforce your choice: a config overrider
rewrites language negotiation for the active domain, a swapped "default language"
service resolves the right default per domain, and the language switcher block is
filtered so disallowed languages disappear from it.

The module adds one permission, **Bypass language restrictions**, for users
(such as a maintenance role) who should always see every language on every domain.

> **Important compatibility note.** The documented release (2.0.0-alpha2) ships a
> services definition bug that makes the site fatal on Drupal 11.4.4 as-is:
> enabling the module errors out during container build because the overrider
> service is passed the wrong arguments. Everything in this guide describes the
> intended behavior, but you should confirm the module works on your Drupal
> version (or apply the upstream fix to its `domain_language.services.yml`) before
> relying on it in production. See the [`agent/`](../agent/start.md) docs for the
> exact TypeError and recovery steps.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Domain Access and core Language.
2. [Configuration](configuration/index.md) — the per-domain Languages form, the
   Bypass permission, and how to drive it from the command line.

## Where it lives in the admin menu

Domain Language does not add a top-level settings page. Its form is reached as a
**row operation on the domain list**: go to **Configuration → Domains**
(`/admin/config/domain`) and click the **Languages** operation next to a domain
(direct path `/admin/config/domain/language/{domain}/edit`). That form is gated by
Domain Access's own **Administer domains** permission.
