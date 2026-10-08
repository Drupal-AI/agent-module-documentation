<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content-form SERP preview & metatag write-back

Implemented in `brightedge_autopilot_page_publisher.module`.

## `hook_form_alter()`

Runs on any form whose form object exposes `getEntity()` returning a `ContentEntityInterface`, on the
`edit` / `add` / `default` operation. It scans the entity's field definitions for the **first field of
type `metatag`**. When found it:

- Tags that metatag field with the CSS class `beapp-metatags-field-identifier` and attaches the
  library `brightedge_autopilot_page_publisher/beapp_meta_snippet`.
- Adds a `beapp_meta_snippet` fieldset ("Brightedge", `#weight 99`, `#tree TRUE`) containing:
  - `beapp_seo_title` (textfield) and `beapp_meta_desc` (textarea) pre-filled from the existing metatag
    value decoded via `metatag_data_decode()` (`title` / `description`).
  - `beapp_live_preview` — a `#markup` Google-SERP mock showing the site favicon (module asset
    `assets/images/earth-vector.png`), `system.site` name, the entity's URL slug (`toUrl()->toString()`),
    and the title/description (`htmlspecialchars`-escaped in the preview markup).
  - `beapp_cta` — a `#markup` call-to-action linking to the BrightEdge platform login.
- Registers the submit handler `beapp_metatags_form_submit` on both `actions.submit['#submit']` and
  the form-level `#submit`, and stashes the metatag field name in
  `$form_state->set('beapp_metatag_field_name', …)`.

## `beapp_metatags_form_submit()`

On save, reads `beapp_meta_snippet.beapp_seo_title` / `beapp_meta_desc`, compares each to its
`#default_value`, and only overwrites the corresponding key when the editor changed it. It decodes the
current metatag value (`metatag_data_decode`), sets `title` / `description`, re-encodes with
`metatag_data_encode`, `$entity->set(field, …)` and `$entity->save()`.

## Notes

- This path is the **only** UI the module adds; there is no admin config page. It affects only entities
  that already carry a metatag field (it does not create one here — unlike the update-meta REST
  endpoint, which does auto-create `field_meta_tags`).
- The preview is client-updated by `assets/js/BeAPPMetaSnippet.js` (library `beapp_meta_snippet`,
  deps `core/jquery`, `core/once`, `core/drupal`).
