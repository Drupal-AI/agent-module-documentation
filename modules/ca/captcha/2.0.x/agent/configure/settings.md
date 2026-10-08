# Global settings

![CAPTCHA settings form](../../../../../../../screenshots/captcha/2.0.x/settings.png)

Config object `captcha.settings` (schema `config/schema/captcha.schema.yml`), form
`Drupal\captcha\Form\CaptchaSettingsForm` at `/admin/config/people/captcha` (route
`captcha_settings`). Read/write with `drush config:get captcha.settings` /
`drush config:set captcha.settings <key> <value>`.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `default_challenge` | string | `captcha/Math` | Challenge used when a point is set to "default". Format `module/type`. |
| `enable_globally` | int | 0 | Add CAPTCHA to *all* forms. |
| `enable_globally_on_admin_routes` | bool | FALSE | Also protect admin-route forms (with global on). |
| `administration_mode` | bool | FALSE | Show inline add/edit CAPTCHA links on forms. |
| `administration_mode_on_admin_routes` | bool | FALSE | Extend admin links to admin pages. |
| `default_validation` | int | 1 | 0 = case sensitive, 1 = case insensitive. |
| `persistence` | int | 1 | 0 always show; 1 skip once solved per form instance; 2 per form type; 3 once solved anywhere. |
| `whitelist_ips` | string | `''` | IPs / CIDR ranges (one per line) that bypass CAPTCHA. |
| `title` | label | `CAPTCHA` | Fieldset title shown above the challenge. |
| `description` | label | (help text) | Description shown under the title. |
| `wrong_captcha_response_message` | label | (message) | Error on an incorrect answer. |
| `enable_stats` | bool | FALSE | Count generated/blocked challenges. |
| `log_wrong_responses` | bool | FALSE | Log incorrect responses to watchdog. |

Persistence and validation constants live in `src/Constants/CaptchaConstants.php`.
