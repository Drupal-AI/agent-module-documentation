# Remix — manual setup guide

**Remix** (`remix`) is, as of the 2.0.x release, a **placeholder project**. The
module page describes an intended integration between Drupal and the Remix web
framework (the React-based full-stack framework) — the idea being to let a
decoupled or progressively-decoupled front end consume Drupal content from a Remix
application. However, the maintainers have stated plainly that any Drupal/PHP code
that once lived here has been **relocated to the
[Decoupled Preview Iframe](https://www.drupal.org/project/decoupled_preview_iframe)
module**, and this project currently exists mainly to hold the name.

In practical terms: enabling `remix` today does **not** give you a working
Drupal ↔ Remix bridge, because the functional code moved elsewhere. If you are
building a decoupled front end and looking for the preview/integration features,
look at **Decoupled Preview Iframe** instead. Keep an eye on the project's issue
queue if you specifically want Remix-framework integration to return here.

The package still declares compatibility with Drupal 9, 10, and 11 and has no
dependencies, but there is no meaningful configuration or feature to set up in
this version.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — how to install the project with
   Composer, with the important caveat that it is currently a placeholder.

There is **no configuration page** and no feature to configure in this release.

## How to use it

There is nothing to set up. If you need actual decoupled preview/integration
functionality, install
[Decoupled Preview Iframe](https://www.drupal.org/project/decoupled_preview_iframe),
which is where this project's code was moved.
