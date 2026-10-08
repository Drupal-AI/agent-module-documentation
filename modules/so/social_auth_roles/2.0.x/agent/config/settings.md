<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the auto-assigned role set

## Where

- UI: `/admin/config/social-api/social-auth/roles` (menu: Configuration → "Roles - Social Auth New User").
- Permission required: `administer social api authentication` (provided by `social_api`).
- Config object: `social_auth_roles.settings`, single key `social_auth_roles`.

## What the form does

`src/Form/SocialAuthRolesSettingsForm.php` builds one `checkboxes` element titled "New Social User
roles". Its options are produced by iterating `user_roles()` and dropping `anonymous` and
`authenticated`; every other role on the site is offered. On submit it stores the checkbox values
(role IDs for checked roles, `0` for unchecked) into `social_auth_roles.settings:social_auth_roles`.

## How the value is consumed

On the next Social Auth account creation, `SocialAuthSubscriber::onUserCreated()` iterates the stored
array and calls `$user->addRole($role)` for each entry `!== 0`. Because the subscriber listens only to
`SocialAuthEvents::USER_CREATED`:

- Roles are applied **once, at account creation**. They are not re-applied on later logins and are
  not removed if you later uncheck them.
- Changing this config affects **only accounts created after the change**. Existing accounts keep
  what they were granted.
- Ordinary Drupal registration is unaffected — only Social Auth's create path triggers this.

## Managing it as configuration

- There is **no config schema and no default config** shipped, so the config object does not exist
  until the form is saved once. Export with `drush config:export` after saving if you manage config
  in code; a hand-written import must match the form's structure
  (`social_auth_roles: { role_id: role_id, other_role: 0, ... }`).
- Read the current value (read-only):
  `drush config:get social_auth_roles.settings social_auth_roles`.

## Operational guidance

Every social signup receives the exact set selected here — the module does not map provider data to
roles. Choose only roles whose permissions are safe to hand to a weakly verified, self-service
identity. Avoid selecting `administrator` or any role with content-management, configuration, or
role/permission-granting rights.
