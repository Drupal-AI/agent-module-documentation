# Termcase — manual setup guide

**Termcase** (`termcase`) lets site administrators enforce a consistent
text‑case convention on the names of taxonomy terms within a vocabulary. Set a
vocabulary to lowercase, and every term saved in it becomes lowercase; set it to
proper case, and every term is title‑cased — regardless of how the editor typed
it.

The problem it solves is the slow drift of inconsistent casing. When several
editors add terms, or when terms arrive through imports and migrations, you end up
with "News", "news", and "NEWS" all in the same vocabulary. Termcase prevents that
by re‑casing each term name to the vocabulary's chosen convention the moment it is
saved. It offers five modes: **No formatting**, **Ucfirst** (capitalise the first
character), **Lowercase**, **Uppercase**, and **Propercase** (capitalise the first
letter of each word). The conversion is multibyte‑safe, so accented and non‑Latin
characters are handled correctly.

You choose the mode **per vocabulary**, on that vocabulary's own edit form, so
different vocabularies can follow different rules. Existing terms are not touched
automatically, but the same form offers a checkbox to convert all existing terms
in one batch, and the module ships a Drush command to do the same from the command
line. Developers can also hook in their own extra formatting via
`hook_termcase_convert_string_alter`, applied on top of the built‑in conversion.

Termcase works entirely through the standard core vocabulary and term forms — it
adds **no routes, services, or public endpoints of its own**, and it relies on the
usual taxonomy administration permissions, so there is no new access surface. It
depends on core **Taxonomy**, supports **Drupal 8.8 through 11**, and ships no
submodules. There is nothing global to configure — the settings live on each
vocabulary.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the case convention per
   vocabulary and convert existing terms.

## Where it lives in the admin menu

Termcase has no settings page of its own. Its **Term case settings** appear as a
fieldset on each vocabulary's edit form under **Structure → Taxonomy →
*(vocabulary)* → Edit**
(`/admin/structure/taxonomy/manage/{vocabulary}`).
