# clientside_validation_jquery — agent start

Engine submodule of **clientside_validation** (`part_of` it). Loads the jQuery Validate plugin and
enforces the `data-rule-*` / `data-msg-*` attributes the base module writes. Depends on
`clientside_validation`. Config UI:
**Admin → Config → User interface → Clientside Validation jQuery Settings**
(`/admin/config/user-interface/clientside-validation-jquery-settings`, route
`clientside_validation_jquery.settings_form`, config `clientside_validation_jquery.settings`).

- Settings keys, CDN vs local library, per-form behavior → [configure/clientside_validation_jquery.md](configure/clientside_validation_jquery.md)
- Manage the jQuery Validate library (download/status/remove) → [drush/clientside_validation_jquery.md](drush/clientside_validation_jquery.md)
- Libraries, glue JS, `cv-validate-before-ajax`, CKEditor/IFE → [theming/clientside_validation_jquery.md](theming/clientside_validation_jquery.md)
- Base module & the `CvValidator` plugin type → [../../../../4.1.x/agent/start.md](../../../../4.1.x/agent/start.md)
