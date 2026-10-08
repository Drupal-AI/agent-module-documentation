# Configure Message Banner

Form `Drupal\message_banner\Form\MessageBannerSettingsForm` at
`/admin/config/user-interface/message-banner` (route `message_banner.settings`, permission
`manage message banner`). Writes config object `message_banner.settings`.

## Settings keys (schema `message_banner.settings`, defaults from `config/install`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `banner_enabled` | int (0/1) | 0 | Master on/off. When 0, nothing is attached. |
| `banner_enabled_on_admin_routes` | int | 0 | If 0, the banner is skipped on admin routes (`router.admin_context`). |
| `banner_disable_close` | int | 0 | If 1, no close button — banner cannot be dismissed. |
| `banner_show_again_minutes` | int | 0 | Minutes after dismissal before the banner shows again (0 = stay dismissed). |
| `banner_color` | string | `''` | CSS class added to the banner (see color options / `hooks/colors.md`). |
| `banner_text` | text_format | `{value:'',format:''}` | The rich-text message; rendered via `check_markup`. Form default format `basic_html`. |
| `banner_position_override` | int | 1 (install) | If 1, use `banner_override_selector` instead of prepending to `body`. |
| `banner_override_selector` | string | `body` | CSS selector the JS prepends the banner into when override is on. |

Color select options (`getBannerColors()`): `default--red`, `default--amber`, `default--green`,
`default--black`, `default--gray`, `default--white` (extend via `hook_message_banner_colors_alter`).

## Permissions (`message_banner.permissions.yml`)

- `manage message banner` — access the settings form.
- `view message banner` — controls whether the banner is attached for the current user.
  `hook_install` grants it to the **anonymous** and **authenticated** roles.

## Runtime (`message_banner_page_attachments`)

1. Returns early if on an admin route and `banner_enabled_on_admin_routes` is off, or if
   `banner_enabled` is off.
2. Builds the `#theme => 'message_banner'` render array with `check_markup(banner_text.value,
   banner_text.format)` and `#cache: { contexts: ['user.roles'] }`.
3. Only if the current user has `view message banner`: renders the banner to a string and attaches
   `drupalSettings.messageBanner` (`banner_text`, `banner_timestamp` = state `banner_saved`,
   `banner_show_again_minutes`, `banner_position_override`, `banner_override_selector`) plus the
   `message_banner/message_banner` library; merges the config cache tags.

## Notes

- On form submit, `banner_text` is saved to config and `time()` is saved to **state** key
  `banner_saved` (not config), so re-saving re-shows the banner to users who had dismissed it.
- Theme hook `message_banner` variables: `message`, `disable_close`. Preprocess sets id
  `message-banner`, class `message-banner`, and appends `banner_color` as a class.
- Config translation is supported (`message_banner.config_translation.yml`).
