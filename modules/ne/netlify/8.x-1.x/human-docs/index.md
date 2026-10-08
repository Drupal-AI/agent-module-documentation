# Netlify — manual setup guide

**Netlify** (`netlify`) keeps a decoupled front-end hosted on Netlify in sync with
your Drupal site by triggering a **Netlify build hook** when content changes. When
a configured content or configuration entity is saved, the module POSTs to your
Netlify build-hook URL, and Netlify rebuilds the static site so it reflects the
latest data.

This is especially useful for the changes a headless front-end would otherwise
miss. A framework like Next.js may revalidate when the content being viewed
changes, but not when you change something *around* it — a View that powers a
listing, or a configuration object holding footer text or theme colors for the
headless site. Netlify lets you rebuild on exactly those kinds of updates so the
static site never drifts out of date.

The single most important thing to understand is that the **Netlify build-hook URL
is effectively a secret**: anyone who has it can trigger builds of your site. Store
it securely (an environment variable or the Key module, not committed
configuration), send it over HTTPS, and use the module's permission to control who
can configure and trigger builds. Frequent content edits mean frequent builds, so
be mindful of Netlify's build minutes. The module depends on Drupal core only and
runs on Drupal 8 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add your Netlify build-hook URL and
   choose what triggers a build.

## Where it lives in the admin menu

The module provides its own permission for configuring and triggering builds; grant
it only to trusted administrators at **People → Permissions**
(`/admin/people/permissions`). Enter your build-hook URL in the module's settings
(see [Configuration](configuration/index.md)).
