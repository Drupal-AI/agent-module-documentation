# Schema.org Blueprints Starter Kit: Medical — manual setup guide

**Schema.org Blueprints Starter Kit: Medical** (`schemadotorg_starterkit_medical`)
is a ready‑made setup that scaffolds the content structure for a **medical /
healthcare website**, built on the **Schema.org Blueprints** system. Enabling it
creates content types mapped to Schema.org `MedicalEntity` types — for things like
conditions, procedures, and physicians — together with ready‑made views and sample
content, so a healthcare site starts with a semantically‑modelled structure and the
matching structured data in place.

It is a site‑building starter kit rather than a runtime feature: on enable it
installs configuration and default content that then follow your site's normal
access rules. It has no access‑control role of its own. It depends on the
**Schema.org Blueprints** suite (`schemadotorg` plus its starter‑kit component and
several submodules), core **Views** (`views`), and core **Menu UI** (`menu_ui`), and
supports Drupal 10.3+ and 11.

> **Deprecated:** this project is deprecated and no longer maintained. Starter Kits
> are no longer the recommended way to set up Drupal sites and features — **use
> Drupal Recipes instead** (see the Schema.org Recipes sandbox for an example).
> Existing installations are not uninstalled automatically; keep using them at your
> own risk while you migrate to Recipes. For new sites, prefer a Recipe.

This guide is written for a **human** using the admin UI. If you are an AI coding
agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   starter kit to scaffold the medical content structure.

## How to use it

Because it is a starter kit, the intended way to use it is to **enable it on a fresh
or evaluation site**. On enable it scaffolds the medical content types (mapped to
Schema.org `MedicalEntity`), views, and default content in one step. From there you
manage the content like any other, with the structured‑data mappings already in
place. There is no dedicated settings form.
