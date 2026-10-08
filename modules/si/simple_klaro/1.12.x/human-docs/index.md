# Simple Klaro — manual setup guide

**Simple Klaro** (`simple_klaro`) brings the open‑source **Klaro** consent manager
to Drupal, giving your visitors a cookie/consent dialog that holds back third‑party
scripts until they opt in. Klaro's model is to neutralise a tracking script — moving
its `src` to `data-src` and changing its type from `text/plain` to
`application/javascript` — so the script only runs once the visitor accepts that
particular service. This is a practical way to meet an EU cookie‑consent obligation
while keeping analytics, pixels, and embeds working for those who consent.

The module is deliberately minimal — that is the "Simple" in the name. Rather than a
feature‑rich configuration UI, it gives you a **single settings form** where you edit
Klaro's configuration (its services, their purposes, all the on‑screen texts, styling
choices, and translations). Because that configuration lives in Drupal config, you
can change the consent setup without deploying new code, and when you save it, all
caches are cleared and the new settings apply across every page. If you need a more
elaborate UI with deeper integrations, the project page points to a more complex
alternative module.

Once enabled, the consent manager **appears automatically on all pages** — there is
no block you must place to get the dialog itself. You can serve it with the default
styling or without styling so you can match your own design. A **block** is provided
that renders a link to re‑open the consent dialog after settings are saved; in fact
any element with the id `klaro-preferences` (for example a "Cookie preferences" link
in your footer) will open the dialog, so you can build a custom trigger easily. When
consent is revoked, cookies can be deleted using regular expressions, and beyond the
type‑switching mechanism you can invoke custom callback functions.

A couple of details worth knowing: the Klaro JavaScript library is installed locally
(as `kiprotect/klaro`, pinned to **v0.7.22**) rather than pulled from a CDN, so no
third‑party host is contacted for the library. And the module includes a small
security control — a `sanitize.js` script that forces any `data-href` link in a
consent notice to `#` unless it uses an `http:` or `https:` scheme, so a
`javascript:` URL configured into a notice cannot execute.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the Klaro library and the module,
   then enable it.
2. [Configuration](configuration/index.md) — the settings form, its permissions, and
   how to add a "Cookie preferences" trigger.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Simple Klaro**
(`/admin/config/system/simple-klaro`), behind the *administer simple klaro*
permission.
