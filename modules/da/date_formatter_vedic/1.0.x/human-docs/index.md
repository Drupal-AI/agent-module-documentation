# Vedic Date Formatter — manual setup guide

**Vedic Date Formatter** (`date_formatter_vedic`) extends Drupal's date formatting
with a custom format character that outputs the current **muhūrta** — a 48‑minute
Vedic time division, of which 30 span a full day, calculated with reference to
sunrise and timezone. Pick a character (the default is `q`), drop it into any
Drupal date format string, and wherever that format is rendered the character is
replaced with the appropriate muhūrta name. For example, a format like
`jS F Y, g:i a (Muhurta: q)` renders as `23rd April 2025, 10:30 am (Muhurta:
Surya)`.

The clever part is *where* this works. The module decorates Drupal's core
`date.formatter` service, so the muhūrta character is available everywhere the core
date formatter is used — Date field formatters, Views date columns, and any code
that calls the date formatter service — with no per‑field setup. You add Vedic
timekeeping context to timestamps site‑wide just by including the character in a
format string.

It has no module dependencies, requires **Drupal 11** and **PHP 8.1+**, and its
only administrative surface is a single settings form where you choose the
replacement character and, if you wish, override the names of the 30 muhūrtas
(the form is language‑aware, so names can differ per site language). There are no
anonymous or content‑changing endpoints and no external calls.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose the format character and
   override the muhūrta names.

## Where it lives in the admin menu

The settings form sits at **Configuration → Regional and language → Vedic Date
Formatter** (`/admin/config/regional/vedic-date-formatter`), reachable by users
with the **Administer site configuration** permission.

## How to use it

Once enabled and configured, simply include your chosen character in any Drupal
date format string, for example:

```
jS F Y, g:i a (Muhurta: q)
```

This works anywhere Drupal formats a date — in a Date field's display formatter,
in a Views date field, or in custom code that formats a timestamp. Just be sure to
pick a character that doesn't clash with a standard PHP date character you rely on
(see [Configuration](configuration/index.md)).
