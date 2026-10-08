# Name Field — manual setup guide

**Name Field** (`name`) adds a proper "person's name" field type to Drupal.
Instead of squeezing a name into a single text box, it stores a name as six
separate parts — **title** (Mr., Dr.), **given** name, **middle** name, **family**
name, **generational** suffix (Jr., III), and **credentials** (PhD, MD) — and then
renders them through reusable, pattern-based **name formats**. That means you can
capture "Dr. John Peter Smith Jr., PhD" once and display it as a full name in one
place, "Smith, John" in a listing, or just initials in a compact byline — all from
the same stored data.

Because output is driven by named format entities, you change how names appear
site-wide by editing a single format rather than touching every field. The module
ships sensible defaults (full, formal, family, given, and more) and lets you build
your own from a small pattern language. There's also support for author **lists**
("Smith, Jones and Doe", or "Smith et al." past a threshold), and a Name field can
even override a Drupal user's login/display name.

Per field you decide which of the six components are shown, which are required,
their maximum lengths, and whether title/generational are free-text or dropdowns.
The module needs only core's Field module and works on Drupal 10.3+ and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the global settings (separators,
   required marker) and managing name formats.

## Where it lives in the admin menu

- The **name formats** are managed at **Configuration → Regional and language →
  Name formats** (`/admin/config/regional/name`), with the **author-list formats**
  at `/admin/config/regional/name/list`.
- The **global settings** (separators, required marker) sit at
  **Configuration → Regional and language → Name settings**
  (`/admin/config/regional/name/settings`).

## How to use it (adding a name field)

The heart of the module is the field type. To add one:

1. On any fieldable entity — a content type, users, a taxonomy term, a media type,
   a paragraph — go to **Manage fields** and add a new field of type **Name**.
2. On the field's settings, choose which **components** are enabled (all six by
   default), which are **required** (given + family by default), their maximum
   lengths, custom component labels (e.g. "Surname" for family), and whether
   **title** and **generational** are shown as dropdowns with your own option
   lists.
3. On **Manage form display**, the field uses the **Name components** widget, which
   shows one input (or dropdown) per enabled component.
4. On **Manage display**, the field uses the **Name formatter**. Open its settings
   and pick which **name format** to render with (e.g. *Full*, *Formal*,
   *Family*), an optional **list format** for multi-value fields, a markup mode,
   and whether the name links to the entity.

Reuse the same format across many fields, then re-style every one of them at once
by editing that format — see [Configuration](configuration/index.md).
