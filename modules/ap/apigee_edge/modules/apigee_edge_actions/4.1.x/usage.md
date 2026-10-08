Apigee Edge Actions adds Rules integration to the Apigee Edge module. It turns Apigee entity changes
— apps created/updated/deleted, API products added or removed from an app, members joining or leaving
a team — into Rules events, so site builders can automate reactions such as emails or log entries
without writing code.

---

The module registers seven base Rules events (`apigee_edge_actions_entity_insert`, `_update`,
`_delete`, `_add_member`, `_remove_member`, `_add_product`, `_remove_product`), each with a deriver
that produces one concrete event per applicable Apigee entity type (for example
`apigee_edge_actions_entity_insert:developer_app`). Entity lifecycle events come from module hooks,
while product add/remove events are re-emitted from Apigee app-credential SDK events by an event
subscriber. It also ships an Apigee-aware "Log a message" Rules action, an override of Rules' send-
email-to-role action, and tokens that expose the triggering entity and its related member/product. A
companion examples submodule installs sample reaction rules. It depends on `apigee_edge` and `rules`.

---

- Email site admins whenever a new developer app is created.
- Notify a developer by email when they are added to a team.
- Email a developer when a new app is added under their account.
- Log a message whenever a team is deleted.
- React when an API product is added to a developer app.
- React when an API product is removed from a team app.
- Send an email to all users of a given role from an Apigee event.
- Automate onboarding steps when a developer registers an app.
- Warn admins when an app's product associations change.
- Build custom reaction rules on any Apigee app/team/product lifecycle event.
- Use tokens for the app name, developer email, team, or product in notification emails.
- Trigger a webhook (via another Rules action) when a team membership changes.
- Kick off a moderation workflow when a team app is created.
- Clone the bundled example rules as a starting point for your own automations.
- Log Apigee entity changes to a dedicated logger channel for auditing.
- Trigger integrations in other modules that expose Rules actions, on Apigee events.
