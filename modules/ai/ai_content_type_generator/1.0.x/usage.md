<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Content Type Generator turns a plain-English description into a working Drupal content type with matching fields, using whichever provider the AI (Artificial Intelligence) module has configured.
---
A site builder describes a content type (e.g. "an Event content type with a summary, a date, a venue, and a category reference") and the module sends the prompt to the configured AI provider, validates the returned JSON definition, then builds and saves a content type with matching fields plus form and view-display components. It can also modify an existing content type in place ("add a Registration Link field and remove the Organizer field"). Optional core modules (Datetime, Telephone, Link, File, Image, Options, Comment) unlock the corresponding generated field types.

The module never talks to a provider directly and never stores an API key — it delegates entirely to AI Core (`$provider->chat()` in `AiGenerationService`), so credentials, TLS, and billing are AI Core's concern; requests are billed to that provider's plan. Two permissions gate it: `generate ai content types` for the generator form at `/admin/structure/types/ai-generator`, and the restricted `administer ai content type generator` for provider/model settings at `/admin/config/ai/content-type-generator`. Updating an existing content type additionally requires core's "Administer content types" permission. Because generation drives paid AI calls, grant the generate permission only to trusted site builders.
---
- Generate a new content type from a natural-language description.
- Add matching fields (summary, date, venue, reference, etc.) automatically.
- Create form-display and view-display components for the generated fields.
- Update an existing content type by describing the change in English.
- Add or remove fields on an existing bundle via a prompt.
- Unlock datetime fields by enabling core Datetime.
- Unlock telephone, link, file, image, or list fields via their core modules.
- Add a comment field (and comment type) to a generated content type.
- Reuse any AI Core chat provider (OpenAI, Anthropic, etc.) with no extra credentials.
- Validate the AI's JSON definition before building anything.
- Choose the provider and model from the settings form.
- Restrict who can run generation via the `generate ai content types` permission.
- Keep provider settings admin-only via a restricted permission.
- Require core "Administer content types" for in-place updates.
- Prototype a content model quickly from a spec.
- Standardize field naming from a described schema.
- Avoid hand-building repetitive field sets.
- Bill generation to the site's existing AI provider plan.
- Iterate on a content type conversationally.
