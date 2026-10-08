# Block Styles — manual setup guide

**Block Styles** (`block_styles`) lets you restyle any placed block — swap its
wrapper template and add CSS classes — right from the block's own configuration
form, without writing a custom theme hook or preprocess function. It adds a **Block
Styles Template** section to every block form where you pick a registered *style*,
optionally set a button label, and type in extra CSS classes for the block's
wrapper.

A "style" is an alternate `block--*.html.twig` template registered through the
**Styles API**. The module ships one to get you started — **Clean Wrapper**, which
strips a block down to minimal markup — and its **Block Styles Bootstrap** submodule
adds ready-made card, collapse, dropdown, modal, and popover styles. So you can, for
example, turn a block into a Bootstrap card, present a newsletter block inside a
modal triggered by a labelled button, or simply add utility classes like
`bg-light p-3` to one block's wrapper — all per block, per placement.

Everything you choose is saved as its own exportable config entity keyed to the
block, so block markup changes live in configuration and deploy cleanly across
environments rather than being buried in preprocess code. There is **no central
settings page**; you configure each block on its own form. Developers can register
their own styles by shipping a `*.themes.yml` entry plus a Twig template — no PHP
required.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — the config entity shape, the
render hooks, and how to register a style — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its Styles API dependency, and the optional Bootstrap submodule.
2. [Configuration](configuration/index.md) — apply a style and CSS classes to a
   block from its configuration form.

## Where it lives in the admin menu

Block Styles has **no settings page of its own**. You use it inside each block's
configuration form — for example via **Structure → Block layout**
(`/admin/structure/block`), by configuring any placed block and opening the **Block
Styles Template** section.

## How to use it

Enable the module, then edit any placed block, open the **Block Styles Template**
fieldset, choose a style (such as Clean Wrapper or one of the Bootstrap styles), add
any CSS classes you want on the wrapper, and save. The block re-renders through the
chosen template with your classes applied. See [Configuration](configuration/index.md)
for the walkthrough.
