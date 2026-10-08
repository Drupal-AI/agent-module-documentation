# Salesforce Address — agent index

Provides one field widget, **`salesforce_ready_address`** ("Salesforce-ready Address"), for
`address` fields: renders the street as a single **textarea** to match Salesforce's multi-line
street storage, easing address mapping. No config/permissions/plugins/Drush of its own.
Depends on the `address` module.

- **The widget and how to apply it** →
  [api/widget.md](api/widget.md)

Key facts:
- Widget id `salesforce_ready_address` (`AddressDefaultWidgetStreetAsTextArea`), for field type
  `address`.
- Select it on an entity's Manage form display for an address field (config
  `core.entity_form_display.<entity>.<bundle>.<mode>` → `content.<field>.type =
  salesforce_ready_address`).
- Purpose: Salesforce address fields store one multi-line street; the textarea captures it in
  one value for clean push/pull mapping.
