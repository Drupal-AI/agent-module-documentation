<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config form & keys

Source: `src/Form/CloudfiltConfigForm.php`, `cloudfilt.routing.yml`, `cloudfilt.links.menu.yml`.

## Route & access

```yaml
cloudfilt.config:
  path: '/admin/config/services/cloudfilt'
  defaults: { _form: '\Drupal\cloudfilt\Form\CloudfiltConfigForm', _title: 'CloudFilt' }
  requirements: { _permission: 'access administration pages' }
  options: { _admin_route: TRUE }
```

Menu link `cloudfilt.config` is placed under **Configuration → Web services**
(`system.admin_config_services`).

## Form fields (`buildForm`)

All live in the `cloudfilt.config` config object:

| Field | Type | Config key | Notes |
|-------|------|-----------|-------|
| Public Key | `textfield` (maxlength 64), required | `key_front` | Sent to CloudFilt; also embedded in the client script URL and the block-redirect URL. |
| Private Key | `textfield` (maxlength 64), required | `key_back` | The account secret; sent as `KEY` to the CloudFilt API. |
| Restrict checking by role | `checkbox` | `roles_exclude` | When on, reveals the roles list (`#states` visible). |
| Do not check the following roles | `checkboxes` | `roles` | Options are all `user_role` entities. |

If `key_site` is already set, `buildForm` shows an info message linking to
`https://app.cloudfilt.com`.

## Key validation (`validateForm` / `submitForm` → `validateCloudfiltKeys`)

Both validate and submit POST the entered `key_front`/`key_back` to
`https://api.cloudfilt.com/checkcms/drupal.php` (Guzzle `form_params`, default TLS verification) and
`json_decode` the response:

- `status == 'NO'` → form error on `key_front` ("could not validate your credentials").
- `status == 'E'` (a caught `RequestException`) → form error showing the exception message + FAQ link.
- Otherwise submit stores `key_front`, `key_back`, the response's `site` as `key_site`, plus
  `roles_exclude` and `roles`.

Note: `validateCloudfiltKeys` runs **twice** per successful save (once in validate, once in submit).

## Behaviour notes

- The **Private Key** is stored in plaintext in the `cloudfilt.config` config object (exported with
  configuration) and is re-populated into the form's `#default_value` on every render. There is no
  Key-module integration; to keep it out of exported config, override the value in `settings.php`
  (`$config['cloudfilt.config']['key_back'] = getenv('CLOUDFILT_PRIVATE_KEY');`).
- No config `schema/` file ships, so saving may emit schema warnings under strict config checking.
