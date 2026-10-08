# Page Specific Class — manual setup guide

**Page Specific Class** (`page_specific_class`) lets you add CSS classes to the
`<body>` tag on chosen pages, so you can style — or run JavaScript against — one
page (or a whole section) differently from the rest of the site. It is driven
entirely by a simple list you type into one admin settings form: each line is a
path, a pipe character, and the class(es) to add. No theme code, template
overrides, or preprocess functions of your own are required.

Behind the scenes the module hooks into how Drupal builds the page's `<html>`
variables and appends your class(es) to the body tag whenever the current page
matches one of your rules. It understands a few handy targets: a single path like
`/node/1`, the front page via `/<front>`, every page via `/*`, and wildcard
prefixes like `/content/article*` (which matches any path starting with
`/content/article`). Matching is alias‑aware, so entering a friendly URL alias
works just as well as the internal system path.

Because the whole configuration is a single exportable setting, your per‑page
classes travel with your site's configuration instead of being scattered through
template logic — handy for keeping design tweaks reviewable and deployable.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, the `path|class`
   syntax, and the special targets, explained line by line.

## Where it lives in the admin menu

Once enabled, the module's settings form sits at **Configuration → User interface
→ Page Specific Class** (`/admin/config/page-class/settings`). It is the only page
the module adds; there are no permissions of its own (the form uses the standard
**Administer site configuration** permission) and no Drush commands.
