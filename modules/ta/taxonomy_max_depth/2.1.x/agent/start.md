# taxonomy_max_depth — agent start

Caps the term-hierarchy depth of a taxonomy vocabulary. The limit is a per-vocabulary
third-party setting (`third_party_settings.taxonomy_max_depth.max_depth`) exposed on the
vocabulary edit form and enforced by a validator on the term add/edit form. No permissions, no
Drush, no settings page. Enforcement is form-layer only — programmatic term creation is not
auto-validated.

## Capabilities

- [Configure the max depth (UI + config + third-party settings)](configure/setup.md) — where the
  setting lives, the `max_depth` values (0 = flat, empty = unlimited), config schema, and how the
  term-form validator enforces it.
- [Services & helper API](api/services.md) — the settings reader/writer service pair and the
  term tree depth helper you can call from your own code.
