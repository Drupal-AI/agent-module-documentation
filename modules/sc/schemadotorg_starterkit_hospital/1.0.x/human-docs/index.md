# Schema.org Blueprints Starter Kit: Hospital — manual setup guide

**Schema.org Blueprints Starter Kit: Hospital** (`schemadotorg_starterkit_hospital`)
is a ready‑made setup that scaffolds the content structure for a **hospital
website**, built on the **Schema.org Blueprints** system. Enabling it stands up the
content types, fields, and Schema.org mappings a hospital site needs — types such as
`Hospital` and `MedicalOrganization` — along with default content, so you can get a
structured, semantically‑modelled site off the ground quickly.

It is a site‑building starter kit rather than a runtime feature: on enable it
installs configuration and sample content that then follow your site's normal access
rules. It has no access‑control role of its own. It depends on the **Schema.org
Blueprints** suite (`schemadotorg` plus its starter‑kit component), **Paragraphs**
(`paragraphs`), **Config Rewrite** (`config_rewrite`), and **Default Content**
(`default_content`), and supports Drupal 10.3+ and 11.

> **Deprecated:** this project is deprecated and no longer maintained. Starter Kits
> are no longer the recommended way to set up Drupal sites and features — **use
> Drupal Recipes instead** (see the Schema.org Recipes sandbox for an example).
> Existing installations are not uninstalled automatically; keep using them at your
> own risk while you migrate to Recipes. For new sites, prefer a Recipe.

This guide is written for a **human** using the admin UI. If you are an AI coding
agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   starter kit to scaffold the hospital content structure.

## How to use it

Because it is a starter kit, the intended way to use it is to **enable it on a fresh
or evaluation site**. On enable it scaffolds the hospital content types, fields,
Schema.org mappings, and default content in one step. From there you manage the
content like any other, with the structured‑data mappings already in place. There is
no dedicated settings form.
