<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate Process Markdown to HTML provides a Migrate process plugin for converting Markdown to HTML during migrations.

---

Migrate Process Markdown to HTML provides a Migrate process plugin that converts Markdown-formatted
source values into HTML during a migration — so content authored/stored as Markdown in a source system
becomes HTML in Drupal. It depends on the Migrate module and is used within migration definitions.

Use it in migrations importing Markdown content. It is a developer/migration tool operating in the Migrate
pipeline (Drush-driven); the Markdown source is admin-defined migration input. The converted HTML becomes
field content, so — as always — ensure it is stored against an appropriate text format and rendered
through Drupal's filter system (so any HTML is subject to the text format's XSS filtering on output),
rather than output raw. Configure the process plugin in the migration.

---

- Convert Markdown to HTML in migrations.
- Provide a Migrate process plugin.
- Import Markdown content as HTML.
- Depend on the Migrate module.
- Use in migration definitions.
- Run in the Migrate pipeline.
- Store converted HTML with a text format.
- Render through Drupal's filters.
- Subject HTML to XSS filtering on output.
- Handle admin-defined migration input.
- Not output raw HTML.
- Configure the process plugin.
- Migrate Markdown-authored content.
- Transform source values.
- Convert markup during import.
- Support content migrations.
- Process Markdown fields.
- Use with Drush migrations.
- Map Markdown to HTML.
- Import formatted content.
