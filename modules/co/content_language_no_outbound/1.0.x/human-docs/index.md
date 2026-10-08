# Content language detection (no outbound) — manual setup guide

**Content language detection (no outbound)** (`content_language_no_outbound`) is a
drop‑in replacement for Drupal core's "Content language" language negotiator, with
one deliberate difference: it **reads** the content language from the
`language_content_entity` query parameter but **never adds** that parameter to the
links it generates. It only detects; it never emits.

That distinction matters on multilingual sites. Core's content‑language negotiator
makes assumptions about when the language switcher should change the *interface*
language versus the *content* language, and to do so it rewrites outbound URLs — which
can interfere with your language‑switching mechanism. This module makes no such
assumptions: it simply reads the content language from the query parameter when it's
present and leaves every outbound link untouched, so your language switcher keeps
behaving exactly as you designed it. The typical use case is letting editors edit
node translations in the admin backend (via `language_content_entity`) without
changing the interface language, while the front‑end switcher only ever changes the
interface language. It leaves the logic of *when* the parameter should be set to
other modules.

This is a small, focused **language‑negotiation utility** with no content or
access role of its own. It has no dependencies beyond Drupal core and runs on Drupal
10 and 11. You activate it from the core language detection settings; it *also* ships a
small configuration page of its own (linked as "configure" next to the negotiator)
where you can optionally re‑enable appending the parameter for specific entity paths —
see "How to use it" below. Note this release is a release candidate (1.0.0‑rc2).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

You activate this module from Drupal's core language detection and selection settings.
It additionally provides its own small configuration page (**Outbound entity path
names**) reached via the negotiator's "configure" link — optional, and empty by
default. Both are described in "How to use it" below.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
   Multilingual support requires core's Language and Content Translation features to
   be set up in the usual way.
2. Go to the core **language detection and selection** settings for **Content
   language** (under **Configuration → Regional and language → Languages →
   Detection and selection**).
3. **Enable "Content language (no outbound)"** as a content‑language detection
   method, and **disable the core "Content language" method** — you don't want both
   active at once.
4. Save. Content language will now be detected from the `language_content_entity`
   query parameter without that parameter being appended to any generated links,
   keeping your language switcher's behavior clean and predictable.
5. *(Optional.)* If you actually want the parameter appended to certain links, open the
   negotiator's own **configure** page
   (`/admin/config/regional/language/detection/content-entity-no-outbound`, requires the
   *Administer languages* permission) and enter the relevant entity link‑template names
   (one per line, e.g. `edit-form`) in **Outbound entity path names**. Leave it empty to
   keep the default "never append" behavior.
