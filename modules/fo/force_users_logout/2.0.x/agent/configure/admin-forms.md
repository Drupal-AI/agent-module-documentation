<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The three Force Users Logout forms

All four routes require the **core** permission `administer users` (`_permission: 'administer users'`);
the module ships no `*.permissions.yml`.

| Route | Path | Form / controller | Tab title |
|---|---|---|---|
| `force_users_logout.individual_user_form` | `/admin/config/force-users-logout/individualuser` | `IndividualUserLogoutForm` (`singleuser_force_logout_form`) | Individual User |
| `force_users_logout.rolebased_logout_form` | `/admin/config/force-users-logout/rolebasedlogout` | `RoleBasedLogoutForm` (`rolebased_force_logout_form`) | Role Based |
| `force_users_logout.allotherusers_logout_form` | `/admin/config/force-users-logout/otheruserslogout` | `AllOtherUsersLogoutForm` (`allotherusers_force_logout_form`) | All Other Users |
| `force_users_logout.autocomplete` | `/force-users-logout/autocomplete` | `AutocompleteController::handleAutocomplete` (JSON) | — |

Local tasks put all three on one page; the menu link
(*Configuration → Development → Force users logout settings*, `parent: system.admin_config_development`,
weight 99) points at the first one, which is also the `configure` route in `*.info.yml`.

## Individual User

- One required textfield `uid` ("Name of the user to be logged out") with
  `#autocomplete_route_name: force_users_logout.autocomplete`.
- The autocomplete controller queries active (`status = 1`) users whose `name` matches
  `%string%` and returns `{"value": "<name> (<uid>)", "label": "<name>"}`.
- Submit runs `preg_match('#\((.*?)\)#', $value, $m)` and treats `$m[1]` as the uid — so the
  submitted text **must** contain `(<uid>)`. Typing a bare username throws (no match).

## Role Based

- `#type: checkboxes` named `selectrole`, required.
- Options are **all roles except** `administrator`, `authenticated` and `anonymous`. On a site
  with no custom roles the option list is empty (`$optionsarray ?? []`).
- Submit: for each checked role, `entityQuery('user')->condition('status', 1)->condition('roles', $rid)`
  and delete each result's session.

## All Other Users

- A single required checkbox `selectallogout` ("This setting will force logout all users except admin").
- Submit: `entityQuery('user')` with `status = 1`, `roles <> 'administrator'`, `roles <> 'anonymous'`,
  then delete each result's session. Message: *"All the users except admin role are logged out"*.
- Note this matches on the **`administrator` role id**, not on "user 1" and not on the
  `is_admin` role flag — a differently named admin role is not exempt.

## What is (not) stored

The forms extend `ConfigFormBase` and declare `getEditableConfigNames()` values
(`force_users_logout.individual_user_form`, `force_users_logout.rolebased_logout_form`,
`force_users_logout.allotherusers_logout_form`), but there is no `config/install` or
`config/schema` in the project and the submit handlers never write those objects. Do not look
for settings there — `drush config:get force_users_logout.individual_user_form` reports the
config does not exist on a fresh install.
