# Rules events

Declared in `apigee_edge_actions.rules.events.yml`. Each base event has a **deriver** in
`src/Plugin/RulesEvent/` that creates one concrete event per applicable Apigee entity type, so in the
Rules UI you pick e.g. "After saving a new Developer App". Concrete event name =
`{base_event}:{entity_type_id}`.

| Base event | Deriver | Fires when | Applies to |
|---|---|---|---|
| `apigee_edge_actions_entity_insert` | `EdgeEntityInsertEventDeriver` | an Apigee entity is created | `developer_app`, `team_app`, `team`, … |
| `apigee_edge_actions_entity_update` | `EdgeEntityUpdateEventDeriver` | an Apigee entity is updated | same |
| `apigee_edge_actions_entity_delete` | `EdgeEntityDeleteEventDeriver` | an Apigee entity is deleted | same |
| `apigee_edge_actions_entity_add_member` | `EdgeEntityAddMemberEventDeriver` | a member is added to a team | `team` |
| `apigee_edge_actions_entity_remove_member` | `EdgeEntityRemoveMemberEventDeriver` | a member is removed from a team | `team` |
| `apigee_edge_actions_entity_add_product` | `EdgeEntityAddProductEventDeriver` | an API product is added to an app | `developer_app`, `team_app` |
| `apigee_edge_actions_entity_remove_product` | `EdgeEntityRemoveProductEventDeriver` | an API product is removed from an app | `developer_app`, `team_app` |

Examples of concrete event ids: `apigee_edge_actions_entity_insert:developer_app`,
`apigee_edge_actions_entity_add_member:team`, `apigee_edge_actions_entity_add_product:team_app`.

## How they're dispatched
- Entity insert/update/delete events are dispatched from `apigee_edge_actions.module` hooks off the
  Apigee entity lifecycle.
- `add_product` / `remove_product` are dispatched by `AppCredentialEventSubscriber`
  (service `apigee_edge_actions.events_subscriber`), which listens to the Apigee SDK app-credential
  events and re-emits them as Rules events with the app + product as context.
- Which entity types a deriver covers is resolved through `ApigeeActionsEntityTypeHelper`
  (`apigee_edge_actions.edge_entity_type_manager`).

Each event provides the changed entity (and, for member/product events, the related member/product)
as Rules context variables you can use in conditions and actions.
