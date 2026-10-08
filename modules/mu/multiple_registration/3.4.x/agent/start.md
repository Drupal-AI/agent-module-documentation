# Multiple Registration — agent index

Creates a dedicated user-registration page per role at `/user/register/{rid}` (own alias,
redirect, form modes, visibility); on submit the user gets that role. Requires `path_alias`.
Permission `administer multiple_registration`.

- **Create/manage per-role registration pages, global + access settings, config keys, service** →
  [configure/registration-pages.md](configure/registration-pages.md)

Key facts:
- Configure route (`configure`): `multiple_registration.multiple_registration_list_index` →
  `/admin/config/people/multiple_registration`.
- Per-role pages stored in config object `multiple_registration.create_registration_page_form_config`,
  keyed by role id → `{path, url, redirect_path, hidden, form_mode_register, form_mode_edit}`
  (`url` is `/user/register/{rid}`; `path` is the alias). A `path_alias` is also created.
- Global options: `multiple_registration.common_settings_page_form_config`
  (`multiple_registration_disable_main`, `enable_redirect_to_user_profile_when_user_logged_in`,
  `enable_add_user_buttons_on_people_page`) and
  `multiple_registration.access_settings_page_form_config` (`multiple_registration_pages_allowed_list`).
- Per-field third-party settings (`field.field.*.*.*.third_party.multiple_registration`) show/require
  fields for specific roles.
- Service `multiple_registration.service` (`AvailableUserRolesService`): `getAvailableRoles()`,
  `getRegistrationPages()`.
