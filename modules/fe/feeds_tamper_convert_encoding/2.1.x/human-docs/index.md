# Tamper Convert Encoding — manual setup guide

**Tamper Convert Encoding** (`feeds_tamper_convert_encoding`) provides a
[Tamper](https://www.drupal.org/project/tamper) plugin that converts text from one
character encoding to another before the value is saved. It's the tool to reach for
when a source file arrives in, say, ISO-8859-1 or Windows-1252 and needs to become
clean UTF-8 on the way in — the usual cure for "mojibake", the garbled accented
characters you get when text is read in the wrong encoding.

The plugin lets you pick an **input** encoding and an **output** encoding. The
available choices come straight from PHP's `mb_list_encodings()`, so whatever
encodings your PHP build supports are what you'll see in the lists.

A Tamper plugin transforms a single source value as it flows through the import, so
you add this plugin to the specific field whose text needs re-encoding and set the
encodings there — it has no settings page of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Tamper.

There is **no site-wide configuration page** for this module — it has no settings
form of its own. Input and output encodings are chosen per tamper instance on a
Feed type, as described below.

## Where it lives in the admin menu

The plugin adds no admin page of its own. You use it from a Feed type's **Tamper**
tab at **Structure → Feed types** (`/admin/structure/feeds`).

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Create or edit a Feed type and map the source key that carries the mis-encoded
   text to its target field.
3. Open the Feed type's **Tamper** tab, and on that field add the Convert Encoding
   plugin.
4. Choose the **input encoding** (what the source text actually is) and the
   **output encoding** (usually UTF-8).
5. Create a feed of that type and import — the text is converted before it is
   saved.
