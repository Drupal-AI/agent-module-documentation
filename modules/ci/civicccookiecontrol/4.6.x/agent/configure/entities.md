# Cookie Control config entities

The widget's category/language data is modelled as **four config entity types** (all
`admin_permission: administer civiccookiecontrol`, all managed at
`/admin/config/system/cookiecontrol/<type>`). Their values are read by the config builders
(`AbstractCCCConfig` / `CCC9Config`) and folded into the widget JSON.

| Entity type | Config prefix | Collection route | Feeds JSON as | Custom access |
|---|---|---|---|---|
| `cookiecategory` | `civiccookiecontrol.cookiecategory.*` | `entity.cookiecategory.collection` | `optionalCookies[]` | `_iab2_enabled_access_check` (see below) |
| `necessarycookie` | `civiccookiecontrol.necessarycookie.*` | `entity.necessarycookie.collection` | `necessaryCookies[]` | `CookieControlAccess::checkAccess` |
| `excludedcountry` | `civiccookiecontrol.excludedcountry.*` | `entity.excludedcountry.collection` | `excludedCountries[]` (ISO codes) | `CookieControlAccess::checkAccess` |
| `altlanguage` | `civiccookiecontrol.altlanguage.*` | `entity.altlanguage.collection` | `locales[]` | `CookieControlAccess::checkAccess` |

Each type's `add`/`edit`/`delete` routes require the plain `administer civiccookiecontrol` permission.
`hook_link_alter` makes the "add" links open in a 700px modal dialog.

## cookiecategory (the important one)

`\Drupal\civiccookiecontrol\Entity\CookieCategory`. Exported fields (`config_export`):
`id`, `cookieName`, `cookieLabel`, `cookieDescription`, `cookies`, `thirdPartyCookies`,
`thirdPartyCookiesCount`, `vendors`, `vendorsCount`, `onAcceptCallback`, `onRevokeCallback`,
`recommendedState`, `lawfulBasis`. Label key = `cookieName`.

In `AbstractCCCConfig::loadCookieCategoryList()` each category becomes an `optionalCookies` entry:
- `cookies` (comma string) → array via `explode(',')`.
- `onAcceptCallback` / `onRevokeCallback` → wrapped `"function(){ … }"` strings and eval'd client-side
  (`ccEval`) — this is where you gate third-party scripts by consent (e.g. run analytics in `onAccept`,
  clear it in `onRevoke`).
- `thirdPartyCookies` / `vendors` are stored as `;`-separated JSON fragments and decoded (only when the
  respective `*Count > 0`).
- `recommendedState` (bool) → initial consent state; `lawfulBasis` → `lawfulBasis`.

At least **one** cookie category is required for the widget to work (unless IAB v2 CMP is enabled);
`civiccookiecontrol_check_cookie_categories()` shows an error message if none exist.

## Create a cookie category with PHP

```php
$cat = \Drupal::entityTypeManager()->getStorage('cookiecategory')->create([
  'id' => 'analytics',
  'cookieName' => 'analytics',
  'cookieLabel' => 'Analytics cookies',
  'cookieDescription' => 'Used to measure site usage.',
  'cookies' => '_ga, _gid',
  'recommendedState' => FALSE,
  'lawfulBasis' => 'consent',
  'onAcceptCallback' => "console.log('analytics accepted');",
  'onRevokeCallback' => "console.log('analytics revoked');",
  'thirdPartyCookiesCount' => 0,
  'vendorsCount' => 0,
]);
$cat->save();
```

## The other three

- **necessarycookie** — only `id` + `necessaryCookieName`; the names populate `necessaryCookies[]`
  (cookies always allowed).
- **excludedcountry** — only `id` + `excludedCountryIsoCode`; ISO codes where the widget is not shown.
- **altlanguage** — a large per-language override (30+ exported `altLanguage*` fields: title, intro,
  all button/notify/statement/CCPA/IAB text, `altLanguageIsoCode`, `altLanguageMode`,
  `altLanguageLocation`). Built into `locales[]` by `CCC9Config::loadAltLanguages()`. In `browser`
  locale mode all are emitted; in `drupal` mode only the one matching the current language.
