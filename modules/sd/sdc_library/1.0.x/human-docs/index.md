# SDC Library — manual setup guide

**SDC Library** (`sdc_library`) provides a UI for browsing the **Single Directory
Components (SDC)** available on your site. It lists the components together with
their props, slots, and previews, so developers and designers have a reference for
the component set they can build with.

The module is aimed at people building and theming a site rather than at end users:
its browser is gated behind the module's own permission, so it is exposed to
administrators and developers, not the public. It has no content or access role
beyond that permission. It ships an optional **SDC Library Paragraphs** submodule
(`sdc_library_paragraphs`) for integrating components with the Paragraphs module.

A note of caution from the project itself: SDC Library is under active development
and its maintainers state it is **not yet ready for production use** (this is an
early `1.0.0-alpha4` release). Treat it as a developer/reference tool on
non-production or carefully controlled environments. It depends on nothing beyond
Drupal core and targets Drupal 10.3+ and 11.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and optionally add the Paragraphs submodule.

## How to use it

Once enabled and once you have granted its permission to the appropriate roles, the
component browser lets you explore the Single Directory Components on the site — the
props each accepts, the slots it exposes, and a preview. There is no settings form to
configure; it is a read-only reference. Grant the module's permission (under
**People → Permissions**) to the developer and designer roles that need it.
