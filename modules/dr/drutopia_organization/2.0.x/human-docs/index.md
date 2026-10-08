# Drutopia Organization — manual setup guide

**Drutopia Organization** (`drutopia_organization`) adds an **Organization**
content type to a [Drutopia](https://www.drupal.org/project/drutopia) site, for
profiling groups, nonprofits and businesses and presenting them as a directory.
Enable it and you get an `organization` node type with an image (with
focal-point cropping), a paragraph-based body, field groups, faceted listing,
Pathauto aliases and Metatag/SEO integration — plus an "Add organization" action
link on the organization listing view.

Organizations are designed to be linked to other Drutopia content — blogs,
resources and events — so a site can show which organizations are behind which
content and build a browsable directory of participants. Everything is delivered
as configuration; there is no custom code, so access to organization nodes
follows standard node permissions and whatever editorial workflow you set up.

The feature builds on
[`drutopia_core`](../../drutopia_core/2.0.x/human-docs/index.md),
[`drutopia_event`](../../drutopia_event/2.0.x/human-docs/index.md) and
[`drutopia_seo`](../../drutopia_seo/2.0.x/human-docs/index.md), and wires in
Paragraphs, Inline Entity Form, Facets, Focal Point, Field Group, Display Suite,
Pathauto and Metatag.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Drutopia and supporting dependencies.

## Where it lives in the admin menu

There is no dedicated settings form. The Organization content type appears under
**Structure → Content types** (`/admin/structure/types`); create organizations
from **Content → Add content → Organization** (`/node/add/organization`) or via
the "Add organization" link on the organization listing.

## How to use it

Add an organization, give it an image and a paragraph-composed body, and save.
The faceted listing view presents the directory of organizations, and Pathauto
generates each URL alias. Because organizations can be referenced from blogs,
events and resources, use those content types' organization fields to associate
content with its host organization. Extend the type with extra fields or tune
its displays like any other content type.
