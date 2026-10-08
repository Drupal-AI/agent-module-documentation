# IntelligenceBank DAM global settings

Config object **`ib_dam.settings`** (schema in `config/schema/ib_dam.schema.yml`; **no
`config/install`, so values are null until saved**). Form `IbSettingsForm` (a `ConfigFormBase`)
at `/admin/config/services/ib_dam` (route `ib_dam.settings_form`, permission
`administer intelligencebank configuration`).

## Settings keys

| Key | Type | Meaning |
|---|---|---|
| `debug` | bool | Verbose logging of IB API activity. |
| `staging` | bool | Use the beta/staging connector browsing interface. |
| `allow_embedding` | bool | Allow **embedding** IB assets (public CDN link) in addition to downloading. Controls whether the "IB embed" option shows in the Media Library menu (see ib_dam_media). |
| `login_url` | string | Default Platform URL / sub-domain (without `https://`). |
| `login_enable_custom_url` | bool | Let editors enter a custom Platform URL rather than a fixed sub-domain. |
| `login_enable_browser_login` | bool | Enable browser login (for SSO). |

Note the form maps its `url` / `enable_*` field names onto the `login_*` config keys on submit.

Set via Drush, e.g.:
```
drush cset ib_dam.settings allow_embedding 1 -y
drush cset ib_dam.settings login_url 'acme.intelligencebank.com' -y
drush cset ib_dam.settings login_enable_browser_login 1 -y
```

## Related settings (settings.php, not config)

- `intelligencebank_api_timeout` (default 120s) — Guzzle timeout used by the `IbDamApi` service
  (`Settings::get('intelligencebank_api_timeout', 120)`).

## Submodule config

- `ib_dam_media.settings` (media-type mapping + upload location) — form at
  `/admin/config/services/ib_dam/media`. See the ib_dam_media docs.

## Credentials

Actual connectivity needs IntelligenceBank platform credentials/SSO configured against your IB
account; the `IbDamApi` service authenticates by sending the IB **session id** as a `sid`
header on each request. The module stores no API key of its own in `ib_dam.settings`.
