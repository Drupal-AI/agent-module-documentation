# Schema.org EducationalOccupationalCredential — manual setup guide

**Schema.org EducationalOccupationalCredential**
(`schema_educational_occupational_credential`) adds the Schema.org
`EducationalOccupationalCredential` type to the JSON-LD structured data your site
emits through the [Schema.org Metatag](https://www.drupal.org/project/schema_metatag)
framework. That type describes a certification, qualification, licence, or
credential — so a page presenting one can be understood by search engines and
become eligible for richer results.

It is a purely additive SEO / structured-data module: the JSON-LD it produces
reflects the content already on the page, and it has no content model or
access-control role of its own. It simply contributes the credential vocabulary,
while Schema.org Metatag assembles and renders the JSON-LD in the page head. It
depends on the Schema.org Metatag module and works on Drupal 9, 10, and 11.

There is no separate settings screen for this module. After enabling it, you
configure the credential fields on your Metatag defaults (or on per-entity
metatag fields), exactly like any other Schema.org Metatag type.

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
   (`/admin/config/search/metatag`) and edit (or add) the metatag defaults for the
   entity type and bundle you want to mark up.
3. Expand the **Schema.org: EducationalOccupationalCredential** fieldset and fill
   in the field mappings you want to publish, typically using **tokens** so each
   page's values come from its own fields.
4. Save. Schema.org Metatag renders the resulting JSON-LD in the page head.
