<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User form & view displays shipped by drutopia_user

## Install & enable

```bash
composer require drupal/drutopia_user
drush en drutopia_user -y
```

Core-only deps (`field`, `file`, `image`, `path`, `user`); normally installed as part of the
Drutopia distribution. On enable, the three `config/install/*` objects are imported into active
config for the core **User** entity (bundle `user`). No settings form, no permissions, no Drush
commands. Documented from a **dev checkout** of `2.0.x`.

After enable, these become ordinary site config — edit them at
`/admin/config/people/accounts/form-display` and `/admin/config/people/accounts/display`; reinstall
the module to reset to the shipped baseline.

## 1. Account form display — `core.entity_form_display.user.user.default`

Mode `default`, `targetEntityType: user`, `bundle: user`. Depends on modules `path`, `user`.
Field-group weights on the registration/edit form:

| Component | Weight | Region |
|---|---|---|
| `account` | -10 | content |
| `language` | 0 | content |
| `contact` | 5 | content |
| `timezone` | 6 | content |

**Hidden:** `path` (the URL-alias widget is removed from the user form).

`account` is core's combined username/email/password/status widget — this only sets its order; it
does not change what that widget collects. (Credential collection is core behavior on an
authenticated admin/registration form; this file only orders it.)

## 2. Default profile view display — `core.entity_view_display.user.user.default`

Mode `default`, `targetEntityType: user`, `bundle: user`. Depends on module `user`.

- `content: {}` — **no** field/pseudo-field is placed in the visible region by this feature.
- **Hidden:** `member_for: true`, `search_api_excerpt: true`.

Net effect: a deliberately minimal profile. It removes the core "Member for" pseudo-field and the
Search API excerpt pseudo-field from the public profile; it does not add or expose the user's email
or any other user field.

## 3. Compact view display — `core.entity_view_display.user.user.compact`

Identical shape to the default view display but for view **mode `compact`** (id
`user.user.compact`). Depends on module `user`.

- `content: {}` — nothing placed in the visible region.
- **Hidden:** `member_for: true`, `search_api_excerpt: true`.

This registers/configures a reusable `compact` user view mode for teasers, bylines, references, and
listings. Being empty by default, it renders minimally until a site adds components via Manage
display.

## Notes

- Both view displays expose no user fields at all (empty `content`); they only hide two
  pseudo-fields. The email/`mail` field is never surfaced by these files — it appears only in the
  core `account` widget on the **form** display.
- Because everything is exported config, later UI edits override the shipped values; the module
  provides no code that re-asserts them at runtime.
