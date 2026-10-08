# Global Node Translation — manual setup guide

**Global Node Translation** (`global_node_translation`) automatically creates
**translations of a node in every enabled language** the moment the node is
created in its original language. Instead of an editor having to add each
translation by hand, every language gets an entry from the start — and the module
uses the **stichoza/google-translate-php** library to fill those translations in
via Google Translate.

Beyond nodes themselves, it also handles **paragraph reference fields**, so nested
paragraph content gets translated along with the node. And it integrates with
**Views Bulk Operations (VBO)** by providing a **Translate Nodes** action, letting
you translate existing nodes in bulk straight from a Views listing.

It builds on core's multilingual stack — **Language** and **Content Translation** —
and needs no modules beyond Drupal core (plus the translation library, which
Composer installs). A couple of practical notes: you choose which languages to
translate into and which content types have automatic translation enabled, and the
translations it produces are machine translations that you may want to review.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose the target languages, make
   content types translatable, and switch on automatic translation per type.

## Where it lives in the admin menu

The module's own settings — where you pick the languages to create translations
for — are reached from its **Configure** link on **Extend**
(**Administration → Extend**). The related core settings live under
**Configuration → Regional and language → Content language and translation**.

## How to use it

1. Enable and configure the module, choosing your target languages (see
   [Configuration](configuration/index.md)).
2. Make the relevant content types and fields translatable in core's content
   language settings.
3. Turn on **Enable Automatic Translate** for each content type you want covered.
4. Create a node in the original language — translations are generated
   automatically in the chosen languages. For existing content, use the **Translate
   Nodes** VBO action from a view.
