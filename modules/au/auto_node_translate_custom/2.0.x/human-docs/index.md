# ANT Custom Translations — manual setup guide

**ANT Custom Translations** (`auto_node_translate_custom`) extends the Auto Node
Translate module with a spreadsheet-driven dictionary of custom translation
overrides. Machine translation is convenient but inconsistent on the terms that
matter most to you — brand names, product names, and glossary phrases. This
module lets you lock those down: you upload a spreadsheet of source → target
pairs, and Auto Node Translate uses your fixed translations for those terms
instead of whatever the machine-translation provider would produce.

It is a small, admin-only configuration submodule. It adds one settings form,
one permission, and stores your overrides in configuration. It has no anonymous
or content-mutating public endpoints, and it requires the parent
`auto_node_translate` module to do anything.

The uploaded file is parsed with the PhpSpreadsheet library and its rows become
your override dictionary. To update the dictionary later, you re-upload a revised
spreadsheet.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and confirm its dependencies.
2. [Configuration](configuration/index.md) — the admin form where you upload
   your spreadsheet of translation overrides.

## Where it lives in the admin menu

The module adds one admin form at **`/admin/config/system/custom-translations`**
(under Configuration → System). It is protected by the
**`configure auto node translate custom`** permission, which is marked "restrict
access", so grant it only to trusted administrators.

## How to use it

1. Install and enable this module alongside Auto Node Translate (see
   [Installation](installation/index.md)).
2. Prepare a spreadsheet of source → target translation pairs for the terms you
   want to control.
3. Open **`/admin/config/system/custom-translations`** and upload the
   spreadsheet (see [Configuration](configuration/index.md) for the details).
4. When Auto Node Translate next translates node content, your listed terms are
   rendered exactly as specified in the spreadsheet.
