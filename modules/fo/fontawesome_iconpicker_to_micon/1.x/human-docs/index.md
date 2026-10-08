# Fontawesome Iconpicker to Micon Converter — manual setup guide

**Fontawesome Iconpicker to Micon Converter** (`fontawesome_iconpicker_to_micon`)
is a **one-time migration utility** for developers. It converts all of a site's
fields that use the *FontAwesome Iconpicker* formatter into
[Micon](https://www.drupal.org/project/micon) Symbol fields, so you can move your
iconography from the old, unmaintained FontAwesome Iconpicker module to the
well-maintained Micon icon system.

> **Developers only — take a backup first.** This module changes field types on
> your site. Back up before running it and review the changes carefully afterwards.

The reason a simple switch isn't possible on its own is that FontAwesome Iconpicker
is a *formatter* applied to plain Text (string) fields, while Micon uses its **own
field type**. Because both store data the same way, the conversion is
straightforward — only the field type needs to change — and this module does
exactly that across all matching fields, preserving the icon choices. After
running it, you can review the resulting configuration changes with
`drush config:export --diff` before committing them.

This is a run-once helper, not a feature you leave enabled long-term. It depends on
both `fontawesome_iconpicker` and `micon`, and it is gated by its own permission so
only trusted users can trigger the conversion.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it
   alongside FontAwesome Iconpicker and Micon, run the conversion once, then
   remove it.

There is **no configuration page** for this module — it has no settings form. It
performs a single conversion action gated by a permission, described in
Installation.

## Where it lives in the admin menu

The module exposes a conversion action gated by the **`convert fontawesome
iconpicker to micon fields`** permission. It has no ongoing settings page — its
whole purpose is to run the conversion once.

## How to use it

1. **Back up** your database and configuration.
2. Make sure both FontAwesome Iconpicker and Micon are enabled.
3. Grant yourself the `convert fontawesome iconpicker to micon fields` permission.
4. Trigger the conversion. It converts every FontAwesome Iconpicker field to a
   Micon Symbol field, preserving the stored icon values.
5. Review the changes carefully — `drush config:export --diff` is a good way to
   inspect exactly what changed — then commit them.
6. Once you're satisfied, you can uninstall this utility module; it has done its
   job.
