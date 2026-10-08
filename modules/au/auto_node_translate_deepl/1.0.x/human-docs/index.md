# Auto Node Translate Deepl — manual setup guide

**Auto Node Translate Deepl** (`auto_node_translate_deepl`) is a translation
**backend** for the [Auto Node Translate](https://www.drupal.org/project/auto_node_translate)
module. Auto Node Translate gives editors a button to machine-translate a node's
fields into another language; this add-on makes **DeepL** the engine that does the
translating, using DeepL's official PHP library. If you already use Auto Node
Translate and want DeepL's high-quality neural translation for your European
languages, this is the piece that connects the two.

It preserves HTML markup in rich-text fields during translation, so formatted
body content survives the round trip. You can optionally apply a **DeepL
glossary** to enforce consistent terminology, and you can map each Drupal language
to a specific DeepL language code — handy for DeepL's variant codes like `PT-PT`
versus `PT-BR`, or for mapping source and target languages separately where DeepL
treats them differently. Where a Drupal language has no explicit mapping, the
module simply passes the language code straight through to DeepL.

Setup is short: install it, enter your DeepL API key on a small settings page,
and (optionally) set up the per-language mapping and a glossary. Everything about
*when* and *which* nodes get translated is still controlled by the parent Auto
Node Translate module — this add-on only supplies the DeepL connection.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   DeepL PHP library and Auto Node Translate) and enable the module.
2. [Configuration](configuration/index.md) — enter your DeepL API key, set an
   optional glossary, and map Drupal languages to DeepL codes.

## Where it lives in the admin menu

The module adds two forms under **Configuration → Regional and language**:

- **DeepL settings** (`/admin/config/regional/deepl`) — your DeepL API key and an
  optional glossary id.
- **DeepL language mapping** (`/admin/config/regional/deepl/mapping`) — maps each
  Drupal language to a DeepL source and target code.

Both are gated by the standard **Administer site configuration** permission.
