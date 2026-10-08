<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Reference Actions adds a "bulk actions" control to entity-reference field widgets, letting an editor run any registered core/contrib **action** (publish, unpublish, delete, custom) against all the entities currently referenced by that field, straight from the entity edit form.

---

The module has **no permissions, no routes, and no config UI of its own** (`configure` is null). It works entirely through `hook_field_widget_complete_form_alter`: for any widget on an `EntityReferenceFieldItemListInterface` field it attaches an actions dropbutton (a `simple_actions` render element) next to the widget when the feature is enabled in that widget's **third-party settings** (set on *Manage form display*). The available actions are the `action` config entities whose type matches the field's `target_type`; a per-widget include/exclude list filters which ones appear. When the editor clicks an action, an AJAX submit (`EntityReferenceActionsHandler::submitForm`) loads the referenced entities, drops any the current user lacks access to (`$action->getPlugin()->access($entity, $currentUser)`), and either runs the action in a Batch (with a progress modal) or, for actions that declare a `confirm_form_route_name`, issues a sub-request to render that confirm form inside a modal dialog. A decorator on the AJAX response subscriber (`SubRequestAjaxResponseSubscriber`) and an `EmptyAttachmentsProcessor` keep the sub-request's AJAX commands working. Media Library widgets get special placement so the button sits beside the "Add media" control. Because actions and their per-entity access are enforced at execution time, the feature only exposes operations the acting user could already perform.

---

- Bulk-delete every entity referenced by a field directly from the host entity's edit form.
- Bulk-publish or unpublish all referenced nodes/media without opening each one.
- Run a custom content action against all items in an entity-reference field.
- Add bulk actions to a Media Library field so editors can act on all attached media at once.
- Apply an action to paragraphs or referenced entities selected via an autocomplete or checkboxes widget.
- Offer editors only a curated subset of actions on a given field (include list).
- Hide dangerous actions on a field by excluding them (exclude list).
- Rename the actions control per field via a custom "Action title".
- Trigger an action that has a confirmation step and have that confirm form open in a modal dialog.
- Process large reference sets safely through Drupal's Batch API with a progress modal.
- Reuse existing core actions (e.g. "Delete content", "Make content sticky") on referenced items.
- Reuse Views Bulk Operations-style actions outside of a View, on a single field.
- Let editors clear out all referenced items in one click instead of removing rows individually.
- Enforce per-entity access so users can only run actions on referenced items they may edit.
- Add the same bulk-action affordance to multiple reference fields on different bundles independently.
- Give content moderators a quick "unpublish all referenced" control on a curated-list field.
- Bulk-update a taxonomy-term reference field's targets using a term action.
- Provide bulk operations on user-reference fields (e.g. block/cancel referenced accounts) subject to access.
- Keep the referenced entities' own edit workflow while adding batch operations on top.
- Configure the actions button visibility to follow the widget's state (single vs multiple values).
- Attach bulk actions to inline-entity-form / paragraphs reference widgets.
