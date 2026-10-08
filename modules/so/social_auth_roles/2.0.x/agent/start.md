<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Social Auth Roles (social_auth_roles) — agent index

Automatically assigns an admin-selected set of roles to Drupal accounts **created through the
Social Auth suite**, in addition to `authenticated`, leaving ordinary Drupal registration
untouched. Version **2.0.1**. Core `^8 || ^9 || ^10 || ^11`. Requires `social_auth`.

## Mechanism (confirmed from source)

- One event subscriber: `src/EventSubscriber/SocialAuthSubscriber.php`, service
  `social_auth_roles.event_subscriber` (`social_auth_roles.services.yml`), tagged `event_subscriber`,
  no constructor arguments.
- Subscribes to **exactly one** event: `SocialAuthEvents::USER_CREATED` → `onUserCreated()`.
  This fires when Social Auth creates a **new** Drupal account for a social login. There is **no**
  subscriber on any login/authenticate event, so roles are applied **only at first account
  creation, never on subsequent logins**.
- `onUserCreated()` reads `\Drupal::config('social_auth_roles.settings')->get('social_auth_roles')`
  (an array of role IDs), and for each entry that is not `0` calls `$user->addRole($role)` and logs
  a notice. The account is saved by Social Auth's own create flow.
- The role list comes **entirely from admin config** — nothing from the provider (no claim, group,
  or email-domain mapping). Every social signup receives the same fixed set.

## Configuration

- Form: `src/Form/SocialAuthRolesSettingsForm.php` (class name is `socialAuthRolesSettingsForm`,
  a `ConfigFormBase`), editing config object `social_auth_roles.settings`, key `social_auth_roles`.
- Route `social_auth_roles.settings` at `/admin/config/social-api/social-auth/roles`
  (`social_auth_roles.routing.yml`), title "Social Auth Roles", permission
  `administer social api authentication` (defined by `social_api`, no `restrict access` flag).
- Menu link `social_auth_roles.settings` under `social_api.admin_config`
  (`social_auth_roles.links.menu.yml`), title "Roles - Social Auth New User".
- The form renders a `checkboxes` element listing **all roles except `anonymous` and
  `authenticated`** (`user_roles()` filtered), so administrator/editor roles are selectable.
- `hook_help()` in `social_auth_roles.module` describes the module on `help.page.social_auth_roles`.

## Facts an agent asks for

- Provides no permissions, no Drush commands, no plugin types.
- **Provides no config schema** — there is no `config/schema/*.yml` and no `config/install`
  default; `social_auth_roles.settings` is created only when the form is first saved.
- No hooks beyond `hook_help()`. No install/update hooks. No tests.
- Dependencies: `social_auth:social_auth` only.
- `README.md` / `README.txt` (README.txt is a stub) and `composer.json` (author Ethan Aho / eahonet,
  CommonPlaces Interactive) round out the package.

## Reference

- `agent/config/settings.md` — configuring the granted role set.

## Security note for operators

A role granted automatically at registration is granted to anyone who can complete the social login
flow, and social-provider identity is weakly verified. Select only low-trust roles here; do not grant
content-management, configuration, or permission-granting roles to auto-created social accounts.
