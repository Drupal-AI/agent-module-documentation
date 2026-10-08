# Locale Deploy — manual setup guide

**Locale Deploy** (`locale_deploy`) makes interface (locale) translations follow
the same deployment path as your code and configuration. Translations for Drupal
core and contrib modules come from localize.drupal.org, and in a traditional
Drupal workflow you update them by running Drush commands or clicking through the
UI directly on each environment — which gives a site little visibility of what
changed and can mean editing a live site outside a proper deployment. Because
configuration and locale strings are intertwined (a change in one can affect the
other), that is riskier than it looks.

This module lets translations be exported, committed, and re‑imported
deterministically as part of a deployment, so what ships to production is known
and reviewable. It is strictly about **interface strings** — it does **not**
touch content translation in any way.

Locale Deploy makes **no changes to Drupal's user interface**: everything happens
through Drush. It provides two commands and also hooks into `updatedb` so that
translations are refreshed automatically during a `drush deploy`:

- **`locale-deploy:localize-translations`** — fetches translations from
  localize.drupal.org for your site, places them in your local translations
  folder, updates the site's translations in the database, and exports
  configuration so all files are consistent afterwards.
- **`locale-deploy:custom-translations`** — scans `modules/custom` to extract
  translations from your own code and copies them into the custom folder of your
  local translations directory, with one file per enabled language.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** — the module has no settings form. All
interaction is through the Drush commands described above.

## Where it lives in the admin menu

Locale Deploy adds nothing to the admin menu. It is a developer/dev‑ops tool
driven entirely from the command line via Drush.

## How to use it

1. Run `drush locale-deploy:localize-translations` to pull the latest core and
   contrib translations into your local translations folder, update the database,
   and export the resulting configuration. Commit the changed translation and
   config files to version control.
2. If your custom modules under `modules/custom` contain translatable strings,
   run `drush locale-deploy:custom-translations` to extract them into per‑language
   files in your translations folder, and commit those too.
3. Deploy as usual. Because the module hooks into `updatedb`, a `drush deploy`
   on the target environment applies the committed translations along with your
   database updates — no manual re‑import needed.
