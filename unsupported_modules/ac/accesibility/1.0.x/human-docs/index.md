# Accesibilidad. Ticsmart — manual setup guide

**Accesibilidad. Ticsmart** (machine name `accesibility`) is a Spanish-language
accessibility helper. Once enabled it loads a small JavaScript/CSS widget on every
non-admin page, giving visitors two front-end toggles: a **night mode** (a
high-contrast dark view) and a **simplified navigation** reading mode.

It is a purely presentational front-end enhancement. It collects no data, adds no
permissions of its own, and exposes nothing beyond a single admin settings form.
The widget appears on your content pages but is deliberately kept off the
`/admin/*` admin pages.

There is one naming quirk worth flagging up front: the project (and Composer
package) is called **`accesibilidad`**, but the actual Drupal machine name is
**`accesibility`**. That means you install it with `composer require
drupal/accesibilidad` but enable it with `drush en accesibility` — the two names
are genuinely different, which is easy to trip over.

This guide is written for a **human** setting the module up through the admin UI.
If you want the terse, token-cheap reference written for an AI coding agent, read
the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (mind the name difference).
2. [Configuration](configuration/index.md) — the one settings form and its two
   message fields.

## Where it lives in the admin menu

The module's only settings form sits at **Configuration → Accesibilidad**
(`/admin/config/accesibility/adminsettings`), reachable by anyone with the
**Access administration pages** permission. Everything else — the actual widget —
is delivered automatically on the front end.
