<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Automatically title-cases selected entity field values when an entity is saved or updated, skipping strings you exclude.

---

Entity Field Capitalization normalizes the case of chosen field values as content is written, not on display. You list `ENTITY_TYPE,BUNDLE,FIELD_NAME` combinations on its settings form and, from then on, `hook_entity_presave()` runs each listed field's stored value through a service that capitalizes the first letter of every word (a UTF-8-safe title case), leaving any words in your comma-separated exclusion list (for example `iPod,jQuery`) untouched. Because the transformed value is stored on the entity, the consistent casing shows up everywhere the field is rendered, and existing content is only rewritten the next time it is saved. The module works on any content entity type and bundle, has no module dependencies, ships one settings form (route `entity_field.capitalization_settings` at `/admin/config/field-capitalization-settings`, gated by the core `administer site configuration` permission) and one service (`entity_field.capitalization`), and supports Drupal 8 through 11.

---

- Force node titles to a consistent title case across all editors.
- Title-case article, page, or other node-bundle text fields on save.
- Normalize taxonomy term names as they are created or edited.
- Capitalize a person's first-name and last-name fields on a user or profile entity.
- Standardize company or organization name fields at write time.
- Keep product titles or SKUs' descriptive text uniformly capitalized.
- Clean up casing on content imported by editors who type inconsistently.
- Apply consistent case to multiple fields across several entity types from one config screen.
- Exclude brand names like `jQuery`, `iPod`, or `iPhone` from being "corrected".
- Preserve acronyms or camel-cased terms by adding them to the exclusion list.
- Enforce editorial style guides without training every content author.
- Reduce manual proofreading of capitalization in titles and headings.
- Ensure menu labels derived from node titles inherit consistent casing.
- Capitalize address or location text fields (city, region) on save.
- Tidy event names or session titles for a conference/event site.
- Normalize job titles or department names in a staff directory.
- Make listing/teaser views look uniform because the stored value is already cased.
- Apply the same casing rule to a field shared by many bundles by listing each combination.
- Retro-fit consistent casing to legacy content by bulk re-saving affected entities.
- Keep multilingual content casing correct using the module's UTF-8-aware transform.
- Avoid custom presave code by configuring capitalization through the admin UI instead.
- Guarantee headings read consistently regardless of which display or theme renders them.
