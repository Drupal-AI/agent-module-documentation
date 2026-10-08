# No Translation on Admin Pages — manual setup guide

**No Translation on Admin Pages** (`no_translation_on_admin_pages`) stops
Chromium-based browsers (Chrome, Edge, and friends) from automatically
translating Drupal's admin screens. When a user has browser auto-translation
enabled, it can quietly rewrite the admin UI into another language — which is at
best confusing and at worst misleading when you're clicking through
configuration. This module keeps the admin interface in its intended language.

It works by adding a `notranslate` class and a `translate="no"` attribute to the
`<body>` element on every admin-theme page, via a preprocess hook. Browsers that
honour those hints will then skip translating the page. There is **no settings
form** — enable it and the behaviour applies to admin pages automatically. The
only step to remember is to **clear caches after enabling** so the preprocess
change takes effect. It has no dependencies beyond Drupal core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and clear caches.

There is **no configuration page** for this module — it has no settings form.

## How to use it

There is nothing to configure. Once the module is enabled and caches are cleared,
every admin-theme page carries the `notranslate` / `translate="no"` markers, and
compatible browsers stop auto-translating the admin UI.
