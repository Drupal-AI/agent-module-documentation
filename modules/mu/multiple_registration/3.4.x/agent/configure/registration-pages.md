# Configure Multiple Registration

## Admin pages (routes)

| Route | Path | Purpose |
|---|---|---|
| `multiple_registration.multiple_registration_list_index` (the `configure` route) | `/admin/config/people/multiple_registration` | List existing registration pages, links to create/settings |
| `multiple_registration.create_registration_page_form` | `/admin/config/people/multiple_registration/{rid}/add` | Create/edit the page for role `{rid}` |
| `multiple_registration.delete_registration_page_form` | `/admin/config/people/multiple_registration/{rid}/remove` | Delete a page |
| `multiple_registration.common_settings_page_form` | `/admin/config/people/multiple_registration/settings` | Global options |
| `multiple_registration.access_settings_page_form` | `/admin/config/people/multiple_registration/access_settings` | Anonymous access to pages |
| `multiple_registration.role_registration_page` | `/user/register/{rid}` | The generated per-role registration form |

All admin routes require the `administer multiple_registration` permission.

## Create a registration page (UI)

1. Go to `/admin/config/people/multiple_registration` and click add for the target role.
2. Set **Registration page path** (the alias, e.g. `/vendor-signup`), an optional **Redirect
   path** (after submit), the **form modes** for the register and edit forms, and the **Hide
   registration form tab** flag.
3. Save. The page becomes available at `/user/register/{rid}` (aliased to your path), and a
   `path_alias` is created.

## Config storage

### Per-role pages — `multiple_registration.create_registration_page_form_config`
Keyed **by role id** (top-level), each value:

```yaml
<rid>:
  path: /vendor-signup              # URL alias
  url: /user/register/<rid>         # internal route path
  redirect_path: /welcome           # optional post-submit redirect
  hidden: 0                         # 1 = reachable only by URL (no tab)
  form_mode_register: register      # user form mode for registering
  form_mode_edit: default           # user form mode for editing
```

Read/set with drush:

```bash
drush cget multiple_registration.create_registration_page_form_config <rid>
```
```php
\Drupal::configFactory()->getEditable('multiple_registration.create_registration_page_form_config')
  ->set('vendor', [
    'path' => '/vendor-signup', 'url' => '/user/register/vendor', 'redirect_path' => '',
    'hidden' => 0, 'form_mode_register' => 'register', 'form_mode_edit' => 'default',
  ])->save();
```
(The admin form additionally creates the `path_alias` and rebuilds routes — do those too if you
bypass the form, e.g. call `\Drupal::service('router.builder')->rebuild()`.)

### Global options — `multiple_registration.common_settings_page_form_config`
| Key | Meaning |
|---|---|
| `multiple_registration_disable_main` | Disable the default `/user/register` page. |
| `enable_redirect_to_user_profile_when_user_logged_in` | Send logged-in users to their profile. |
| `enable_add_user_buttons_on_people_page` | Add per-role "Add user" buttons on People. |

### Access options — `multiple_registration.access_settings_page_form_config`
`multiple_registration_pages_allowed_list` — which registration pages anonymous users may reach.

## Per-field visibility per role

Fields carry third-party settings under `multiple_registration`
(`field.field.*.*.*.third_party.multiple_registration`): `user_additional_register_form` (roles
the field is shown for) and `user_additional_register_form_required` (roles it is required for),
so a field can appear/require only on specific roles' registration forms.

## Service

`multiple_registration.service` (`AvailableUserRolesService`):
- `getAvailableRoles()` — roles eligible for a registration page (excludes anonymous, authenticated
  and the admin role).
- `getRegistrationPages()` — the configured pages (url, redirect, role name, hidden, form modes).
