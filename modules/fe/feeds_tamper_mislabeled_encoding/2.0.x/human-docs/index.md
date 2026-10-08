# Feeds Tamper Mislabeled Encoding — manual setup guide

**Feeds Tamper Mislabeled Encoding** (`feeds_tamper_mislabeled_encoding`) provides
a [Tamper](https://www.drupal.org/project/tamper) plugin that fixes a very specific
encoding mess during a Feeds import: source strings that are *labeled* ISO-8859-1
but actually contain Windows-1252 characters in the `0x80`–`0x9f` byte range, which
have then been UTF-8-encoded. The result is the classic garbled "mojibake" you see
when smart quotes, dashes, and similar Windows-1252 punctuation come through wrong.
This tamper repairs those characters so the text stores cleanly.

Its tested use case is importing an ISO-8859-1 JSON feed that carries a sprinkling
of Windows-1252 characters. It's a targeted fix — if your whole file is simply in
the wrong encoding, the more general **Tamper Convert Encoding** plugin may be a
better fit.

A Tamper plugin transforms one source value as it flows through the import, so you
add this plugin to the specific field whose text is affected — it has no settings
page of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Tamper and Feeds Tamper.

There is **no site-wide configuration page** for this module — it has no settings
form of its own. The plugin is added as a tamper instance on a Feed type, as
described below.

## Where it lives in the admin menu

The plugin adds no admin page of its own. You use it from a Feed type's **Tamper**
tab at **Structure → Feed types** (`/admin/structure/feeds`).

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Create or edit a Feed type and map the affected source key to its target field.
3. Open the Feed type's **Tamper** tab, and on that field add the Mislabeled
   Encoding plugin.
4. Create a feed of that type and import — the mislabeled Windows-1252 characters
   are repaired before the value is saved.
