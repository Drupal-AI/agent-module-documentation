# SVG Upload Sanitizer — manual setup guide

**SVG Upload Sanitizer** (`svg_upload_sanitizer`) strips scripts and other active
content out of SVG files **as they are uploaded**, closing one of the more
reliable stored‑XSS routes into a Drupal site. It works silently in the
background — there is no admin page and nothing to configure.

The reason it matters: an SVG is XML that browsers execute. An `.svg` file can
carry `<script>`, `on*` event handlers, `<foreignObject>` with embedded HTML, and
external references. Serve one from the same origin as your site — which a public
file field does — and simply opening it can run an attacker's JavaScript with the
visitor's session. That is why allowing SVG uploads without sanitisation is a
well‑known security mistake. This module hooks the widely‑used
`enshrined/svg-sanitize` library (an allow‑list cleaner that removes anything not
on its list of safe elements and attributes) into Drupal's upload path, so each
file is cleaned **before it is stored**. Sanitising on upload is the right choice,
because the stored file is what eventually gets served.

The module works the moment you enable it: every SVG uploaded through Drupal is
sanitised automatically with the library's default behaviour. It depends only on
core's **File** module, needs **PHP 8.1+**, and pulls in the
`enshrined/svg-sanitize` Composer package as a dependency. There are no submodules
and no settings form.

A few limits are worth understanding. It only sees files uploaded **through
Drupal** — anything placed on disk by a migration, rsync, or a direct file‑API
call bypasses it, so sanitise those separately. Because it is an allow‑list
cleaner, its safety tracks the library version, so keep `enshrined/svg-sanitize`
current. And the strongest complementary control remains serving user‑uploaded
files from a **separate domain**, which removes same‑origin execution regardless
of file content. Note too that this project is **not covered by Drupal's security
advisory policy** — factor that into your risk assessment. Developers who need to
change the sanitiser's behaviour (for example to strip remote references) can do
so by decorating the `svg_upload_sanitizer.sanitizer.svg` service; see
[Configuration for developers](configuration/index.md).

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its sanitiser
   library with Composer, then enable it.
2. [Configuration for developers](configuration/index.md) — optional: change the
   sanitiser's behaviour by decorating its service.

## How to use it

There is nothing to switch on beyond enabling the module. Once it is enabled, upload
an SVG through any file or image field and the file is cleaned before it is saved —
no configuration, no permission, no route.
