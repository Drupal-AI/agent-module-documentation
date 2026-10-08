# Next.js Generator — manual setup guide

**Next.js Generator** (`nextgen`) is a developer/scaffolding tool that generates
**Next.js front‑end code** from your Drupal site using Drush's code‑generation
(`drush generate`) commands. If you are building a decoupled site with a Next.js
front end, it saves you hand‑writing the boilerplate: it reads your Drupal content
model and scaffolds matching components and pages, using the
[DrextJS](https://github.com/cooldrupal/drext) base as a starting point.

It runs entirely on the command line and has **no configuration screen, no admin
menu item, and no runtime behaviour on the site itself** — it neither serves
content nor enforces access. You enable it, run its generator commands, and take
the generated code into your Next.js project. It works with Drupal 10, 11, and 12,
and has no other module dependencies.

The generators cover three cases: a component for an entity
(`drush generate next-entity-component`, supporting `string`, `basic_string`,
`text_default`, and `image` field types), an App Router page from a Views page
(`drush generate next-view-page`, carrying over path, title, pager options, and
taxonomy‑based exposed filters), and an App Router page from a JSON:API listing
(`drush generate next-jsonapi-page`, carrying over path and title).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it is a set of Drush
generators. Usage is covered in "How to use it" below.

## How to use it

Once the module is enabled, run any of its generators from the project root (the
generators are interactive and will prompt you for the parameters listed):

```bash
# A Next.js component for an entity (string / basic_string / text_default / image fields)
drush generate next-entity-component

# An App Router page from a Views page (path, title, pager, taxonomy exposed filters)
drush generate next-view-page

# An App Router page from a JSON:API listing (path, title)
drush generate next-jsonapi-page
```

The generated code is based on the DrextJS base project. Copy the output into your
Next.js application and adapt as needed.
