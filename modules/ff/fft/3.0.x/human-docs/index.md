# Field Formatter Template — manual setup guide

**Field Formatter Template** (`fft`) lets a site builder render any field through a
**Twig template** chosen right from the field's *Manage display* settings. The
usual way to change one field's markup is to write a theme template with a long,
suggestion‑based filename — which means editing the theme, knowing Drupal's
template‑suggestion rules, and rebuilding the cache. FFT moves that choice into the
admin UI: you write a template once, drop it in a configured folder, and it appears
as a formatter option on any field.

Templates are discovered by scanning a directory: FFT reads each Twig file and
keeps the ones that (a) carry a `{# Template Name: … #}` header comment and (b)
have a filename starting with the expected `fft-` prefix. An optional
`{# Settings: … #}` block can pass per‑template settings. Inside a template you get
`data` (the field's values), `entity` (the field's entity), and `settings` (your
extras). A submodule, **Views Formatter** (`vff`), extends the same idea to Views.

> **Security note — choose the template directory carefully.** The directory
> setting is a plain text field with no validation: nothing stops you from pointing
> it inside the public files directory or somewhere the web server can write.
> Anyone who can write a Twig file into that folder controls markup that FFT will
> render. On Drupal 11 the Twig sandbox blocks the classic template‑injection route
> to code execution, so the realistic worst case is **stored XSS** (a planted
> template emitting unescaped `<script>`) rather than a compromised server — but
> that is still serious. **Keep the template directory inside your code
> repository, outside `public://`, and not writable by PHP**, and treat FFT
> templates as code, not content.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally the Views Formatter submodule.
2. [Configuration](configuration/index.md) — set a safe template directory and
   write your first formatter template.

## Where it lives in the admin menu

The module's settings — chiefly the template directory — live at
**Configuration → Content authoring → Field Formatter Template**
(`/admin/config/content/fft`), which requires the *Administer site configuration*
permission. You then apply a chosen template per field under **Structure →
(content type / bundle) → Manage display**.
