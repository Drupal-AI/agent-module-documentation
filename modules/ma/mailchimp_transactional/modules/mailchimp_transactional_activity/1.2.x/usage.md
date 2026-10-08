Mailchimp Transactional Activity adds a per-entity "Mailchimp Transactional Activity" tab that shows the email delivery history (from the Mailchimp Transactional API) for any entity that has an email-address field.

---

This submodule of Mailchimp Transactional defines a `mailchimp_transactional_activity` **config entity type**. Each Activity entity maps a Drupal entity type + bundle to the property that holds an email address (e.g. `user` / `user` / `mail`), plus an entity path and an enabled flag. For every enabled Activity config, `ActivityRoutes::routes()` dynamically registers a route `entity.<entity_type>.activity` at `<entity_type>/{entity}/activity`, gated by the `view mailchimp transactional activity` permission; `ActivityController::overview()` then calls the Mailchimp Transactional API (`getMessages()`) for the entity's email value and renders the recent messages. You manage the mappings at *Configuration → Web Services → Mailchimp Transactional → Activity Entities* (`admin/config/services/mailchimp_transactional/activity`, permission `administer mailchimp transactional activity`, and the shared configuration access check requiring an API key). The activity data itself comes from the external API, but the mappings are ordinary local config entities.

---

- Show a "Mailchimp Transactional Activity" tab on each user profile listing emails sent to that user.
- Track delivery/open/bounce history per customer entity that stores an email address.
- Map the User entity's `mail` property to an activity report for support staff.
- Add an activity report to a custom "Contact" entity via its email field.
- Give editors per-node activity when a content type has an email field.
- Restrict who can see delivery history with the `view mailchimp transactional activity` permission.
- Enable/disable an activity mapping without deleting it (the `enabled` flag).
- Configure multiple entity types (users, contacts, orders) to each show their own activity tab.
- Debug why a specific recipient is not receiving mail by inspecting their message history.
- Provide a self-service "your email history" view keyed off the user's account email.
- Audit transactional email per entity for compliance.
- Point the activity lookup at a non-default email property (any string property holding an email).
- Surface bounce/rejection status inline on the entity page.
- Combine with the base module's denylist to control what content is viewable in the history.
- Add activity reporting to a newly created entity type by adding one config entity.
- Export the activity mappings as config for deployment across environments.
- Turn off all activity tabs quickly by disabling each mapping.
- Give account managers a per-contact delivery timeline without leaving Drupal.
- Verify a campaign reached a particular user by opening their activity tab.
- Limit activity visibility to admins by only granting the view permission to trusted roles.
