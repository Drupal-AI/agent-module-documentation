<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Legal — terms storage, versioning & API

## Entities / tables (terms are content, not config)

- **`legal_conditions`** (content entity `Conditions`, base table `legal_conditions`) — the
  T&C versions. Base fields: `tc_id` (id), `uuid`, `version` (int), `revision` (int),
  `language`, `conditions` (string_long, the terms text), `format` (text-format id), `date`
  (created), `extras` (serialized array of extra checkbox labels), `changes` (change notes).
- **`legal_accepted`** (content entity `Accepted`, base table `legal_accepted`) — acceptance
  records. Fields: `legal_id` (id), `uuid`, `version`, `revision`, `language`, `uid`
  (user ref), `accepted` (created timestamp).

## Versioning

`legal_version($handling, $language)` computes the next IDs from `legal_conditions`:
- `'version'` → `{version: max+1, revision: 1}` (a brand-new version).
- `'revision'` → `{version: max, revision: max_rev_for_lang+1}` (a revision of the current).

Publishing a new **version/revision** is what triggers re-acceptance for existing users
(checked in `legal_user_login()` / `legal_version_check()`).

## Key helper functions (`legal.module`)

| Function | Returns / does |
|---|---|
| `legal_get_conditions($language='')` | Latest T&C row for a language (or overall) as an array incl. `conditions`, `format`, `version`, `revision`, `extras`. |
| `legal_get_accept($uid)` | The user's most recent acceptance record. |
| `legal_save_accept($version,$revision,$language,$uid)` | Creates an `Accepted` record. |
| `legal_version($handling,$language)` | Next `{version, revision}` (see above). |
| `legal_version_check($uid,$version,$revision,$account=[])` | TRUE if the user accepted that exact version/revision. |
| `legal_user_is_exempt($account)` | TRUE for user 1, exempt roles, or masquerading. |

## Adding Terms & Conditions in code

```php
use Drupal\legal\Entity\Conditions;

$language = 'en';
$v = legal_version('version', $language);   // e.g. ['version' => 1, 'revision' => 1]

Conditions::create([
  'version'    => $v['version'],
  'revision'   => $v['revision'],
  'language'   => $language,
  'conditions' => '<p>Your terms text (HTML allowed).</p>',
  'format'     => 'basic_html',             // any valid text-format id
  'date'       => time(),
  'extras'     => serialize([]),            // optional extra checkbox labels
  'changes'    => '',                        // optional change notes
])->save();
```

After this, `legal_get_conditions('en')` returns the new terms and the registration form
shows them. (This is exactly what the admin terms form does on save.)

## Other integration

- Token `[legal:tc]` renders the current terms (`legal_token_info()` / `legal_tokens()`).
- Cookies used during the login-acceptance handshake: `Drupal.visitor.legal_hash`,
  `Drupal.visitor.legal_id` (whitelist these in Varnish/GDPR tooling if needed).
- No Drush commands and no plugin types are defined (the migrate `source` and Views `field`
  plugins are internal implementations, not extension points).
