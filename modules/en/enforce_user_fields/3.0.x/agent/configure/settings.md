# Settings form (configure)

One settings page: route `enforce_user_fields.settings` at
`/admin/config/people/enforce-user-fields-settings`, gated by `_permission: administer site
configuration` (form `Drupal\enforce_user_fields\Form\SettingsForm`, a `ConfigFormBase`). It edits the
config object `enforce_user_fields.settings`.

## Config keys — `enforce_user_fields.settings`

| Key | Type (schema) | Meaning |
|---|---|---|
| `message` | `label` | Error message shown (via `messenger()->addError`) when a user is redirected to complete their fields. `#required` in the form. Install default: `Fill out the required fields to complete your profile.` |
| `whitelist` | `string` | Newline-separated list of paths that are **not** enforced. `*` is a wildcard, `<front>` matches the front page (standard `path.matcher` syntax). Empty by default. |
| `langcode` | `string` | Language code (set by config system). |

## Whitelist normalization

`SettingsForm::submitForm` (`SettingsForm.php:44`) rewrites the textarea before saving:

- splits on any line break (`preg_split('/\R/', …)`),
- trims each line, drops blank lines,
- forces a single leading slash per path (`'/' . ltrim($page, '/')`),
- lower-cases the whole list (`mb_strtolower`).

So enter `user/*` or `/user/*` (either works) and it is stored as `/user/*`. Matching at runtime also
lower-cases the request path (`EnforceUserFieldsSubscriber.php:69`), so the whitelist is
case-insensitive. The path compared is the **route's** path pattern (`getRouteObject()->getPath()`),
right-trimmed of a trailing slash (except `/`).

## The `bypass enforce user fields` permission

Users/roles granted `bypass enforce user fields` are never redirected (and never even get the session
flag set). Grant it to trusted roles (e.g. administrators, or service accounts) that should not be
forced through the profile-completion flow. Check `UserFieldsChecker::bypass()` /
`EnforceUserFieldsHooks::userLogin()`.

## Set it from code / config

```php
\Drupal::configFactory()->getEditable('enforce_user_fields.settings')
  ->set('message', 'Please complete your profile before continuing.')
  ->set('whitelist', "/user/*\n/contact\n<front>\n")
  ->save();
```

## What actually triggers enforcement

There is **no** "which fields to enforce" setting. Enforcement is driven entirely by Drupal's own
field configuration: any field on the `user` entity whose field definition is
**`required`** and whose value is **empty** for the current user makes
`UserFieldsChecker::hasUnfilledRequiredFields()` return `TRUE`. Make a user field required on
`admin/config/people/accounts/fields` and it is automatically enforced. (When `multiple_registration`
is installed, a field is only considered for a user whose roles are in that field's
`user_additional_register_form` third-party setting — see [../api/services.md](../api/services.md).)
