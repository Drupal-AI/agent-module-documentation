<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ECA Webform bridges [ECA](https://www.drupal.org/project/eca) (Event–Condition–Action) with [Webform](https://www.drupal.org/project/webform), turning Webform's many alter/access hooks into ECA events and adding a handful of ECA actions for reading and writing submission data and webform third-party settings — so you automate Webform behaviour from ECA/BPMN models without writing a custom handler.

---

The module has two halves. First, a single derived ECA **event** plugin (base id `webform`, deriver `WebformEventDeriver`) mints one derivative per Webform hook — 25 in total, e.g. `webform:submission_form_alter`, `webform:submission_access`, `webform:element_alter`, `webform:options_alter`, `webform:handler_invoke_alter`, `webform:access_rules`, `webform:submissions_pre_purge`. Each derivative wraps a strongly-typed event class under `src/Event/` and exposes the hook's arguments to the model as tokens under the `webform` namespace (e.g. `[webform:element]`, `[webform:account]`, `[webform:submissions]`, `[webform:operation]`). The `eca_webform.module` file implements the matching `hook_webform_*` procedural hooks and forwards each to `src/Hook/WebformHooks.php`, which dispatches the corresponding event through ECA's `TriggerEvent` service; for the three "collector" events (`access_rules`, `element_input_masks`, `help_info`) an `AfterInitialExecutionEvent` subscriber (`EventSubscriber/EcaWebform.php`) reads the mutated token data back out of the model and writes it into the event so a model can *contribute* rules/masks/help. Second, four ECA **actions** (core `#[Action]` plugins, so they appear in the action plugin manager): `eca_webform_submission_get_data` and `eca_webform_submission_set_data` (type `webform_submission`) read/write a submission element value via `getElementData()`/`setElementData()`, and `eca_webform_get_third_party_setting` / `eca_webform_set_third_party_setting` (type `webform`) read/write a webform's third-party settings. All action config fields are token-aware. There is no admin UI, no configure route, no permissions and no Drush commands — you use everything from inside ECA models.

---

- React to a webform submission form being built with a `webform:submission_form_alter` event in an ECA model.
- Alter or hide individual form elements at render time via a `webform:element_alter` event.
- Change access to a webform submission programmatically with a `webform:submission_access` event.
- Dynamically rewrite a select/checkbox element's options using a `webform:options_alter` event.
- Contribute custom webform access rules from a model via the `webform:access_rules` collector event.
- Run automation just before submissions are purged with `webform:submissions_pre_purge`.
- Trigger follow-up logic after submissions are purged with `webform:submissions_post_purge`.
- Intercept a webform handler invocation with a `webform:handler_invoke_alter` event.
- Alter admin/element third-party-settings forms from ECA via the `*_third_party_settings_form_alter` events.
- Read a submitted field value into an ECA token with the `eca_webform_submission_get_data` action.
- Overwrite a submitted field value mid-workflow with the `eca_webform_submission_set_data` action.
- Copy one submission value into another element before save using get- then set-data actions.
- Compute a derived field (e.g. a reference number) and write it back into the submission.
- Store a webform's third-party setting from a model with `eca_webform_set_third_party_setting`.
- Read a webform's third-party setting into a token with `eca_webform_get_third_party_setting`.
- Send a notification or call a service when a specific webform is submitted, driven by an event model.
- Branch a model on the `[webform:operation]` token (view/update/delete) inside a submission-access event.
- Pre-fill or default an element value on form build using set-data plus a submission-form event.
- Add contextual help to webforms declaratively via the `webform:help_info` collector event.
- Alter available input masks for elements through the `webform:element_input_masks` events.
- Adjust image-select images for an element with `webform:image_select_images_alter`.
- Alter webform variant metadata from a model using `webform:variant_info_alter`.
- Modify submission query access (views/listing filters) via `webform:submission_query_access_alter`.
- Keep all Webform automation as declarative, exportable ECA config instead of a custom module.
- Prototype Webform behaviour changes in the ECA modeller without a deploy of PHP code.
- Chain a Webform submission event into other ECA actions (entity save, email, HTTP request).
