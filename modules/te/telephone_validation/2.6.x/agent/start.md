# telephone_validation — agent start

Adds libphonenumber-based validation to core Telephone fields and to `tel` form elements.
Opt-in per field via a "Telephone validation" fieldset (Enabled / Format / Country) on the
field settings form; validation runs through the `Telephone` constraint + the
`telephone_validation.validator` service. Depends on core `telephone`; requires the
`giggsey/libphonenumber-for-php` library. Site-wide defaults:
**Admin → Config → Content authoring → Telephone Validation**
(`/admin/config/content/telephone_validation`, route `telephone_validation.settings`).

- Enable validation on a field, set format/countries, global defaults → [configure/telephone_validation.md](configure/telephone_validation.md)
- Validate numbers in code + the `Validator` service API → [api/telephone_validation.md](api/telephone_validation.md)
- The `Telephone` validation constraint plugin → [plugins/telephone_validation.md](plugins/telephone_validation.md)
