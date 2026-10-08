# Recogito Integration — manual setup guide

**Recogito Integration** (`recogito_integration`) brings the
[Recogito](https://recogito.pelagios.org/) / Annotorious annotation tooling into
Drupal, so editors and researchers can highlight passages of text — or regions
of images — directly on a page and attach tags and notes to them. It was built
by the University of Toronto Scarborough Library's Digital Scholarship Unit for
scholarly and archival content, where being able to annotate primary sources in
place is a core need.

Text annotations use the Recogito JS library; image annotations use Annotorious
with the OpenSeadragon deep-zoom viewer. The annotations themselves are stored as
Drupal **nodes**, so they behave like any other content — subject to Drupal's
roles and permissions — and their tags can be stored as **taxonomy terms**,
optionally autocompleting from a vocabulary you nominate. You tell the module
which part of the page is annotatable by pointing it at a DOM element (by class,
id, or tag).

A couple of caveats are worth knowing before you rely on it. Annotation positions
are tied to the text as it stands, so if you later edit annotated content the
highlights can drift — keep edits to annotated content minimal. And if you turn
on taxonomy-term storage, the module will **delete** terms in the nominated
vocabulary that are not attached to any annotation, so always point it at an
empty, dedicated vocabulary rather than an existing one you care about.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, its
   dependencies, and enable it.
2. [Configuration](configuration/index.md) — tell the module which page element is
   annotatable, and optionally wire up a tag vocabulary.

## Where it lives in the admin menu

After installation, configure the module at
`/admin/config/development/recogito_integration`. Annotation permissions
(create, read, update, delete) are managed on the standard **People →
Permissions** page.
