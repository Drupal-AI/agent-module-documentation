<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Create & manage redirect rules

There is no settings object — every redirect is a **`url_redirect` config entity**. UI lives
at `/admin/config/system/url_redirect` (route `entity.url_redirect.collection`, the
`configure` route). Add/edit/delete routes hang off it.

## Entity shape (`url_redirect.url_redirect.<id>`)

| Key | Type | Meaning |
|---|---|---|
| `id` | string | machine name |
| `label` | string | admin label |
| `path` | string | source path to match, e.g. `/members`, `<front>`, `/reports/*` |
| `redirect_path` | string | destination; internal path, `<front>`, or external `https://…` |
| `redirect_for` | string | `Role` or `User` — which check to run |
| `roles` | sequence | role ids (used when `redirect_for` = `Role`) |
| `users` | sequence | `[target_id => …]` user refs (used when `redirect_for` = `User`) |
| `negate` | bool | invert the role/user match |
| `message` | string | `Yes` shows a "You have been redirected…" status message, `No` is silent |
| `status` | string/int | `1`/Enabled fires the rule, `0`/Disabled parks it |

The entity's `admin_permission` is `access url redirect settings page`.

## Via the UI

1. Go to *Configuration → System → URL Redirect* (`/admin/config/system/url_redirect`).
2. Click **Add URL Redirect**.
3. Fill **Label**, machine **id**, **Path** (internal, e.g. `/members`; `<front>` for the
   home page), **Redirect Path** (validated by `path.validator`; may be external).
4. Choose **Select Redirect path for**: *Role* (then pick one or more roles) or *User* (then
   autocomplete one or more users).
5. Optionally tick **Negate the condition**, set **Display Message for Redirect** (Yes/No),
   and **Status** (Enabled/Disabled).
6. **Save**. Validation rejects a duplicate `path` on a new rule and an invalid
   `redirect_path`; Role/User mode requires at least one role/user.

## Via drush (scriptable)

```php
// drush php:eval
\Drupal::entityTypeManager()->getStorage('url_redirect')->create([
  'id' => 'members_area',
  'label' => 'Members area -> login',
  'path' => '/members',
  'redirect_path' => '/user/login',
  'redirect_for' => 'Role',
  'roles' => ['anonymous' => 'anonymous'],
  'users' => [],
  'negate' => FALSE,
  'message' => 'No',
  'status' => 1,
])->save();
```

For a user-targeted rule set `redirect_for => 'User'` and
`users => [['target_id' => 5]]` (or `[5 => ['target_id' => 5]]`), leaving `roles` empty.

## Read it back

```bash
drush config:get url_redirect.url_redirect.members_area
# or list all: drush config:status ; drush config:get url_redirect.url_redirect.<id>
```

`status` (Enabled) and a matching `redirect_for`/`roles`/`users` are what make the rule fire
— see [api/mechanism.md](../api/mechanism.md).
