# CookiePro Plus — service, event, blocks & tokens

## The `cookiepro_plus` service (`Drupal\cookiepro_plus\CookiePro`)

Central logic; also usable from your code. Notable methods (see `CookieProInterface`):

- `getConfig()` / `getConfigDefault()` / `getConfigOverride($langcode)` — active/default/per-language `ImmutableConfig`.
- `getDomainScriptId($config = NULL)` — resolves the Script ID, dispatches `CookieProGetDomainScript`, appends `-test` when `test_cdn` is on.
- `getMainScriptUrl()` / `getAutoBlockScriptUrl($config)` — full CDN URLs for the consent / auto-block scripts.
- `mustProcess()` — TRUE when the script should be injected (not admin route, not whitelisted IP, path allowed, not excluded, not paused).
- `isWhitelistedIp($request = NULL)`, `isExcludedPath()`, `isLimitedToPath()`, `isAdminRoute()`, `isPaused($config = NULL)` — the individual gate checks.
- `enablePauseMode()/disablePauseMode($config = NULL)` — toggle the State pause flag and invalidate cache tags.
- `getPauseModeMessages()` — warning messages (with re-enable links) for paused configs.
- `testScriptUrls($config = NULL)` — HEAD-fetch the Script ID JSON + auto-block URLs and return per-URL error messages (used to verify the ID is published to the CDN).
- `getGoogleConsentModeSupportScript()` — renders the inline GCM default-state snippet from `gcm_deny_storages`.

```php
$cp = \Drupal::service('cookiepro_plus');
if ($cp->mustProcess()) {
  $url = $cp->getMainScriptUrl();
}
```

## Event: alter the active domain script

`Drupal\cookiepro_plus\Event\CookieProGetDomainScript` is dispatched from `getDomainScriptId()`.
Subscribe to swap the Script ID at runtime (e.g. per environment or per group):

```php
public static function getSubscribedEvents(): array {
  return [CookieProGetDomainScript::class => 'onGetDomainScript'];
}
public function onGetDomainScript(CookieProGetDomainScript $event): void {
  $event->setDomainScript('my-other-script-id');   // $event->getConfig() gives the source config
}
```

## Blocks & tokens (embed consent UI in content)

Three blocks (`src/Plugin/Block/`), each with a matching token under the `cookiepro_plus` token group,
render via `renderInIsolation()`:

| Block plugin id | Token | Renders |
|---|---|---|
| `cookiepro_plus_cookie_list` | `[cookiepro_plus:cookie_list]` | OneTrust cookie list (`#ot-sdk-cookie-policy` container). |
| `cookiepro_plus_consent_settings_button` | `[cookiepro_plus:consent_settings_button]` | Button that opens the OneTrust Preference Center. |
| `cookiepro_plus_consent_settings_link` | `[cookiepro_plus:consent_settings_link]` | Text link that opens the Preference Center. |

Each block takes an optional `langcode` variable (theme hooks `cookiepro_consent_settings_button`,
`cookiepro_consent_settings_link`, `cookiepro_cookie_list`). Use `token_filter` (suggested) to place the
tokens inside CKEditor content.
