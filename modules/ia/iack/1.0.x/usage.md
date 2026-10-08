<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
IA Creation Kit (iack) turns a spreadsheet describing your site's information architecture into AI prompts that instruct an AI agent to create the corresponding vocabularies, content types, and fields.
---
The module provides an admin form at `/admin/config/ai/iack` (permission `upload information architecture`, `restrict access: TRUE`) where an administrator uploads an XLSX workbook (a template ships at `template/iatemplate.xlsx`). The `IackHelper` service parses sheets such as "Taxonomy terms", "Vocabulary", and "Fields" (using PHPSpreadsheet) and builds natural-language prompts — e.g. "Create Taxonomy vocabulary — X" and "Add the following terms…". Those prompts are then sent through the AI Assistant API runner (`ai_assistant_api.runner`) so an AI agent can execute the structural changes.

Because the module drives an AI agent that can create content types, fields, and taxonomy, it is a powerful administrative capability and its permission is marked restricted — grant it only to trusted admins. It depends on the `ai_agents` and `ai_assistant_api` modules (part of the Drupal AI ecosystem) and on `phpoffice/phpspreadsheet`. The heavy lifting (and any external LLM calls) happens inside the configured AI provider/assistant, not in this module.

Typical setup: install with Composer (pulls PHPSpreadsheet), configure an AI assistant/provider, fill out the IA template spreadsheet, then upload it at the iack form and let the agent build the structures.
---
- Generate a site's content types from a spreadsheet.
- Create taxonomy vocabularies and terms via AI from a workbook.
- Define fields for content types described in an XLSX file.
- Bootstrap a new site's information architecture with AI.
- Use the shipped `iatemplate.xlsx` as a starting point.
- Convert an IA spec document into executable AI prompts.
- Drive the AI Assistant API runner from structured input.
- Restrict IA generation to trusted administrators.
- Speed up prototyping of a content model.
- Translate a stakeholder spreadsheet into Drupal structures.
- Parse multiple sheets (Vocabulary, Taxonomy terms, Fields).
- Batch-create taxonomy terms grouped by vocabulary.
- Reduce manual clicking through the field UI.
- Pair with an AI provider to execute structural changes.
- Iterate on IA by re-uploading an updated workbook.
- Standardize IA creation across projects via a template.
- Hand IA definition to non-developers via a spreadsheet.
- Prompt an agent to create machine names and descriptions.
- Integrate AI-assisted scaffolding into a build workflow.
- Audit the restricted permission during security review.
