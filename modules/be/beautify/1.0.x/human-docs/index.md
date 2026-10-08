# Beautify — manual setup guide

**Beautify** (`beautify`) pretty-prints the HTML that Drupal sends to the browser.
Drupal's rendered markup is often minified or inconsistently indented; Beautify
runs the finished page through a formatter so the delivered source is cleanly and
consistently indented. It only changes whitespace and layout of the markup — never
its meaning — so it is a developer and output-quality aid, most useful when you
want readable, diffable page source while debugging front-end work.

The formatting is done by a selectable **beautifier plugin**. Two come bundled:
**HTMLBeautify**, a pure-PHP formatter that needs nothing extra, and **Tidy**,
which uses PHP's `tidy` extension (so that extension must be installed to use it).
You choose which one is active, and set its options, on the module's settings
form. Developers can add their own beautifier by implementing the module's
`Beautifier` plugin type.

One practical note: beautification runs on **every matched response**, so it adds
a small amount of processing to each page. That is fine in development but worth
weighing before enabling it on a busy production site — the benefit there is
mostly cosmetic.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the plugin and
subscriber class names — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose the active beautifier and set
   its options.

## Where it lives in the admin menu

Once enabled, Beautify's settings form sits at **Configuration → Development →
Beautifier** (`/admin/config/development/beautifier`). Access is gated by the
module's permission — note the upstream typo, the permission string is literally
`admninister beautifiers`.
