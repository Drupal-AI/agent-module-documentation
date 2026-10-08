Action Link Field outputs an action link as a computed field on the entity type it targets, so you can position and format it like any other field in Manage Display.

---

This Action Link submodule (requiring the Computed Field module) provides the `computed_field` Action Link Output plugin. When enabled on an action link whose state action targets an entity with a single `entity` dynamic parameter, the module automatically attaches a computed field named `action_link_<id>` to the bundles of the target entity type. The field renders the action link's link set for the entity, and appears in the entity type's Manage Display so a site builder can place it, reorder it, and pick a formatter (Default, AJAX links, or Reload links). A deriver produces one computed-field plugin per eligible action link; the field attaches itself as a base field or bundle field to match the scope of the field the action link controls. Config-entity insert/update/delete on action links clears the computed-field and entity-field caches so the field is added or removed as settings change.

---

- Add a publish/unpublish toggle as a proper field on the article content type, placed above the body.
- Let site builders drag an action link into any position in Manage Display like a normal field.
- Choose the AJAX links formatter so the computed field updates in place when clicked.
- Choose the Reload links formatter for a no-JavaScript, page-reload action.
- Expose an increment/decrement numeric action link as a field on a product or listing entity.
- Show an options-cycling action link as a field on a taxonomy term or custom entity.
- Keep action links tied to the entity's field layout rather than injected via code or preprocess.
- Reuse the same action link across multiple bundles of an entity type by attaching it per bundle.
- Turn the field on/off simply by toggling the 'Computed field' output option on the action link's Output tab.
- Rely on the field only appearing on bundles that actually have the controlled field (scope matching).
