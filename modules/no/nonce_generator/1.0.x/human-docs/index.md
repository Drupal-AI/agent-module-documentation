# Nonce Generator — manual setup guide

**Nonce Generator** (`nonce_generator`) is a small security primitive for
developers: it produces a fresh, cryptographically‑secure **nonce** (a unique,
one‑time token) on every HTTP request. Its main purpose is Content Security Policy
(CSP) — it generates a unique nonce per request and injects it into the
`script-src` CSP header, so inline scripts you output can carry a matching nonce
instead of forcing you to allow `unsafe-inline`. The nonce is also generally
useful anywhere you need an unpredictable one‑time value (anti‑replay markers, for
example).

The module itself adds no scripts to your pages. Instead you (or another module)
create small **NonceScript plugins** that emit `<script>` tags carrying the
per‑request nonce, and render them through a `nonce_script` render element.
Because the nonce is produced by lazy builders, scripts get a fresh nonce on every
request — so even cached content does not cause CSP violations. The nonce is built
as `hash('sha256', random_bytes(16))`, seeded from PHP's `random_bytes()` CSPRNG,
which makes it genuinely unpredictable.

There is **nothing to configure** and no admin settings form. Once enabled, the
module provides its service and plugin type; the actual work of outputting scripts
lives in the plugins you write. Note this is a Drupal 10/11 module and requires no
third‑party libraries.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** — the module has no settings form. It works as
soon as it is enabled; you consume it from your own code via its service and the
`nonce_script` render element (see "How to use it" below).

## How to use it

Nonce Generator is a building block for developers. In outline:

1. In your own module, create a plugin class under
   `src/Plugin/NonceScript/MyScript.php` that extends `NonceScriptPluginBase` and
   returns your inline `<script>` markup, escaping the supplied nonce and placing
   it in the tag's `nonce="…"` attribute.
2. Render a specific plugin with a render array of `#type => 'nonce_script'` and
   `#plugin_id => 'my_script'`, or render every active plugin with
   `#type => 'nonce_script'` and `#all_plugins => TRUE`.

The module takes care of generating the nonce and adding it to the CSP header; you
only supply the script that uses it. For a concrete integration example, see the
sibling **Nonce Piwik Plugin** module, which ships a ready‑made NonceScript plugin
for Piwik PRO analytics.
