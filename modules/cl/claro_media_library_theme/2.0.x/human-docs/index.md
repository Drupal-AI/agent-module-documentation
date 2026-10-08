# Add Claro Media Library to Theme — manual setup guide

**Add Claro Media Library to Theme** (`claro_media_library_theme`) fixes one
specific, irritating symptom: a media library that looks broken when it opens
outside the admin area. Drupal's media library is a modal, and the templates and
preprocessing that style it live in **Claro**, the admin theme. Open the library
from a normal node form in the admin theme and it looks fine. Open it from
somewhere rendered in your **front-end theme** — an inline entity form, a Layout
Builder off-canvas dialog, a front-end editing interface, or a custom form on a
public page — and those templates are missing, so the neat grid collapses into an
unstyled list and the widget becomes awkward to use.

The usual workaround is to copy Claro's templates into your front-end theme, which
then has to be kept in step with core on every single update. This module takes a
cleaner approach: it registers Claro's media library templates in the *active*
theme's registry, so core stays the single source of those templates and you have
nothing to maintain by hand. Some small custom CSS is added so the library looks
consistent wherever it appears.

It works the moment you enable it — there is nothing to configure and no
permissions to grant. Its one dependency is core's **Media Library** module
(`media_library`). A couple of things are worth knowing before you install: the
core requirement is an exceptionally tight `^11.4`, pinning it to a single minor,
so re-check compatibility at every core update; and the module is a deliberate
candidate for removal if a future core release moves the library's theming out of
the admin theme. Confirm the problem is actually present on your site — it only
shows up where the library is opened outside the admin theme — before reaching for
it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Media Library dependency.

There is **no configuration page** for this module — it has no settings form and
adds no permissions. Once enabled, it simply does its job.

## How to use it

There is nothing to do after enabling it. With the module on, open the media
library from a front-end context that was previously broken — a Layout Builder
off-canvas dialog, an inline form on a public page, or a front-end editing
interface — and the library should now render as the proper styled grid rather
than a bare list.
