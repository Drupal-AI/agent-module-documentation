# select_or_other — agent start

Adds an "Other" write-in option to a select list, radios, or checkboxes; picking it reveals a
free-text field. Ships as two field widgets (Manage form display) and two Forms API `#type`
elements. No modules required outside core; no admin config route, no permissions, no Drush.

- Use the widget on a list / entity-reference field (settings, allowed-values growth,
  auto-create) → [configure/select_or_other.md](configure/select_or_other.md)
- Use the `#type` render elements in custom form code (properties, return values) →
  [api/select_or_other.md](api/select_or_other.md)
