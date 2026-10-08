Salesforce Example is a developer demonstration module for the Salesforce suite: it ships an example User↔Contact mapping, a "Hardcoded Value" field-mapping plugin, and an event subscriber showing how to react to Salesforce push/pull events.

---

The module is for learning, not production. It installs an example `salesforce_mapping` config entity `salesforce_example_contact` mapping the Drupal `user` entity to the Salesforce `Contact` object (with `properties` field mappings like mail→Email, name→LastName). It provides a `SalesforceMappingField` plugin `hardcoded` ("Hardcoded Value") that maps a constant value to a Salesforce field (useful for tagging records with a fixed value). It also ships a `SalesforceExampleSubscriber` event subscriber demonstrating the suite's events (`PUSH_PARAMS`, `PUSH_ALLOWED`, `PUSH_SUCCESS`, `PUSH_FAIL`, `PULL_PREPULL`, `PULL_PRESAVE`, `PULL_QUERY`) — e.g. altering push params or filtering pull queries — plus an example Apex endpoint file and a `hook_entity_insert` example. It has no configuration or permissions of its own. Depends on `salesforce_push` and `salesforce_mapping`.

---

- Learn how a Drupal↔Salesforce mapping is structured (User↔Contact example).
- See how to map a Drupal field/property to a Salesforce field.
- Map a constant/fixed value to a Salesforce field with the hardcoded plugin.
- Tag pushed records with a hardcoded source/campaign value.
- Learn how to subscribe to Salesforce push events (params/allowed/success/fail).
- Alter push parameters before they are sent (PUSH_PARAMS).
- Prevent a push conditionally (PUSH_ALLOWED).
- React to push success/failure for custom logging.
- Modify the pull query or pulled records (PULL_QUERY / PULL_PREPULL / PULL_PRESAVE).
- Use as a template for a custom SalesforceMappingField plugin.
- Copy the example subscriber as a starting point for integrations.
- Understand the events the suite dispatches.
- See an example Apex endpoint pattern.
- Provide a ready-made mapping for demos/testing.
- Explore field-mapping directions (sync / push / pull).
- Bootstrap a proof-of-concept Salesforce integration.
- Teach the suite's push flow end to end.
- Demonstrate hook_entity_insert with Salesforce.
- Serve as documentation-by-example for developers.
- Verify a mapping works before writing your own.
