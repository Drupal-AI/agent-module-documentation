# Hijri Format — manual setup guide

**Hijri Format** (`hijri_format`) displays dates on your site in the **Hijri
(Islamic lunar) calendar**. It adds Hijri display formats for the *created* and
*changed* fields on **Nodes** and **Comments**, and for **Date fields** on any
entity type. The underlying stored date value never changes — only how it is
*presented* to the visitor — so it's a safe, display‑only addition for sites
serving audiences that use the Hijri calendar.

A few things make it flexible. You're not limited to a fixed list of formats:
you can **build your own** Hijri date format. You can **adjust the date to match
Umm al‑Qura**, the official calendar of the Kingdom of Saudi Arabia. It offers
**multilingual** output without relying on a third‑party translation library, and
an option to render the date using **Indian (Arabic‑Indic) numerals**. It also
provides a **current‑date block** you can place anywhere, showing today's date in
a custom Hijri format.

The module has no dependencies beyond Drupal core, runs on Drupal 10 and 11, and
provides its own permissions. Its settings live at a dedicated configuration form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the Hijri settings form (custom
   format, Umm al‑Qura adjustment, Indian numerals) and how to apply Hijri
   display to a field.

## Where it lives in the admin menu

Hijri Format's settings form is provided as `hijri_format.hijri_settings`, in the
**Configuration** area (the module sits in the *Fields* package). You apply the
Hijri format to individual date fields on each bundle's **Manage display** tab.
See [Configuration](configuration/index.md).
