# Configure Activity entities

## Admin UI

*Configuration → Web Services → Mailchimp Transactional → Activity Entities*
(`admin/config/services/mailchimp_transactional/activity`, route
`mailchimp_transactional_activity.admin`). Requires the `administer mailchimp transactional
activity` permission **and** the shared `_mailchimp_transactional_configuration_access_check`
(an API key must be set on the base module). Click **Add Activity Entity**, choose an entity type,
bundle, and the email property, leave it enabled, and Save.

Result: a "Mailchimp Transactional Activity" local task appears on entities of that type
(e.g. a user's page under *People*), showing that entity's email history.

## The config entity — `mailchimp_transactional_activity`

Class `Drupal\mailchimp_transactional_activity\Entity\Activity` (`@ConfigEntityType`,
`admin_permission = "administer mailchimp transactional activity"`). Config object name:
`mailchimp_transactional_activity.mailchimp_transactional_activity.<id>`. Exported fields
(schema `mailchimp_transactional_activity.schema.yml`):

| Field | Meaning |
|---|---|
| `id` | Machine name. |
| `label` | Human label. |
| `entity_type` | Drupal entity type id to attach the tab to (e.g. `user`, `node`). |
| `bundle` | Bundle id (e.g. `user`, `article`). |
| `entity_path` | Path base used to view the entity. |
| `email_property` | The property/field holding the email address to look up (e.g. `mail`). |
| `enabled` | Whether the activity tab/route is active. |

Create via config or API, e.g.:

```php
\Drupal::entityTypeManager()->getStorage('mailchimp_transactional_activity')->create([
  'id' => 'user_mail',
  'label' => 'User email activity',
  'entity_type' => 'user',
  'bundle' => 'user',
  'entity_path' => 'user',
  'email_property' => 'mail',
  'enabled' => TRUE,
])->save();
```

```
drush config:get mailchimp_transactional_activity.mailchimp_transactional_activity.user_mail
```

## Dynamic routing & rendering

`Routing\ActivityRoutes::routes()` (registered via `route_callbacks` in
`mailchimp_transactional_activity.routing.yml`) loads all Activity entities and, for each
**enabled** one, defines route `entity.<entity_type>.activity` at
`<entity_type>/{<entity_type>}/activity`, requiring `view mailchimp transactional activity`.
`Controller\ActivityController::overview()` reads the entity's `email_property`, calls the base
module's API service `getMessages($email)`, and renders the results. Because routes are built from
config, rebuild routes (`drush cr` / router rebuild) after adding or enabling a mapping.

## Permissions

- `administer mailchimp transactional activity` — add/edit/delete mappings (restricted).
- `view mailchimp transactional activity` — see the per-entity activity tab (plus normal access
  to view the entity itself).
