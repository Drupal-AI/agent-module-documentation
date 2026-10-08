# SVG Image GraphQL — manual setup guide

**SVG Image GraphQL** (`svg_image_graphql`) is a small bridge module that connects
the [SVG Image](https://www.drupal.org/project/svg_image) module to
[GraphQL](https://www.drupal.org/project/graphql) version 3. It exposes SVG image
field data through the GraphQL schema so a decoupled or headless front end can
query SVG images — and their metadata — the same way it queries other fields.

The problem it solves is specific to decoupled builds. SVG Image lets you store
SVG files in image fields, but the standard GraphQL image handling does not know
what to do with vector images. This module fills that gap so your front end can
request SVG image data over GraphQL without special‑casing.

It is a pure integration module: enable it and the SVG image data becomes
available in the schema. There is no settings form to fill in — the behaviour is
automatic once the module and its two dependencies are enabled. It depends on
**SVG Image** (`svg_image`) and **GraphQL** version 3.x (`graphql`), and supports
Drupal 10 and 11. There are no submodules.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   dependencies with Composer, then enable them.

## How to use it

After the module and its dependencies are enabled, define or reuse a GraphQL
schema (as you normally do with GraphQL v3) and query your SVG image fields
through it. The SVG image data is surfaced by this module, so no additional
per‑module configuration is required — the work is on the GraphQL and front‑end
side.
