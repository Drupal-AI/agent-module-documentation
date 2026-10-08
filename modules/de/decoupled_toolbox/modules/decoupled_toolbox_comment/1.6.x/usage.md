Decoupled Toolbox for Comment Field adds a decoupled field formatter so comment fields can be exposed as JSON through Decoupled Toolbox.

---

A one-plugin sub-module of Decoupled Toolbox. It provides the `decoupled_comment_field` field formatter (class `CommentFieldDecoupledFormatter`, extending `GenericDecoupledFormatter`) which you select on the **Decoupled** view mode for comment fields. Adds a `view_mode` setting (default `default`) so each referenced comment is rendered through the chosen comment view mode; view-mode options come from `EntityDisplayRepository::getViewModeOptionsByBundle('comment', <comment_type>)`. All the common decoupled formatter settings (decoupled field key, location, hide-if-empty, force-multiple) apply.

---

- Enable so comment fields appear with a decoupled formatter option on *Manage display → Decoupled*.
- Expose a comment field value in the `/decoupled-api/{type}/{bundle}/collection` JSON output.
- Rename the field to a clean API key via the Decoupled field key setting.
- Relocate the value in the JSON tree via the Decoupled field location setting.
- Omit the field when empty via the hide-if-empty setting.
