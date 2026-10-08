# Schema.org Hospital — manual setup guide

**Schema.org Hospital** (`schema_hospital`) is a lightweight extension to the
[Schema.org Metatag](https://www.drupal.org/project/schema_metatag) framework that
fills gaps in the base Organization markup for healthcare sites. Schema.org
Metatag's `schema_organization` submodule provides the common Organization
properties, but it is missing several fields that hospitals, clinics, and medical
practices need. This module adds **15 healthcare-specific properties** to the
existing Schema.org Organization group so they all appear together in a single
Organization JSON-LD object on your homepage.

The added fields fall into three groups. **Basic information:** `alternateName`
(abbreviations and alternate names), `legalName`, `foundingDate`, `email`, and
`numberOfEmployees`. **Healthcare relationships:** `employee` (links to staff or
provider Person entities — multiple allowed), `availableService` (links to medical
Service entities — multiple), and `medicalSpecialty` (multiple). **Organizational
identifiers:** `vatID`, `leiCode`, `taxID`, `duns`, `iso6523Code`, `naics`, and
`globalLocationNumber`. Every field supports **token replacement** (which works
well with the Config Pages module for site-wide organization data), the
relationship fields accept multiple values, and all fields match the official
Schema.org specifications. It is compatible with Drupal 10 and 11.

Because it extends the existing `schema_organization` group rather than defining a
new schema, it has no settings page of its own — you fill in the new fields
alongside the existing Organization fields inside the Metatag UI. Note the module
depends specifically on the **`schema_organization`** submodule of Schema.org
Metatag (the Composer package is `drupal/schema_hospital`). It is a purely
additive SEO / structured-data module with no content or access-control role.

This guide is written for a **human** setting things up through the admin UI. If
you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Schema.org Organization.

## How to use it

Configuration happens inside the Metatag UI, not a page of this module's own:

1. Install and enable the module (see [Installation](installation/index.md)).
2. Navigate to a metatag configuration page — for example the **global**
   (`/admin/config/search/metatag/global`) or **front page**
   (`/admin/config/search/metatag/front`) defaults, or a content type's metatag
   settings.
3. Expand the **Schema.org Organization** section — the 15 new Schema Hospital
   fields appear alongside the existing Organization fields.
4. Fill in the fields you need (using **tokens** where the values come from other
   entities or from a Config Pages entity), then **save and clear the cache**.

When configured, your page emits an Organization/`Hospital` JSON-LD object with the
extra healthcare properties included.

### Tip: managing organization data site-wide

For a single place to manage organization data, the module's docs recommend the
[Config Pages](https://www.drupal.org/project/config_pages) module: create a config
page type for the organization schema, add fields matching the Schema.org
properties, and reference them with tokens (for example
`[config_pages:organization_schema:field_org_email]`) in your metatag
configuration.
