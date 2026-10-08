# Schema.org Education — manual setup guide

**Schema.org Education** (`schema_education`) adds the Schema.org
`EducationalOccupationalProgram` type to the JSON-LD structured data your site
emits through the [Schema.org Metatag](https://www.drupal.org/project/schema_metatag)
framework. `EducationalOccupationalProgram` is the Schema.org type for a course
of study that leads to a qualification — a degree, diploma, apprenticeship, or
vocational programme — with properties covering the credential awarded, the time
it takes to complete, the occupational category it prepares for, and the terms of
admission. This module supplies those properties so a university, college, or
training provider can describe its programmes in the structured form search
engines read.

The payoff is concrete: Google surfaces course and programme information in
dedicated result formats, so a properly marked-up programme page can appear with
its duration, credential, provider, and start dates attached rather than as a
plain blue link. The architecture follows the standard Schema.org Metatag pattern
— Schema.org Metatag owns the JSON-LD assembly, the token replacement, and the
per-bundle configuration, while this module simply contributes the education
vocabulary. It depends on Schema.org Metatag 2.5.x or higher and works on Drupal
9, 10, and 11.

> **A note on the metadata:** the module declares a PHP requirement of `7.2.0`.
> That is stale metadata — a floor far below anything a modern Drupal 9/10/11 site
> runs — and it does not affect installation on a current site.

The real work here is the **mapping, not the installation.** Each property must
point at the field that genuinely holds it; a programme marked up with the wrong
credential or an out-of-date start date is worse than one with no markup at all.
There is no separate settings screen — you configure the fields inside the Metatag
UI like any other Schema.org Metatag type.

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
   (`/admin/config/search/metatag`).
3. Select your entity type and bundle, expand the
   **Schema.org: EducationalOccupationalProgram** fieldset, and fill in the field
   mappings you want to publish — pointing each property at the field that truly
   holds that data, typically via **tokens**.
4. Save. Schema.org Metatag renders the resulting JSON-LD in the page head. Take
   care that every mapping is accurate.
