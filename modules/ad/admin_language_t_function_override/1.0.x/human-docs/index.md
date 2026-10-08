# Admin Language t() function Override — manual setup guide

**Admin Language t() function Override** (`admin_language_t_function_override`) keeps
your Drupal **admin interface in English** on a multilingual site, even when the URL
carries a non‑English language prefix. On sites with several content languages, the
admin screens can end up rendered in whatever language the URL implies — so an editor
who opens `/fr/admin/...` sees a partly French back‑office. That is confusing for
operators who need a stable, predictable admin language.

This module fixes that by forcing interface strings to English on the admin paths (and
any other paths you list), regardless of the language negotiated from the URL. Under
the hood it decorates Drupal's core `string_translation` service so that `t()` and
translatable text resolve against English on matching paths — without patching core
and without touching your translated *front‑end* content, which stays in the visitor's
language as normal.

Which paths are affected is up to you: the module ships a single settings form where an
administrator lists the path patterns that should be forced to English (admin paths by
default). You can add your own custom admin routes to the list. The module reads no
untrusted input and exposes only that one permission‑gated settings form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and confirm the core Language module is on.

## Where it lives in the admin menu

The settings form is at **Configuration → Regional and language → Admin Language t()
function Override** (`/admin/config/regional/admin-language-t-function-override`), and
is gated by the core **Administer site configuration** permission.

## How to use it

1. Go to the settings form at
   `/admin/config/regional/admin-language-t-function-override`.
2. In the **path patterns** list, review the paths that will be forced to English.
   Admin paths are included by default.
3. Add any additional paths you want held to English — for example custom admin routes
   or back‑office tools — one pattern per line, following Drupal's usual path‑pattern
   style.
4. Save the form. From then on, interface strings on those paths render in English no
   matter which language prefix the URL uses, while your front‑end content remains in
   the negotiated language.

This is handy for giving editors a consistent English admin, keeping back‑office tools
readable across locales, and producing stable English admin screenshots for
documentation.
