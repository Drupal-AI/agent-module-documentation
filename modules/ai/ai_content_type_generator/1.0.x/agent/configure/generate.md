<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Content Type Generator — configure & use

**Prerequisite:** the AI (Artificial Intelligence) module with at least one chat-capable provider configured (OpenAI, Anthropic, …). This module stores no key of its own.

1. Enable: `drush en ai_content_type_generator`.
2. Settings — `/admin/config/ai/content-type-generator` (`administer ai content type generator`): pick provider/model and generation options.
3. Generate — `/admin/structure/types/ai-generator` (`generate ai content types`): describe the content type in plain English; the module validates the returned JSON and builds the bundle + fields + form/view displays.
4. Update — describe a change to an existing type ("add a Registration Link field, remove Organizer"); this also requires core **Administer content types**.

Optional field types depend on core modules being enabled: Datetime → `datetime`, Telephone → `telephone`, Link → `link`, File → `file`, Image → `image`, Options → `list_string`, Comment → a comment field.

Each generation is a billed provider call; restrict the generate permission to trusted site builders.
