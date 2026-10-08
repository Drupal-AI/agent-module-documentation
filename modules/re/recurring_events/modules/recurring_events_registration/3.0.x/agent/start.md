# Recurring Events Registration — agent index

Adds event registration: the `registrant` entity, capacity/waitlist logic, series-vs-instance
registration, and configurable notification emails. Depends on `recurring_events`. Configure route
`registrant.settings` (`/admin/structure/events/registrant/settings`).

- **Registrant entity, settings & notifications config, routes** → [configure/settings.md](configure/settings.md)
- **`RegistrationCreationService` + `NotificationService` API** → [api/services.md](api/services.md)
- **Alter hooks (waitlist, notifications)** → [hooks/hooks.md](hooks/hooks.md)
- **Permissions (incl. anonymous UUID edit/delete)** → [permissions/permissions.md](permissions/permissions.md)

Submodule:
- `recurring_events_reminders` → [modules/recurring_events_reminders/3.0.x/agent/start.md](../../modules/recurring_events_reminders/3.0.x/agent/start.md)

Key facts:
- Entity `registrant` (bundle `registrant_type`); default fields first/last name + phone.
- Register at `/events/{eventinstance}/registrations/add`; anonymous edit/delete via
  `/.../{registrant}/{uuid}/edit|delete` (UUID must match the registrant's own uuid).
- Services (`shared: false`): `recurring_events_registration.creation_service`,
  `...notification_service`; config `recurring_events_registration.registrant.config`.
