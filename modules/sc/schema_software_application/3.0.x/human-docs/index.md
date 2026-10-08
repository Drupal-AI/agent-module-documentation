# Schema.org SoftwareApplication — manual setup guide

**Schema.org SoftwareApplication** (`schema_software_application`) adds the
Schema.org [`SoftwareApplication`](https://schema.org/SoftwareApplication) type to
the JSON‑LD structured data your site outputs. It is an add‑on for the **Schema.org
Metatag** framework, aimed at pages that describe a piece of software or an app —
so you can publish details such as the application's name, operating system,
price, and ratings as structured data eligible for software rich results in
search.

Structured data is invisible markup that tells search engines and AI assistants
what a page is — here, "this page is a software application, here is its name and
these are its details." Once Schema.org Metatag is in place, this module
contributes the `SoftwareApplication` vocabulary; you map your fields onto it
through Metatag's settings screens, and the module writes the matching JSON‑LD into
the page head at render time.

The module has no settings form of its own and no access‑control role. It becomes
useful as soon as you enable it alongside Schema.org Metatag; the field mapping is
done on the Metatag settings page. It depends only on `schema_metatag` and supports
Drupal 9, 10, and 11. Note that the module is **not yet feature‑complete** with the
full Schema.org SoftwareApplication vocabulary — it covers the common properties,
and the maintainers welcome requests for additional tags.

This guide is for a **human** working through the admin UI. An AI coding agent
should read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Schema.org Metatag dependency.
2. [Configuration](configuration/index.md) — where the SoftwareApplication fields
   appear and how to map your content onto them.

## How to use it

Once enabled, the `SoftwareApplication` type is available inside Schema.org
Metatag. You configure it under **Configuration → Search and metadata → Metatag**
(`/admin/config/search/metatag`), on the content type that represents your
software, by filling in the **Schema.org: SoftwareApplication** fieldset. See
[Configuration](configuration/index.md).
