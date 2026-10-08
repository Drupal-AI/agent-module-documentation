# Configure IntelligenceBank DAM (global settings)

Settings form `Drupal\ib_dam\Form\IbSettingsForm` (form id `ib_dam_settings_form`), route
`ib_dam.settings_form` at **`/admin/config/services/ib_dam`**, gated by permission
`administer intelligencebank configuration`. It edits the single config object **`ib_dam.settings`**.

## Settings

| Form field | Config key (`ib_dam.settings`) | Type | Meaning |
|---|---|---|---|
| Debug | `debug` | bool | Verbose logging; also enables the in-browser debug panel of the iframe app (only for users holding the admin permission). |
| Staging | `staging` | bool | Use the IB **beta/staging** app URL (`https://ucstaging.intelligencebank.com/app/`) instead of production (`https://ucprod.intelligencebank.com/app/`). |
| Allow asset embedding | `allow_embedding` | bool | When on, the iframe app is loaded with `app=drupal` (public CDN embed allowed); when off it is loaded with `app=drupal_no_public` (download only). Also toggles the "Embed" item in the Media Library menu. |
| Enable custom Platform URL | `login_enable_custom_url` | bool | Passed to the app as `enable_custom_url`. Lets the login use a full custom platform URL rather than a sub-domain. |
| Platform URL / Sub-domain | `login_url` | string | Passed to the app as `url` (login default). |
| Enable browser login (for SSO) | `login_enable_browser_login` | bool | Passed to the app as `enable_browser_login` (SSO flow). |

These values are read by the iframe browser element (`IbIframeApp::buildIframeUrl()`) and encoded into
the app iframe query string; the module itself never authenticates to IB server-side with them.

## Set via PHP / drush

```php
\Drupal::configFactory()->getEditable('ib_dam.settings')
  ->set('debug', FALSE)
  ->set('staging', FALSE)
  ->set('allow_embedding', TRUE)
  ->set('login_url', 'mycompany')            // sub-domain, or full URL if custom enabled
  ->set('login_enable_custom_url', FALSE)
  ->set('login_enable_browser_login', TRUE)
  ->save();
```

```bash
drush cset ib_dam.settings allow_embedding 1 -y
```

## settings.php overrides (not in the config object)

- `$settings['intelligencebank_api_timeout']` — Guzzle request timeout for DAM calls (default **120**s;
  read in `IbDamApi::__construct`).
- `$settings['intelligencebank_is_test_mode']` — force the staging app URL even when `staging` is off
  (default FALSE; read in `IbIframeApp::isTestMode`).

## Notes

- `ib_dam.install` has updates: `ib_dam_update_8001` seeds the `login_*` keys; `ib_dam_update_10000`
  removes the deprecated `ib_dam_wysiwyg` text filter and uninstalls that submodule.
- Config schema: `config/schema/ib_dam.schema.yml` (`ib_dam.settings`, a `config_object`).
