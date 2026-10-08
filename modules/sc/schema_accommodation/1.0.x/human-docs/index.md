# Schema.org Accommodation — manual setup guide

**Schema.org Accommodation** (`schema_accommodation`) adds the Schema.org
`Accommodation` type to the JSON-LD structured data your site emits through the
[Schema.org Metatag](https://www.drupal.org/project/schema_metatag) framework.
Structured data is how a search engine understands what a page *is* — and for
accommodation listings (rooms, lodgings, rentals), describing them with the right
Schema.org type can make them eligible for richer search results. This module
supplies the `Accommodation` vocabulary; it is the base type that
`schema_vacation_rental` and similar submodules build on.

It is a purely additive SEO / structured-data module. It has no content model or
access-control role of its own — it just contributes fields to the Metatag
configuration, and Schema.org Metatag assembles and renders the JSON-LD in the
page head. It depends on the Schema.org Metatag module and works on Drupal 9, 10,
and 11.

There is no separate settings screen to fill in for this module. After enabling
it, you configure the accommodation fields on your Metatag defaults (or on
per-entity metatag fields), just like any other Schema.org Metatag type. It is
also useful to add the `schema_vacation_rental` module alongside it.

This guide is written for a **human** setting things up through the admin UI. If
you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Schema.org Metatag.

## How to use it

Configuration happens inside the Metatag UI, not a page of this module's own:

1. Install and enable the module (see [Installation](installation/index.md)).
2. Go to **Configuration → Search and metadata → Metatag**
   (`/admin/config/search/metatag`) and edit the metatag defaults for the content
   type you want to mark up (or add metatag defaults for it).
3. Find the additional **Accommodation** fields (the module's docs refer to the
   `@VacationRental` fields) and fill them in — typically using **node tokens** so
   each page's values are pulled from its own fields.
4. Save. The values are composed into the `Accommodation` JSON-LD that Schema.org
   Metatag renders in the page head.

For the full property vocabulary, see the Schema.org reference at
<https://schema.org/Accommodation>.
