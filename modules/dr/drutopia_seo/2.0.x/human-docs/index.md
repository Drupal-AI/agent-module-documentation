# Drutopia SEO — manual setup guide

**Drutopia SEO** (`drutopia_seo`) layers sensible search-engine-optimization
defaults onto a [Drutopia](https://www.drupal.org/project/drutopia) site. It's a
configuration-only base feature: it ships a shared meta-tags field storage
(`field.storage.node.field_meta_tags`) and, through its dependencies on
**Metatag**, **Redirect** and **Redirect 404**, wires up default metatag and
redirect behaviour for the whole site.

Its main job is to be a foundation other Drutopia features build on. Content-type
features such as
[Drutopia Page](../../drutopia_page/2.0.x/human-docs/index.md) and
[Drutopia Landing Page](../../drutopia_landing_page/2.0.x/human-docs/index.md)
attach the shared meta tags field to their content types, so SEO configuration
stays consistent across the site instead of being set up by hand on each type.
It also gives editors and managers the ability to create redirects and edit
metatags.

Because it is pure configuration, the module defines no routes, services or
permissions of its own and makes no outbound requests — its behaviour is entirely
that of the Metatag and Redirect modules it depends on, plus
[`drutopia_core`](../../drutopia_core/2.0.x/human-docs/index.md). Typical use is
to enable it early in a build so content types gain the meta tags field and the
site benefits from redirect and 404-redirect handling.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Metatag / Redirect dependencies.

## Where it lives in the admin menu

Drutopia SEO has no settings form of its own. You manage the behaviour it enables
through the standard Metatag and Redirect admin pages:

- **Metatag defaults:** **Configuration → Search and metadata → Metatag**
  (`/admin/config/search/metatag`).
- **Redirects:** **Configuration → Search and metadata → URL redirects**
  (`/admin/config/search/redirect`).

## How to use it

Enable the module early in your Drutopia build. Other Drutopia content features
then reuse its `field_meta_tags` storage, so their content types automatically
gain a meta tags field. Tune the metatag defaults and manage redirects through
the Metatag and Redirect admin pages above; the Redirect 404 module captures
broken URLs so you can redirect them.
