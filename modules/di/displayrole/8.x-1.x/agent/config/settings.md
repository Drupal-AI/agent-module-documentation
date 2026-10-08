<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Display Role — configuration, hooks, and operation

Everything lives in `displayrole.module` (~90 lines). No `src/`, routes, permissions, services,
plugins, `.install`, or `config/` are shipped.

## Install / enable

- `composer require drupal/displayrole` then `drush en displayrole -y`.
- Requirement in `displayrole.info.yml`: `dependencies: [ drupal:user ]`,
  `core_version_requirement: ^9 || ^10 || ^11`.
- `info.yml` sets `configure: entity.entity_view_display.user.default` — the module's config
  entry point is core's user **Manage display** form (no dedicated settings form).

## The display component

`displayrole_entity_extra_field_info()` (hook_entity_extra_field_info):

```
$fields['user']['user']['display']['roles'] = [
  'label' => t('Roles'),
  'description' => t("User module 'roles' view element."),
  'weight' => 5,
];
```

This registers a **display-only** extra field `roles` on the `user` bundle. It shows up on
People » Account settings » Manage display; an admin drags it out of the "Disabled" region to
make it appear on the profile.

## Rendering the roles

`displayrole_user_view(array &$build, UserInterface $account, EntityViewDisplayInterface $display)`
(hook_ENTITY_TYPE_view for `user`):

- Runs only if `$display->getComponent('roles')` is set (i.e. the component is enabled on the
  active view mode). If it is in "Disabled", nothing renders.
- `$rids = $account->getRoles()` → the account's role ids.
- `array_intersect_key(_displayrole_user_role_names(), array_flip($rids))` → `[rid => label]` for
  just the roles the user has.
- Builds `$build['roles'] = ['#theme' => 'item_list__roles', '#items' => $roles, '#title' => t('Roles')]`.

Because the element is part of the user render array/display, it is also reachable from
`user.html.twig` without a custom preprocess.

`_displayrole_user_role_names()` returns `array_map(fn($r) => $r->label(), Role::loadMultiple())`
— a `[rid => label]` map, a local replacement for core's removed `user_role_names()`. Anonymous
and authenticated roles are intentionally **not** unset (a `@TODO` notes this).

## Optional: append roles to usernames

`displayrole_preprocess_username(&$variables)` runs on **every** rendered username:

- Gated by `\Drupal::config('displayrole.settings')->get('append_role_to_username')`.
- When truthy, renders an `item_list` of role names via
  `\Drupal::service('renderer')->renderPlain(...)` and does
  `$variables['extra'] .= ' (' . $roles_rendered . ')'`.

There is **no admin UI** and **no shipped default** for `displayrole.settings` (no
`config/install`, no `config/schema`). To enable it:

```
drush config:set displayrole.settings append_role_to_username 1
```

Note: this code path uses `array_intersect(_displayrole_user_role_names(), array_flip($rids))`
(intersect on values, not keys) — a known quirk; the reliable, supported path is the Manage display
component above.

## Theming

- Roles render through core's `item_list` theme (labels are HTML-escaped by the theme layer).
- Themers can target the `item_list__roles` theme hook suggestion for custom markup.

## What it does NOT provide

No per-role selection/filtering (all of a user's roles are shown), no permission of its own,
no token, no Views handler, no block. Visibility of the profile itself is governed by core
(`access user profiles` and any field/entity access on the user view).
