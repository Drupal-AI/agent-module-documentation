# ECK Site Settings — manual setup guide

**ECK Site Settings** (`eck_site_settings`) gives editors a friendly UI — and
developers an API — for managing custom, **site‑wide settings** as entities. It
builds on [Entity Construction Kit](https://www.drupal.org/project/eck) (ECK) and
is an alternative to modules like Site Settings and Labels or Config Pages.

Site‑wide values that editors should manage — a contact phone number, social
links, a promotional banner, footer text — don't fit neatly into either content
or configuration. This module models them as ECK "settings" entities: you define
the fields once, and editors fill them in through a clean settings page. A
developer API and a Twig function let those values appear anywhere in your theme.

On installation it automatically creates a **Settings** ECK entity type with a
**General** bundle, so you can start adding fields to a general settings page
straight away. As your needs grow you can add more bundles (each becomes its own
settings page) and even more settings entity types (which group the bundles). An
optional **ECK Site Settings Domain** submodule (`eck_site_settings_domain`) adds
per‑domain values for sites using the Domain module.

Because a site setting is a lever that affects every page (it often appears in
headers and footers), be deliberate about who can edit these — restrict editing to
trusted roles — and remember that any setting which outputs markup is subject to
the usual text‑format and escaping considerations. It requires ECK 2.1+ and core's
Options module, and supports Drupal 9.4, 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it alongside ECK, and add the optional Domain submodule.
2. [Configuration](configuration/index.md) — add fields to the General bundle,
   create more bundles and settings entity types, manage access, and read the
   values in Twig.

## Where it lives in the admin menu

The settings pages live under **Content → Site settings**
(`/admin/content/site-settings`), which lists all settings bundles. When you have
more than one settings entity type, the overview groups bundles by their entity
type. ECK entity types and their fields are managed under ECK's admin pages
(**Structure → ECK entity types**).
