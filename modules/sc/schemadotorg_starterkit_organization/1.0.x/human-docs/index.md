# Schema.org Blueprints Starter Kit: Organization — manual setup guide

**Schema.org Blueprints Starter Kit: Organization** (`schemadotorg_starterkit_organization`)
is a starter kit that scaffolds a ready-made content model for representing an
organization or a local business with structured, SEO-friendly data. Rather than
building the fields by hand, you enable the module once and it installs the
Schema.org **Organization** and **LocalBusiness** content types — complete with
the required fields and the Schema.org mappings that emit structured data for
search engines.

It builds on the Schema.org Blueprints suite (`schemadotorg` and
`schemadotorg_starterkit`) and pulls in `config_rewrite` and core's `menu_ui`.
Because a starter kit installs configuration into your site the moment you turn
it on, it is meant to be run on a fresh or evaluation site: it stands up the
organization content model quickly so you can start adding structured
organization/local-business content right away. There is no settings form to
fill in — the work happens at install time.

Please note that this project is **deprecated and no longer maintained**. Starter
Kits are no longer the recommended way to set up Drupal sites; the maintainers
point people to **Drupal Recipes** instead (see the Schema.org Recipes example).
Existing installations keep working, but for a new build you should prefer a
Recipe-based approach. This module also carries **no official security-advisory
coverage**.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, installing with Composer,
   and enabling the starter kit on a fresh site.

## How to use it

Once enabled on a fresh or evaluation site, the starter kit has already done its
job: look under **Structure → Content types** and you will find the new
**Organization** and **LocalBusiness** types, pre-mapped to Schema.org with the
fields each needs. Add content of those types and the pages emit the matching
structured data automatically. There is no configuration page of its own — review
the generated types and adapt them to your site as needed.
