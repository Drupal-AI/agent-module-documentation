# HTML Lang Override — manual setup guide

**HTML Lang Override** (`html_lang_override`) lets you control the `lang` attribute
on the page's `<html>` element independently of Drupal's interface language. By
default Drupal sets `<html lang="…">` from the site's configured language, but that
isn't always right — a site that isn't fully multilingual might have a handful of
pages written in another language, and if the `lang` attribute doesn't match the
actual content, you get accessibility problems (screen readers announce the wrong
language) and SEO warnings (mismatched `hreflang` and document language).

This module fixes that without turning on Drupal's full multilingual system. It sets
the `<html lang>` value in priority order:

1. **Per node** — an editor can set a language code for an individual node from the
   node edit form.
2. **Per path** — you can map specific request paths (including views and custom
   routes) to language codes.
3. **Global default** — a site‑wide override code, or the site's default language if
   no override applies.

It's especially useful when you only have a few off‑language pages and want precise
control over the `lang` attribute for accessibility compliance and clean SEO. The
module works with Drupal core alone — no other modules required.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the global override, map paths to
   languages, and let editors choose a per‑node language.

## Where it lives in the admin menu

The settings form is at **Configuration → Regional and language → HTML Lang
Override** (`/admin/config/regional/html-lang-override`). Individual nodes also gain
a **Custom HTML Lang Attribute** field in the *Advanced* section of the node edit
form, shown to users who hold the override permission.
