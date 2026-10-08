# Mailchimp Transactional Activity — agent index

Submodule of **mailchimp_transactional**. Adds a per-entity "Mailchimp Transactional Activity" tab
showing an entity's email delivery history from the Mailchimp Transactional API. Depends on the
base module; the activity data is external but the mappings are local **config entities**.

- **The `mailchimp_transactional_activity` config entity, its fields, admin route, permissions,
  and dynamic routing** → [configure/activity-entities.md](configure/activity-entities.md)

Key facts:
- Config entity type id `mailchimp_transactional_activity` (class `Entity\Activity`), config prefix
  `mailchimp_transactional_activity.mailchimp_transactional_activity.<id>`. Exported keys:
  `id`, `label`, `entity_type`, `bundle`, `entity_path`, `email_property`, `enabled`.
- Admin/list route `mailchimp_transactional_activity.admin` at
  `admin/config/services/mailchimp_transactional/activity`.
- Permissions: `administer mailchimp transactional activity` (manage mappings, restricted),
  `view mailchimp transactional activity` (see the per-entity tab).
- Dynamic per-entity route `entity.<entity_type>.activity` at `<entity_type>/{entity}/activity`
  built by `Routing\ActivityRoutes::routes()` for each enabled mapping; rendered by
  `Controller\ActivityController::overview()` (calls the API `getMessages()`).
- No plugin type, no Drush.
