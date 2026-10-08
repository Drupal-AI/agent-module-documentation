# Configure Better Messages

All behaviour comes from one config object: **`better_messages.settings`**.

- Admin form: route `better_messages.settings_form` →
  `/admin/config/user-interface/better-messages`
  (`Drupal\better_messages\Form\BetterMessagesSettingsForm`).
- Permission to reach it: **`configure better messages`**.

## Settings keys (with shipped defaults)

From `config/install/better_messages.settings.yml`:

| Key | Default | Meaning |
|---|---|---|
| `position` | `center` | where the message box appears. Values: `center`, `tl` (top left), `tr` (top right), `bl` (bottom left), `br` (bottom right). |
| `vertical` | `0` | vertical offset (px); ignored when `position` is `center`. |
| `horizontal` | `10` | horizontal offset (px); ignored when `position` is `center`. |
| `fixed` | `1` | fixed positioning (stays while scrolling). |
| `width` | `'400px'` | width of the message container. |
| `autoclose` | `0` | seconds before auto-closing (`0` = do not auto-close by time). |
| `disable_autoclose` | `0` | hard-disable auto-close. |
| `show_countdown` | `1` | show a countdown timer until close. |
| `hover_autoclose` | `1` | pause auto-close while hovering. |
| `opendelay` | `0.3` | delay (seconds) before showing messages. |
| `popin.effect` / `popin.duration` | `fadeIn` / `slow` | open animation. |
| `popout.effect` / `popout.duration` | `fadeOut` / `slow` | close animation. |
| `jquery_ui.draggable` | `1` | allow dragging the box (needs `jquery_ui_draggable`). |
| `jquery_ui.resizable` | `0` | allow resizing the box (needs `jquery_ui_resizable`). |
| `visibility` | `[]` | Drupal **condition plugin** config (e.g. request_path) limiting where messages show. |

Config schema: `better_messages.settings` (see `config/schema/better_messages.schema.yml`);
`visibility` is a sequence of `condition.plugin.[id]`.

## Read / write in code or drush

```bash
drush cget better_messages.settings
drush cget better_messages.settings position
drush cset better_messages.settings autoclose 5 -y
```

```php
\Drupal::configFactory()->getEditable('better_messages.settings')
  ->set('position', 'top-right')
  ->set('autoclose', 5)
  ->save();
```

The admin form's submit handler writes each of the keys above (note the form field `pos` maps to
config `position`, `open_delay` → `opendelay`) and rebuilds `visibility` from the condition
sub-forms.

## Visibility conditions

The `visibility` key holds standard condition plugin configuration (the settings form embeds the
condition UI, including request_path). Populate it to show/hide the popups on chosen paths. See
[plugins/condition.md](../plugins/condition.md) for the module's own `message_type` condition.
