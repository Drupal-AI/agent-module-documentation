# Storybook — manual setup guide

**Storybook** (`storybook`) connects Drupal's Twig rendering to
[Storybook](https://storybook.js.org/), the popular front‑end tool for building and
documenting a component library. It lets you write **stories** — example
configurations of a component — directly in Twig, then browse them in Storybook
where each one is rendered with *real* Drupal markup rather than a hand‑maintained
copy.

The workflow has three parts. First, you author stories in `*.stories.twig` files
next to your components (typically Single Directory Components or theme templates),
using two new Twig tags the module provides: `{% stories %}` to group related
variants and `{% story %}` to define each one. Second, you compile those Twig files
into `*.stories.json` with a Drush command. Third, the external Storybook
application reads that JSON and, for each story, calls a Drupal render endpoint that
returns the genuine Twig output — so what you see in Storybook is exactly what your
site produces.

To make the preview work in development, the module quietly wires up several helpers:
a theme negotiator so components render in your front‑end theme, absolute asset URLs
so styles and scripts load inside Storybook's iframe, a re‑run of Drupal's JS
behaviors, and an optional "development mode" that turns off caching so you always
see fresh output.

This is a **development tool**. Browsing components requires running the external
Storybook (Node/npm) application and enabling CORS — dependencies that live outside
Drupal — and the render permission and development mode should stay **disabled in
production**. The Twig tags, the Drush compilation, the render route, and the
permission all work inside Drupal without the Node app.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in the
   `twig-storybook` library) and enable it.
2. [Configuration](configuration/index.md) — the render permission, development mode,
   CORS, the external Storybook app, the Drush compile commands, and how to write
   stories.

## Where it lives in the admin menu

Storybook has **no admin settings page**. Its one user‑facing switch is the **Render
storybook stories** permission at **People → Permissions**
(`/admin/people/permissions`). Everything else is done in code/services and on the
command line.

## How to use it

Write `*.stories.twig` files, compile them with `drush
storybook:generate-all-stories`, run the external Storybook app pointed at the
compiled JSON, and grant the render permission so Storybook can fetch Drupal's
output. See [Configuration](configuration/index.md) for the full setup.
