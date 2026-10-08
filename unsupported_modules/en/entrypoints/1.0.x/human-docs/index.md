# Entrypoints — manual setup guide

**Entrypoints** (`entrypoints`) bridges a JavaScript build toolchain and Drupal's
library system. It reads the **entrypoint/manifest definitions** produced by
bundlers such as webpack or Vite and exposes each build as a **Drupal library**
that you can attach to render arrays, blocks, or responses — so a compiled
front‑end app or component becomes a first‑class Drupal library instead of
something you register by hand in a `*.libraries.yml` file.

It supports **server‑side rendering (SSR)** of entrypoints, **pluggable runtimes**
(npm or yarn) for building, **renderer plugins** (for example a node renderer),
and **input handlers** that feed data into a build. It ships an Entrypoint block,
an SSR response subscriber/processor, plugin managers for runtimes, renderers, and
input handlers, and Drush commands. This is aimed at developer and DevOps
workflows where front‑end code is compiled and needs to be registered, served,
and optionally rebuilt from within Drupal.

Rebuilding actually **compiles projects via a runtime (npm/yarn)**, which is a
powerful, trusted‑admin operation — so the edit and rebuild permissions are
deliberately marked as restricted. It is a permission‑gated administrative action,
not a request‑time endpoint.

> **Note:** this project is currently marked **Unsupported / no further
> development**, and it targets **Drupal 9 and 10** (not 11). Weigh that before
> adopting it on a new build.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form, the rebuild
   workflow, and the permissions.

## Where it lives in the admin menu

Entrypoints is configured at **`/admin/config/entrypoints`** (the
`entrypoints.settings_form`), with a rebuild workflow at
**`/admin/config/entrypoints/rebuild`**.

## How to use it

Once your entrypoint definitions are registered, you attach a built entrypoint to
a render array as an ordinary Drupal library, place it with the provided
**Entrypoint block**, or let the SSR support server‑render it into the HTML
response. Builds can be run from the settings/rebuild form or from the command
line with the module's Drush commands.
