# Localization quick links — manual setup guide

**Localization quick links** (`l10n_quick_links`) is an on‑page helper that speeds
up interface and configuration translation. As you browse a page, the module
quietly records the translatable strings and entity fields that were rendered
while building it. A **Translate page** button in the toolbar then reveals a small
widget at the bottom of the viewport with a quick search box, where every recorded
string is a link that jumps you straight to its translation form — either the
locale interface‑translation UI for the selected string, or the list of
translations for the selected field.

The idea is to stop translators hunting through the general translate interface for
the exact string they just saw on screen. It doesn't change or store any strings
itself; it simply surfaces the right translation form for whatever is in front of
you. The project was inspired by the older Localization client and built to fill
that gap for modern Drupal.

It depends on core's **Interface Translation** (`locale`) and **Toolbar**
(`toolbar`) modules, and lives in the Multilingual package. Two permissions govern
it: **Administer languages** controls who can reach the settings form, and a
dedicated **use localization quick links ui** permission controls who can toggle
the on‑page widget.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside its Locale and Toolbar dependencies.
2. [Configuration](configuration/index.md) — the settings form for disabling the
   widget on certain pages and tuning which entity fields are tracked.

## Where it lives in the admin menu

The settings form sits at **Configuration → Regional and language → User interface
translation → Localization quick links**
(`/admin/config/regional/translate/l10n-quick-links`).

## How to use it

1. Grant the **use localization quick links ui** permission to the roles whose
   members translate content.
2. As one of those users, browse to any page you want to translate and click
   **Translate page** in the toolbar. The quick‑links widget appears at the bottom
   of the screen.
3. Use the search box to find a string or field you saw on the page, then click it
   to open its translation form directly. Translate, save, and return.
