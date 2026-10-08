<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Reference Modal is a field widget that extends core's entity-reference autocomplete with an "Add new" button that creates the referenced entity in a modal and an optional Bootstrap-table search dialog for picking existing ones.

---

The module registers a single field widget plugin, `entity_reference_modal` (label "Autocomplete (add new with Modal)"), that subclasses core `EntityReferenceAutocompleteWidget` and is selectable on any `entity_reference` field's Manage form display. On top of the normal autocomplete textfield it renders a `dropbutton` beneath the field whose links come from the field's `handler_settings`: one "Add new" link per referenceable target bundle (a bundle link is only rendered if the current user passes the target type/bundle `createAccess()` check) and, when the "Button search" setting is on, a search (🔎) link. The Add-new link is a `use-ajax` button with `data-dialog-type=modal` pointing at route `entity_reference_modal.entity_form` (`/entity-reference-modal/form/{entity_type}/{bundle}`); its controller `EntityReferenceModalController::build()` builds the target entity's form (honouring the configured form mode, falling back to the default form handler when the mode has no handler) and its `::access()` method requires the request to be a Drupal modal/AJAX request and then defers to the entity access handler's `createAccess()`. `hook_form_alter()` injects an AJAX submit callback (`entity_reference_modal_submit`) on that modal form: on validation error it replaces the form via `ReplaceCommand`; on success it saves the new entity (or, unless "Duplicates allowed" is set, reuses an existing entity with the same label found via an access-checked `entityQuery`) and returns an `InvokeCommand` that calls the `injectEntity` jQuery plugin (in `js/entity-reference-modal.js`) to write `label (id)` back into the originating input and close the dialog. The search dialog is driven by `js/entity-reference-search.js`, which builds a `bootstrap-table` whose `data-url` is route `entity_reference_modal.search` (`/entity-reference-modal/search/{target_type}/{selection_handler}/{selection_settings_key}`); the widget precomputes column definitions from the field's selection handler or a chosen Entity-Reference view display, stores the selection settings in the `entity_autocomplete` key-value store under an HMAC key (`Crypt::hmacBase64` with the site hash salt), and `EntityReferenceModalController::fieldReference()` returns the rows as JSON — either by instantiating the entity-reference selection plugin and calling `getReferenceableEntities()`, or, for a views handler, by executing the view and `advancedRender()`-ing its fields. Widget settings (config schema `field.widget.settings.entity_reference_modal`) cover the button label (HTML allowed), modal width/title, form mode, "Duplicates allowed", search on/off, a view/display override for search, a "Load bootstrap" CDN toggle, and an experimental (disabled) Tagify toggle. Optional libraries — Bootstrap 5, Bootstrap-table, and Tagify — are loaded from the jsDelivr CDN. The module also implements `hook_help()` (via the `EntityReferenceModalHook` OOP hook class) to render its README.

---

- Create a referenced entity from within the parent form without navigating away.
- Add a new taxonomy term while tagging an article.
- Add a new author/organisation node while editing content that references it.
- Let editors create a referenced media or paragraph target inline via a modal.
- Pick an existing referenced entity from a searchable, filterable Bootstrap-table dialog.
- Search referenceable entities using the columns of a configured Entity-Reference view display.
- Choose the form mode used to build the create-new modal form per widget.
- Customise the modal's width, title, and the "Add new" button label (including HTML markup).
- Offer one "Add new" button per allowed target bundle on a multi-bundle reference field.
- Suppress duplicate targets by reusing an existing entity that shares the new label.
- Allow intentional duplicates via the "Duplicates allowed" setting.
- Respect per-bundle create access so editors only see Add buttons for bundles they may create.
- Replace the parent form's default autocomplete widget on any entity_reference field.
- Speed up reference-heavy data entry by keeping create/select in one dialog.
- Load Bootstrap 5 from CDN on non-Bootstrap admin themes for consistent modal styling.
- Reduce form abandonment when a needed target entity does not yet exist.
- Provide a lighter-weight alternative to Inline Entity Form for the create-new case.
- Render referenced-entity search results as JSON for a client-side table UI.
- Configure everything from Manage form display without writing code.
