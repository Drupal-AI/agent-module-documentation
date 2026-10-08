<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions and access rules

## Module permissions (`contact.permissions.yml`)

| Permission | Gates |
|---|---|
| `administer contact forms` | The whole `/admin/structure/contact` UI, editing/deleting forms, and the settings injected into `/admin/config/people/accounts` |
| `access site-wide contact form` | `/contact` and `/contact/{form}` |
| `access user contact forms` | `/user/{uid}/contact` for other users |

None are marked `restrict access`.

```bash
drush role:perm:add anonymous 'access site-wide contact form'
drush role:perm:add authenticated 'access user contact forms'
```

## Per-form permissions

`contact_form` declares `route_provider: ['permissions' => EntityPermissionsRouteProvider::class]`,
which adds `/admin/structure/contact/manage/{contact_form}/permissions`. Use it to grant a role
access to one specific form's fields (Field UI's per-bundle field permissions), not to gate the
form route itself — the route still checks `contact_form.view` entity access.

## `ContactFormAccessControlHandler`

```php
'view'            → allowedIfHasPermission('access site-wide contact form')
                     AND entity id !== 'personal'
'update'/'delete' → allowedIfHasPermission('administer contact forms')
                     AND entity id !== 'personal'
```

Two consequences: the `personal` form is **not reachable at `/contact/personal`** (it is only used
via the user tab), and it **cannot be edited or deleted** through the UI — its label/message live
in `contact.form.personal` and can only be changed with config edits (`drush cset`).

## Personal contact tab — `ContactPageAccess`

`_access_contact_personal_tab` on `/user/{user}/contact` evaluates, in order:

1. Contacted account is **anonymous** → `forbidden()`.
2. Contacting **yourself** → neutral (no access), cache per user.
3. Requester has **`administer users`** → allowed, regardless of everything below.
4. Contacted account is **blocked** → neutral (no access).
5. Contacted user's own preference — `user.data` module `contact`, key `enabled` — is set and
   false → neutral (no access).
6. No preference stored and `contact.settings:user_default_enabled` is false → neutral.
7. Otherwise → allowed if the requester has **`access user contact forms`**.

`ContactController::contactPersonalPage()` additionally throws a 404 when the contacted user has
no email address.

Cacheability: the result is `cachePerUser()`, with the contacted account and `contact.settings`
added as cacheable dependencies, so toggling a user's preference or the site default invalidates
correctly.

## Checking access programmatically

```php
$access = \Drupal::service('access_check.contact_personal')
  ->access($target_user, \Drupal::currentUser());

// Or via the route:
$url = \Drupal\Core\Url::fromRoute('entity.user.contact_form', ['user' => $uid]);
$allowed = $url->access();
```

## Practical notes

- Granting `administer users` implicitly grants the ability to email **any** user, bypassing their
  opt-out — and `ContactHooks::mail()` deliberately omits the "you can turn this off" footer for
  such senders.
- `access site-wide contact form` given to anonymous is the common spam surface; pair it with the
  flood settings (`contact.settings:flood`) and a CAPTCHA module.
- Because contact messages are never stored, an audit trail exists only in the `contact` logger
  channel and in the recipients' mailboxes.
