# Yoast Analysis — manual setup guide

**Yoast Analysis** (`yoast_analysis`) adds a per-entity **SEO Analysis** tab that runs
the well-known [YoastSEO.js](https://github.com/Yoast/wordpress-seo) text-analysis
library against your content. On that tab, editors get a live SEO/readability score, a
Google-style **snippet preview** (title, URL, meta description), and a **focus keyword**
field whose assessments update as they type — the same coaching experience many people
know from WordPress, brought to Drupal.

All of the analysis happens **in the browser**: nothing is sent to Yoast or any other
external service, which keeps your content private. The module adds the SEO Analysis
tab to every entity type that has a canonical URL (nodes, taxonomy terms, users, media,
and so on), but it only becomes active where you switch it on — see below. The tab is
visible only to users who can edit the entity.

The clever part of the setup is how you control *what* gets analysed: the module uses a
dedicated **`yoast_analysis` view mode**. Whether that view mode exists (and is enabled)
for a bundle is the on/off switch, and the fields you put in that view mode are exactly
the fields fed to the analyzer — so you can strip out blocks and admin fields and
analyse just the real content. There is no settings form, permission, or Drush command;
[Metatag](https://www.drupal.org/project/metatag) is an optional soft dependency used to
supply the snippet's title and description.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enable the `yoast_analysis` view mode on
   the bundles you want analysed, and understand the access rules.

## Where it lives in the admin menu

There is no settings page. You enable analysis per bundle via view modes at
**Structure → Display modes → View modes** and each bundle's **Manage display** screen.
The analysis itself appears as an **SEO Analysis** tab on the entity (and as an entity
operation in content lists).

## How to use it

Because there is no settings form, the whole setup is: enable the `yoast_analysis` view
mode for a bundle, choose which fields it shows, then open an entity of that bundle and
click its **SEO Analysis** tab. See [Configuration](configuration/index.md) for the
step-by-step.
