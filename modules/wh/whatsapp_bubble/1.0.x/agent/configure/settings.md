# Configure: global settings

Settings form `Drupal\whatsapp_bubble\Form\ConfigForm` (`ConfigFormBase`).

- Route: `whatsapp_bubble.whatsapp_bubble_config_form`
- Path: `/admin/config/services/whatsapp-bubble`
- Form id: `whatsapp_bubble_config_form`
- Access: `_permission: 'access administration pages'` (`_admin_route: TRUE`)
- Menu link: `whatsapp_bubble.whatsapp_bubble_config_form` under `system.admin_config_services`, weight 99.
- Editable config: `whatsapp_bubble.config` (single config object).

## Config keys

Config object `whatsapp_bubble.config`. Defaults from `config/install/whatsapp_bubble.config.yml`.

| Form field | Config key | Type | Default | Values / meaning |
|---|---|---|---|---|
| Enable floating bubble | `is_enabled` | boolean | `true` | When on, `hook_page_bottom()` injects the bubble on every non-admin page. |
| Alignment | `alignment` | string | `right` | Horizontal: `left` / `right` / `center` (CSS class). |
| Vertical alignment | `valignment` | string | `bottom` | Vertical: `top` / `bottom` / `middle` (CSS class). |
| Message | `message` | text | `''` | Prefilled WhatsApp chat text. `urlencode()`d into the `?text=` query at render time. |
| Phone Number | `phone_number` | string | `''` | Destination number (include country code, E.164). Rendered into the `wa.me/<number>` path. **`#required` on the form.** |
| Dark theme (Inverse color) | `is_inverse` | boolean | `false` | When on, adds the `inverse` CSS class (green background, white icon). |

Schema: `config/schema/whatsapp_bubble.schema.yml` defines `whatsapp_bubble.config` (config_object)
plus `block.settings.whatsapp_button_block` (the button block's per-instance settings — see
[blocks/blocks.md](../blocks/blocks.md)).

## Set via drush / PHP

```bash
drush config:set whatsapp_bubble.config phone_number '15551234567' -y
drush config:set whatsapp_bubble.config message 'Hi! I have a question.' -y
drush config:set whatsapp_bubble.config is_enabled true -y
```

```php
\Drupal::configFactory()->getEditable('whatsapp_bubble.config')
  ->set('phone_number', '15551234567')
  ->set('message', 'Hi! I have a question.')
  ->set('alignment', 'right')
  ->set('valignment', 'bottom')
  ->set('is_inverse', FALSE)
  ->set('is_enabled', TRUE)
  ->save();
```

Any change invalidates the cache tag `config:whatsapp_bubble.config`, so all rendered bubbles/buttons update automatically.
