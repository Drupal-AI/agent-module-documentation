# Account Field Split — agent index

Splits core's bundled "User name and password" account element into seven independently
manageable pseudo-fields on the user Manage form display. No settings form, no permissions,
no config schema, no Drush commands, no plugins — all state lives in the standard
`core.entity_form_display.user.user.default` config entity.

- **Arrange / hide / reorder the account fields** → [configure/form-display.md](configure/form-display.md)
- **How the split works (hooks, service, the seven fields)** → [api/extra-fields.md](api/extra-fields.md)
