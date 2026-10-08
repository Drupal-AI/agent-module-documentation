<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Browser Multi Widget adds an "Entity browser (multi)" field widget that puts several native Entity Browser launchers on one entity reference field, all writing into the same selection.

---

Entity Browser Multi Widget extends Entity Browser's stock reference widget so that a single entity reference field can offer more than one browse/upload button. Each enabled Entity Browser renders its own launcher, but every launcher writes into the same hidden selection target, so editors can mix sources (media library, document browser, existing-content view, upload flow) and still build one selection list. The launchers are enabled and ordered in the widget's own settings form via a sortable drag-and-drop table, with the first enabled launcher styled as the primary button and button labels taken from each browser's modal link text. It depends on core Field and the Entity Browser module, requires Drupal 11.4+ and PHP 8.3+, and adds no admin page, route, entity, or permission — all configuration lives on a field's Manage form display. Because it subclasses the stock widget, it inherits Entity Browser's selection and access handling and adds no access-control role of its own.

---

- Let editors pick from several Entity Browsers on one entity reference field.
- Combine a media library launcher and a documents launcher on the same field.
- Offer "browse existing content" alongside "upload new file" for one field.
- Keep separate curated Entity Browser Views side by side on a single field.
- Add multiple browse buttons without writing a custom field widget.
- Have all launchers contribute to one shared selection list.
- Order launcher buttons with a drag-and-drop table in widget settings.
- Enable or disable each available Entity Browser per field via checkboxes.
- Make the first enabled browser the primary (Save-styled) button.
- Reuse each browser's modal link text as its button label.
- Inherit stock Entity Browser options: field widget display, edit, remove, replace.
- Inherit Entity Browser's selection mode (append vs. replace) setting.
- Attach the multi-widget to any entity_reference field on any form display.
- Give editors different browse flows for different entity types on one field.
- Provide multiple upload sources for a gallery or attachments field.
- Let a page-reference field browse both articles and landing pages via two Views.
- Present distinct DAM sources as separate launcher buttons.
- Style the launcher bar consistently across admin themes, with Gin spacing when Gin is active.
- Extend the widget in a custom module to add toolbar chrome on top of the launchers.
- Migrate a single-launcher Entity Browser field to multi-launcher without changing the field itself.
- Keep selection UX identical to stock Entity Browser while adding launcher choice.
- Support content editors who need more than one media/entity source per field.
