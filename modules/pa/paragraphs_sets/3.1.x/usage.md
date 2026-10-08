Paragraphs Sets lets editors insert a whole pre-configured group of paragraphs into a Paragraphs field in one click, instead of adding each paragraph one by one — ideal for repeatable page patterns (a hero + two columns + CTA, an FAQ block, etc.). Sets are `paragraphs_set` config entities managed at Structure → Paragraphs sets, and are offered on the stable Paragraphs widget.

---

The module adds a `paragraphs_set` config entity (config prefix `paragraphs_sets.set.*`, exported keys `id`, `label`, `icon_uuid`, `description`, `paragraphs`) that describes an ordered list of paragraphs — each an entry of `{bundle: <paragraph_type>, data: <field defaults>}`. In 3.1.x each item's `data` is stored as a YAML-encoded string (config schema `type: text`, so it is translatable via the Config Translation UI) and decoded/encoded transparently by `Drupal\paragraphs_sets\ParagraphsSets::decodeSetItemData()` / `encodeSetItemData()` and the entity's `preSave()` / `getParagraphs()`. Sets are created and edited through a full admin UI at `/admin/structure/paragraphs_set` (route `entity.paragraphs_set.collection`, add form `paragraphs_sets.set_add`, `ParagraphsSetForm`) — a Label, machine name, optional icon upload, description, and a YAML "Paragraphs configuration" textarea — all gated by the `administer paragraphs sets` permission. The module exposes three third-party settings on the stable `paragraphs` widget (`ParagraphsWidget`) via `hook_field_widget_third_party_settings_form()`: **Enable Paragraphs Sets** (`use_paragraphs_sets`), **Limit sets to** (`sets_allowed`), and **Default set** (`default_set`), stored (double-nested) under `third_party_settings.paragraphs_sets.paragraphs_sets` on that field's component in the `entity_form_display`. When enabled, a set selector plus a "Select set"/"Append set" button appears on the widget; picking a set clears/appends paragraphs pre-filled with the set's default field data. A set can also seed a field's default value on new entities (via **Default set**, which requires the widget's "Default paragraph type" to be "- None -"). Default values for primitive fields work out of the box; complex field values are supplied by implementing the alter hooks (`hook_paragraphs_set_data_alter()`, `hook_paragraphs_set_SET_data_alter()`, `hook_paragraphs_set_SET_FIELD_NAME_data_alter()`), and the set icon can be altered via `hook_paragraphs_sets_set_static_icon_uri_alter()`. In 3.1.x all hooks are OOP hook classes under `src/Hook/` (`FieldHooks`, `FormHooks`, `ThemeHooks`) using `#[Hook]` attributes — there is no `.module` file. It ships config schema, admin/modal CSS, templates, a modal add dialog, and no Drush commands. Requires Drupal `^11.4 || ^12` and Paragraphs `^1.13`.

---

- Insert a standard "landing section" (hero + columns + CTA) as one reusable set.
- Give editors a one-click FAQ block: several pre-added Q&A paragraphs.
- Pre-fill default text/values in a set's paragraphs so editors start from a template.
- Offer a curated list of page patterns per field by limiting which sets are allowed.
- Seed a Paragraphs field's default value with a set (via the widget's Default set option).
- Speed up authoring of repetitive multi-paragraph layouts.
- Restrict available sets on one field while allowing all sets on another.
- Provide a "two column with image" starter set for marketing pages.
- Standardise content structure across a team by shipping approved sets.
- Add an uploaded icon to a set so editors can visually pick a pattern.
- Build a component library of paragraph combinations without custom code.
- Create and edit sets through the admin UI at /admin/structure/paragraphs_set.
- Translate a set's default field values via the Config Translation UI (data is YAML/text).
- Supply complex/default field values programmatically via hook_paragraphs_set_data_alter().
- Customise defaults for a single set with hook_paragraphs_set_SET_data_alter().
- Customise a specific field's default within a set with hook_paragraphs_set_SET_FIELD_NAME_data_alter().
- Override a set's icon URI with hook_paragraphs_sets_set_static_icon_uri_alter().
- Let editors add a whole prepared section, then tweak the pre-filled content.
- Reduce clicks when building long structured pages with Paragraphs.
- Export/deploy content patterns as config (paragraphs_sets.set.* config entities).
- Enable sets only on the stable Paragraphs widget where it makes sense.
- Combine multiple sets on a page to assemble complex layouts quickly.
- Enforce a starting layout by making a set the field's default value.
- Add sets as append buttons inside the Paragraphs "modal" add dialog.
