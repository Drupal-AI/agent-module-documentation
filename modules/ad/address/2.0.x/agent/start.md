# address — agent start

Compound field type for international postal addresses, powered by the
`commerceguys/addressing` library (Google i18n data). Provides field types
`address`, `address_country`, `address_zone` with widgets + formatters. Depends on
core `field`. No permissions, no Drush, no custom plugin types.

- Add an address field & its per-field settings (available countries, field overrides, language) → [configure/field-settings.md](configure/field-settings.md)
- Call repositories / helpers in code (formats, countries, subdivisions, postal labels) → [api/services.md](api/services.md)
- Alter formats / countries / subdivisions via events → [hooks/events.md](hooks/events.md)
- Use the standalone `#type => 'address'` render element → [extend/render-elements.md](extend/render-elements.md)
- Theme rendered address output (templates, suggestions) → [theming/address-output.md](theming/address-output.md)
