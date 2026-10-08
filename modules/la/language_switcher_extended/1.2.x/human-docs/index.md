# Language Switcher Extended — manual setup guide

**Language Switcher Extended** (`language_switcher_extended`) improves Drupal
core's **Language Switcher** block. On a multilingual site, the core switcher
happily shows a link for every language — including languages the page you're
looking at hasn't been translated into, which sends visitors to empty or
fallback pages. This module adds smarter processing so those dead links can be
hidden, redirected to the language's front page, or shown as plain, un-clickable
text instead.

It does not add a block of its own — you still place core's Language Switcher
block as usual. What this module adds is a single settings form that changes how
that block's links are rendered. A top-level **mode** chooses the overall
behaviour: leave core untouched, make every switcher item point at its language's
front page, or inspect the current content entity and handle the languages it
isn't translated into. In that last mode you pick what happens to a
missing-translation link — remove it, repoint it to the front page, or render the
language name as un-clickable text with a CSS class you can style.

Further options refine the behaviour: decide whether a translation "counts" only
when it's published or whenever the user can view it; hide the whole switcher (or
just its links) when only one language would remain; control how the link to the
language you're *currently* viewing is shown; and display short language codes
(EN, FR, DE) instead of full names.

All of this is exportable configuration, so you can set it once and deploy it
across environments — no custom `hook_language_switch_links_alter()` needed. It
depends on core's Block and Language modules (and, in practice, Content
Translation so there are translations to detect).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose a mode and fine-tune how the
   switcher's links behave.

## Where it lives in the admin menu

The settings form is at **Configuration → Regional and language → Language
Switcher Extended**
(`/admin/config/regional/language/language-switcher-extended`).

## How to use it

1. Make sure your site is multilingual and you've placed core's **Language
   Switcher** block at **Structure → Block layout**.
2. Open the Language Switcher Extended settings form and choose a mode.
3. Save — the changes take effect on the existing switcher block; no theme
   changes required.

See [Configuration](configuration/index.md) for each option.
