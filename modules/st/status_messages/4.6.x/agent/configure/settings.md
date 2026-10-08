# Configuration

## The only setting: `status_message_time`

Config object **`status_messages.status_messages`**, single key `status_message_time`,
in **milliseconds**. The settings form (`StatusMessages`) offers a select with these options:

| Value (ms) | Label |
|---|---|
| `5000` | 5 Seconds |
| `10000` | 10 Seconds |
| `15000` | 15 Seconds |
| `20000` | 20 Seconds |
| `3600000` | Never |

Form at **`/admin/config/user-interface/status-messages`** (route
`status_messages.status_messages`, permission `administer status messages configuration`).

`"Never"` is implemented as an hour (3,600,000 ms), i.e. effectively no auto-close within a
normal page view.

## Read / write

```bash
drush cget status_messages.status_messages status_message_time
drush cset status_messages.status_messages status_message_time 10000 -y
```

```php
\Drupal::configFactory()->getEditable('status_messages.status_messages')
  ->set('status_message_time', 20000)->save();
```

> The module ships **no** `config/install` default and **no** config schema, so on a fresh
> enable `status_message_time` is unset (NULL) until the form is saved once. `hook_preprocess`
> reads it and passes it to `drupalSettings.statusMessages`, which the JS uses to time the fade.

## Permissions

| Permission | Gates |
|---|---|
| `administer status messages configuration` | Access the settings form |

## Theming notes

- Popup markup/behaviour comes from the `status_messages/status-messages` library
  (`css/status_messages.css` + `js/status_messages.js`, depends on jQuery + drupalSettings),
  attached on every page by `hook_page_attachments`.
- `hook_theme_registry_alter` re-points the `status_messages` theme hook to the module's
  `templates/misc` directory, and `hook_preprocess_block__system_messages_block` re-renders the
  messages block with `max-age: 0`.
