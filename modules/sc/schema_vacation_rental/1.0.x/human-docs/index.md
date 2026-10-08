# Schema.org VacationRental — manual setup guide

**Schema.org VacationRental** (`schema_vacation_rental`) adds the Schema.org
[`VacationRental`](https://schema.org/VacationRental) type to the JSON‑LD
structured data your site outputs. It is an add‑on for the **Schema.org Metatag**
framework, aimed at travel and holiday‑letting sites that list vacation rentals and
want each listing to carry rich structured data search engines can read.

Structured data is invisible markup that states plainly what a page is — here,
"this page is a vacation rental, here are its details." Once Schema.org Metatag and
Schema.org Accommodation are in place, this module contributes the `VacationRental`
vocabulary; you map your fields onto it through Metatag's settings screens, and the
module writes the matching JSON‑LD into the page head at render time.

The module has no settings form of its own and no content or access role. It becomes
useful as soon as you enable it alongside its dependencies; the field mapping is
done on the Metatag settings page. It builds on both `schema_metatag` and
`schema_accommodation` and supports Drupal 9, 10, and 11.

This guide is for a **human** working through the admin UI. An AI coding agent
should read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Schema.org Metatag and Accommodation dependencies.
2. [Configuration](configuration/index.md) — where the VacationRental fields
   appear and how to map your content onto them.

## How to use it

Once enabled, the `VacationRental` type is available inside Schema.org Metatag. You
configure it under **Configuration → Search and metadata → Metatag**
(`/admin/config/search/metatag`) by editing the content type you use for rentals
and filling in the `@VacationRental` fields, typically with node tokens. See
[Configuration](configuration/index.md).
