# Schema.org/DigitalDocument — manual setup guide

**Schema.org/DigitalDocument** (`schema_digital_document`) adds the Schema.org
`DigitalDocument` type — and its `Note`, `Presentation`, `Spreadsheet`, and
`Text` subtypes — to the JSON-LD structured data your site emits through the
[Schema.org Metatag](https://www.drupal.org/project/schema_metatag) framework.
If you publish document-style content (reports, notes, slide decks, spreadsheets,
text documents), marking it up with the right Schema.org type helps search
engines understand what the page contains and can improve its eligibility for
rich results.

Under the hood the module contributes a Metatag group and a set of token-aware
metatag fields — the `@type`, plus `name`, `headline`, `description`, `about`,
`author`, `publisher`, `datePublished`, `dateModified`, `encodingFormat`,
`license`, `isAccessibleForFree`, `mainEntityOfPage`, and `associatedMedia`
(as a `MediaObject`). Schema.org Metatag composes those values into a
`DigitalDocument` JSON-LD node and renders it in the page head. The module ships
only plugin classes and a config schema; it defines no routes, permissions, or
services of its own, so it has no request-facing attack surface — output is
governed entirely by the existing Metatag configuration UI (which is protected by
the *administer meta tags* permission). It depends on Schema.org Metatag 2.x or
higher and works on Drupal 10 and 11.

There is no separate settings screen for this module. After enabling it, you
configure the DigitalDocument fields on your Metatag defaults (or on per-entity
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
   (`/admin/config/search/metatag`) and click **Add default meta tags** (or edit
   an existing default).
3. Choose your entity type and bundle, expand the **Schema.org: DigitalDocument**
   fieldset, and fill in the field mappings you want to publish — pick the
   specific `@type` (DigitalDocument, Note, Presentation, Spreadsheet, or Text)
   and populate the properties, typically with **tokens** so values come from each
   entity's own fields.
4. Save. Schema.org Metatag renders the resulting `DigitalDocument` JSON-LD in the
   page head.
