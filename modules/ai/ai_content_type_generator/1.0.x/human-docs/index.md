# AI Content Type Generator — manual setup guide

**AI Content Type Generator** (`ai_content_type_generator`) turns a plain-English
description into a working Drupal content type. You describe what you want — "an
Event content type with a summary, a date, a venue, and a category reference" — and
the module asks the site's configured AI provider for a definition, validates the
JSON it gets back, and then builds and saves the content type with matching fields,
plus the form-display and view-display components to go with them. It is a fast way
to scaffold a content model instead of clicking through the field UI by hand.

It also **updates existing content types**. Describe a change — "add a Registration
Link field and remove the Organizer field" — and it applies it to the bundle. In
that in-place mode it also requires core's *Administer content types* permission,
since it is editing an existing structure.

The module never talks to an AI provider directly and **stores no API key of its
own** — it delegates entirely to **AI Core** (the AI module), so credentials, TLS,
and billing are all AI Core's concern and each generation is billed to that
provider's plan. Because generation drives paid AI calls, the `generate ai content
types` permission should be granted only to trusted site builders. The module
depends on core Node, Field, and Text plus the AI module, and works on Drupal 10.3+
and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm the AI module and a provider are in place.
2. [Configuration](configuration/index.md) — the settings form, the generator, and
   which optional core modules unlock which field types.

## Where it lives in the admin menu

- **Settings:** **Configuration → AI → Content Type Generator**
  (`/admin/config/ai/content-type-generator`), gated by the restricted **Administer
  AI content type generator** permission — this is where you pick the provider,
  model, and generation options.
- **Generator:** **Structure → Content types → AI generator**
  (`/admin/structure/types/ai-generator`), gated by the **Generate AI content
  types** permission — this is where you describe a content type and build it.
