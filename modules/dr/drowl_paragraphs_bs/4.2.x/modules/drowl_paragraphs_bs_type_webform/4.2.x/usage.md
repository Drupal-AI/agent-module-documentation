<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a 'Webform' Paragraph bundle that embeds a Webform into content.

---

This sub-module installs the `webform` Paragraph type with a `webform` entity-reference field (`field_webform`) so editors can embed a Webform into Paragraphs-based content. It is rendered with the Webform module's entity-reference view formatter (`webform_entity_reference_entity_view`, `source_entity: true`), so submission handling, access and confirmation are all provided by the referenced Webform and the Webform module itself.

---

- Embed an existing Webform inside page-built content.
- Let the referenced Webform handle validation, submission and confirmation.
- Bind the paragraph as the submission source entity (source_entity: true).
- Let editors create new Webforms via the field's admin link (if permitted).
- Combine with field_settings for animation/classes/id.
- Enable only where editors need to place forms into Paragraphs.
