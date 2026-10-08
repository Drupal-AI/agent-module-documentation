<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Ephoto DAM Field adds a field type that stores an asset chosen from the Ephoto digital-asset-management library and renders a preview on the entity display.

---

Ephoto DAM Field (`ephoto_dam_field`) is a submodule of the Ephoto Dam project. It provides a Drupal field type whose widget opens the Ephoto asset chooser (using the Server URL configured by the parent `ephoto_dam` module) and stores the selected asset's URL together with its identifier, image size, version name, caption and thumbnail. A matching formatter renders a preview block showing the thumbnail, caption, link and metadata. It depends on core `field`, core `system`, and the parent `ephoto_dam` module, and targets Drupal 10 and 11. Use it when you want Ephoto assets attached to entities as structured field data rather than embedded inline in rich text.

---

- Add an "Ephoto Dam Field" to any content type, taxonomy term, or other fieldable entity.
- Store a chosen Ephoto asset's URL as a first-class field value.
- Capture the asset identifier, size, version and caption alongside the URL.
- Show a thumbnail preview of the selected asset while editing.
- Let editors pick an asset by clicking a "Select" button that opens the Ephoto chooser.
- Render an asset preview (thumbnail, caption, link, metadata) on the entity display.
- Enable version support so one label maps to a URL per Ephoto version.
- Define a caption format per field via the field settings.
- Constrain the size value to patterns like `500`, `500x`, `x500` or `500x500`.
- Support multi-value fields to attach several Ephoto assets to one entity.
- Reference remote Ephoto assets instead of uploading files into Drupal.
- Reuse the parent module's single Server URL configuration for the chooser.
- Migrate an inline CKEditor embed workflow toward a fielded, queryable workflow.
- Display the file identifier and version name as metadata bubbles in the preview.
- Provide a structured place to store DAM asset references for Views or templates.
- Keep asset governance centralised in Ephoto while modelling references in Drupal.
- Attach brand imagery to entities that need a single canonical asset field.
- Let non-technical editors select assets without knowing Ephoto URLs.
- Update an entity's asset by re-selecting from the chooser.
- Combine with the parent module's CKEditor 5 embedding for mixed workflows.
