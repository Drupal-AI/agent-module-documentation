# Cyrillic to Latin — manual setup guide

**Cyrillic to Latin** (`cyrillic_to_latin`) converts Serbian text from the
**Cyrillic** script to the **Latin** script at display time, so a single set of
content can serve readers of both alphabets. It works on strings passed through
Drupal's `t()` function and on string/text field values, and — if you use the
Address module — it also converts country names to Latin.

Serbian is the clearest living case of **digraphia**: the same language,
officially written in two alphabets, with a one‑to‑one mapping between them.
Because that mapping is mechanical, converting at display time loses nothing and
needs no editorial review — you keep your content single‑sourced instead of
storing and editing everything twice. Cyrillic is constitutionally the official
script and predominates in institutional contexts; Latin predominates online and
among younger readers, so a site that offers both is convenient to its whole
audience.

The module converts in **one direction only, and deliberately so.** Cyrillic → Latin
is unambiguous; the reverse is not, because Latin digraphs (`nj`, `lj`, `dž`) each
map to a single Cyrillic letter, and a word like *nadživeti* contains a `dž`
sequence that is not the letter. So this module automates the safe direction. It
depends on core's **Locale** module and is turned on or off from its own small
settings form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — turn string conversion on or off.

## Where it lives in the admin menu

The settings form sits at **Configuration → Regional and language → Cyrillic to
Latin** (`/admin/config/regional/cyrillic-to-latin`), backed by the
`cyrillic_to_latin.admin_settings` route.

## Two things worth planning for

- **Proper nouns and foreign words usually should not be converted** — a brand
  name or a URL written in Latin inside Cyrillic text is meant to stay as it is.
- **The converted variant is a rendering, not a separate page.** Don't let it
  produce a second indexable URL for the same content without an `hreflang` or a
  canonical link, or the site competes with itself in search results.
