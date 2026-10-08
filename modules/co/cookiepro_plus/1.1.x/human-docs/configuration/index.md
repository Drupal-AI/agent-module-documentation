# Configuration

## Open the settings form

1. Log in as a user with the **Administer CookiePro Plus configuration**
   permission.
2. Go to **Configuration → System → CookiePro Plus**, or navigate directly to
   `/admin/config/system/cookiepro-plus`.

The settings you save here live in the `cookiepro_plus.config` configuration
object. On a multilingual site that uses **URL domain** language negotiation with
more than one domain, you can also create per-language override configurations from
the same form — everything below then applies to the language you are editing.

## The core script settings

- **Script ID** (`domain_script`) — the OneTrust `data-domain-script` value from
  your CookiePro account. This is the one setting the module can't work without: if
  it's empty, nothing is injected and the module logs a critical error. Paste your
  ID here.
- **Script domain** (`domain`) — which OneTrust CDN serves the script. Choose
  **CookiePro** (`cdn.cookiepro.com`) or **OneTrust** (`cdn.cookielaw.org`) to
  match your account. Default: CookiePro.
- **Auto-Blocking** (`auto_block`) — when on, the module loads OneTrust's
  Auto-Blocking™ script *before* the main consent script, so third-party cookies
  are blocked until the visitor consents. Off by default.
- **Document language** (`document_language`) — on by default. Tells OneTrust to
  read the page's `<html lang>` attribute so the banner appears in the page
  language.
- **Cookie category IDs** (`category_ids`) — the five OneTrust category IDs
  (Strictly Necessary, Performance, Functional, Targeting, Social Media), used to
  build CSS/consent classes. The defaults (`C0001`–`C0005`) match a standard
  OneTrust setup; change them only if your OneTrust configuration differs.
- **Use testing CDN** (`test_cdn`) — appends `-test` to your Script ID to hit
  OneTrust's staging CDN. Handy on staging environments; leave off in production.

## Google Consent Mode

- **Enable Google Consent Mode** (`gcm_enable`) — off by default. When on, the
  module emits an inline "default state" snippet before your tags load.
- **Denied storages** (`gcm_deny_storages`) — which Google storage types default to
  `denied` until consent is given (`ad_storage`, `ad_user_data`,
  `ad_personalization`, `analytics_storage`, `functionality_storage`,
  `personalization_storage`, `security_storage`). All default to denied, which is
  the privacy-safe starting point.

## Controlling where the banner appears

The script is **never** injected on admin routes — that is automatic. Beyond that:

- **Limit to paths** (`enable_limit_to_paths` + `limit_to_paths`) — turn the
  checkbox on and list path patterns (one per line, `*` wildcards allowed) to
  inject the script *only* on those paths. Off by default (the banner runs
  site-wide).
- **Exclude paths** (`exclude_paths`) — path patterns (one per line) that never
  receive the script. Ships pre-populated with node-edit, previewer, and
  embed-preview paths so the banner stays out of editing surfaces.

## IP whitelist (important security note)

- **IP whitelist** (`ip_whitelist`) — a list of IPv4 addresses / CIDR ranges. A
  visitor whose IP matches bypasses CookiePro entirely, and — importantly — the
  **page cache is disabled** for those requests and a bypass library is attached.

  The module ships with a **default range already filled in**
  (`20.54.106.120/29`). Review this on every install: clear it, or replace it with
  your own internal/QA ranges. Leaving an unexpected range here means those
  visitors silently skip consent *and* lose page caching. To use the feature, list
  only ranges you control (for example your office or QA network); to disable it,
  empty the field.

## Pause mode

Pause mode lets you temporarily stop injecting the script without deleting any of
your settings. Toggle it from this form. While a configuration is paused:

- The banner is not injected for anyone.
- Administrators (users with the configuration permission) see an on-page warning
  with a link back to re-enable it, so a paused site is never left paused by
  accident.

Pause is stored as a runtime state flag rather than in exported config, so pausing
on one environment doesn't propagate through a config deployment.

## Testing your Script ID

The form can HEAD-check that your Script ID (and the Auto-Blocking script, if
enabled) are actually published to the OneTrust CDN, and report any URL that
doesn't resolve. Use this to confirm a new ID is live before you rely on it.

## Save

Click **Save configuration**. Reload a front-end page (not an admin page) and the
CookiePro banner should appear — subject to the path, IP, and pause rules above.

## Embedding consent controls in content

Three blocks let editors place OneTrust controls anywhere, each with a matching
token (use the suggested [Token Filter](https://www.drupal.org/project/token_filter)
module to place them inside CKEditor):

| Block | Token | What it shows |
|-------|-------|---------------|
| **Cookie list** | `[cookiepro_plus:cookie_list]` | The OneTrust cookie list / policy table. |
| **Consent settings button** | `[cookiepro_plus:consent_settings_button]` | A button that opens the OneTrust Preference Center. |
| **Consent settings link** | `[cookiepro_plus:consent_settings_link]` | A text link that opens the Preference Center. |

Place the blocks via *Structure → Block layout*, or drop the tokens into content.
Each accepts an optional language code. Developers can also alter the active script
per request via the `CookieProGetDomainScript` event and the `cookiepro_plus`
service — see the [`agent/`](../../agent/start.md) docs.
