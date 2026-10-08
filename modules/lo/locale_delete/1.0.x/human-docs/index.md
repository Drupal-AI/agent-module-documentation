# Locale delete — manual setup guide

**Locale delete** (`locale_delete`) fills a small but real gap in Drupal's
interface‑translation tools. Core lets you *edit* an interface‑translation string
(a UI string and its translations) on the **Translate interface** screen, but it
gives you no way to **permanently remove** one. This module adds that missing
delete action: a confirmation form that deletes a source string and all of its
translations from the database in one step.

Concretely, it adds a route at
`/admin/config/regional/translate/delete/{lid}` (where `{lid}` is the string's
locale ID). Confirming on that page removes the row from the `locales_source`
table and every matching row from `locales_target`, writes a log entry, and
returns you to the core Translate page. It works on **one string at a time** —
there is no bulk delete UI.

Because this is a destructive action, it is properly gated: it uses a dedicated
permission (`use locale delete`), the standard confirm‑form step (with its CSRF
protection and an explicit confirmation), and parameterised database queries.
Grant the permission only to translation administrators you trust.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the delete permission.

There is **no settings form** for this module — it adds a single delete
confirmation route rather than a configuration page.

## Where it lives in the admin menu

Locale delete has no settings page. It plugs into the core interface‑translation
area at **Configuration → Regional and language → User interface translation →
Translate**. You reach a string's delete confirmation directly at
`/admin/config/regional/translate/delete/{lid}`, or by linking to that route by
`lid` from your own translation listing.

## How to use it

1. Grant **Use locale delete** to the roles that should be allowed to remove
   translation strings (see the [Installation](installation/index.md) page).
2. Find the locale ID (`lid`) of the string you want to remove — for example from
   a custom listing you maintain — and visit
   `/admin/config/regional/translate/delete/{lid}`.
3. The confirmation page shows the source text so you can be sure you have the
   right string. Confirm to delete the source and all its translations; you are
   returned to the Translate page with a status message, and the deletion is
   logged.

This is handy for cleaning up stale or wrong source strings left behind after a
module or feature is removed.
