# Salesforce Example — agent index

Developer **demonstration** module for the Salesforce suite. Ships an example mapping, a
"Hardcoded Value" field plugin, and an event subscriber showing the suite's events. No config
or permissions of its own. Depends on `salesforce_push`, `salesforce_mapping`.

Small enough to read directly; the pieces:

- **Example mapping** — `salesforce_mapping` config entity `salesforce_example_contact`:
  Drupal `user` ↔ Salesforce `Contact`, with `properties` field mappings (mail→Email,
  name→LastName).
- **Hardcoded field plugin** — `SalesforceMappingField` id **`hardcoded`** ("Hardcoded
  Value"): maps a constant value to a Salesforce field (e.g. tag every record with a fixed
  value). Use it in a mapping's `field_mappings` with
  `drupal_field_type: hardcoded`.
- **Event subscriber** — `SalesforceExampleSubscriber` demonstrates handling
  `SalesforceEvents`: `PUSH_PARAMS` (alter params), `PUSH_ALLOWED` (veto a push),
  `PUSH_SUCCESS` / `PUSH_FAIL`, `PULL_QUERY` / `PULL_PREPULL` / `PULL_PRESAVE`.
- Also: an example Apex endpoint file and a `hook_entity_insert` example.

For the mapping model and field plugins see `salesforce_mapping`
(`configure/mapping.md`, `plugins/field-plugins.md`); for events see `salesforce`
(`api/client.md`).
