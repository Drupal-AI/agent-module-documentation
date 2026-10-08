<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration: decoupled_auth.settings

## Install & enable

`drush en decoupled_auth`. Only core `user` is required. Enabling runs `hook_install()`, which swaps
the user entity class + storage schema, rewrites the name/mail constraints, makes `name` NULL-able,
adds the "Has web account?" filter to the `user_admin_people` view, and (if Profile is enabled)
installs the `profile_<type>` base fields. Uninstall reverts all of this. Module weight is set to `1`
so its hooks run after `user_registrationpassword`.

## Settings form

Route **`decoupled_auth.settings`** → path `admin/config/people/decoupled-auth`, form
`Drupal\decoupled_auth\DecoupledAuthSettingsForm`, permission **`administer account settings`**. Menu
link under `user.admin_index` (`decoupled_auth.links.menu.yml`). `data.json.configure` =
`decoupled_auth.settings`.

## Config object `decoupled_auth.settings`

Defaults from `config/install/decoupled_auth.settings.yml`; schema in
`config/schema/decoupled_auth.schema.yml` (type `config_object`).

```yaml
acquisitions:
  behavior_first: false            # boolean — acquire the first of multiple matches
  registration: true               # boolean — attempt acquisition on user registration
  registration_notice_demote: false # boolean — demote the no-verification status error to a warning
  protected_roles:                 # sequence<string> — role ids excluded from acquisition by default
    - administrator
unique_emails:
  mode: all                        # string — one of the modes below
  # roles: []                      # sequence<string> — roles used by with_role / without_role modes
```

### `acquisitions` keys

- `behavior_first` — when multiple users match, take the first instead of failing on ambiguity.
- `registration` — when TRUE, the register form tries to link the registrant to a matching **decoupled**
  user by email (see [../api/integrations.md](../api/integrations.md)).
- `registration_notice_demote` — controls the severity of the `hook_requirements()` runtime check
  (`decoupled_auth_registration_acquisitions`): if registration acquisitions are on but email
  verification (`user.settings.verify_mail`, or `user_registrationpassword` verification) is off, the
  status report shows an **error**; set this TRUE to demote it to a warning (e.g. when another
  verification mechanism is in place).
- `protected_roles` — roles that `AcquisitionService` excludes from matches unless
  `BEHAVIOR_INCLUDE_PROTECTED_ROLES` is passed. Default `administrator`. Added by
  `decoupled_auth_update_8002()`.

### `unique_emails` keys

`mode` (constants on `Drupal\decoupled_auth\DecoupledAuthConfig`):

- `all` (`UNIQUE_EMAILS_MODE_ALL_USERS`) — every user, coupled or decoupled, needs a unique email.
- `with_role` (`UNIQUE_EMAILS_MODE_WITH_ROLE`) — coupled users, plus decoupled users **in** the
  selected `roles`, need unique emails; other decoupled users may share.
- `without_role` (`UNIQUE_EMAILS_MODE_WITHOUT_ROLE`) — coupled users, plus decoupled users **not in**
  the selected `roles`, need unique emails.
- `none` (`UNIQUE_EMAILS_MODE_COUPLED`) — only coupled users need unique emails; decoupled users may
  freely share/reuse an address.

`roles` — the role id set used by the `with_role` / `without_role` modes. Coupled users are **always**
required to have a unique email regardless of mode (enforced in `DecoupledAuthUserMailUniqueValidator`).
