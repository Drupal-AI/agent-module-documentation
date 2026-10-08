<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Working with the display name (user_display_name)

The whole module is four hook implementations in
`src/Hook/UserDisplayNameHooks.php` (dispatched from `user_display_name.module` as
`#[LegacyHook]` wrappers). There is no config, no service you call, no plugin type — you interact
with it entirely through the `display_name` base field on the `user` entity and through core's
own name-resolution hook.

## The field

- Base field `display_name` on the `user` entity, added by `hook_entity_base_field_info`
  (`entityBaseFieldInfo`): type **`string`**, label "Display Name", translatable, revisionable
  (if the entity type is), display-configurable on both view and form, form widget
  `text_textfield` at weight `-1`. Not bundle-specific.
- Installed as a real field-storage definition by `hook_install`
  (`user_display_name.install`) via `EntityDefinitionUpdateManager::installFieldStorageDefinition`;
  removed on uninstall. `user_display_name.post_update.php`
  (`user_display_name_post_update_convert_field_definition`) migrates existing data with
  `updateFieldableEntityType` (and toggles MySQL `NO_AUTO_VALUE_ON_ZERO` so the anonymous
  user, uid 0, migrates correctly).

Read / set it like any base field:

```php
$user = \Drupal\user\Entity\User::load($uid);
$current = $user->get('display_name')->value;      // string or NULL
$user->set('display_name', 'Jane Smith');
$user->save();
```

## The mechanism (how it becomes the shown name)

- `hook_user_format_name_alter` (`userFormatNameAlter`) is the core hook Drupal calls whenever it
  formats an account's name (`user_format_name()` / `AccountInterface::getDisplayName()`). This
  module replaces the name with the field value **only when it is non-empty**:
  `if (!empty($account->display_name->value)) { $name = $account->display_name->value; }`.
  Because this rides core's own resolution, every place that renders an *account* — authored-by
  lines, comment attributions, `{{ user.displayname }}` — picks it up automatically.
- `hook_ENTITY_TYPE_prepare_form` for user (`userPrepareForm`) seeds an empty `display_name` with
  the current username when the user-edit form is built, so a saved profile keeps showing the same
  name until the user deliberately changes it.

## Overriding or extending the behavior

- To further transform the name (e.g. "Last, First", append a role, fall back to a profile field),
  implement `hook_user_format_name_alter()` in your own module with a **later hook weight** than
  `user_display_name` so it runs after this one; mutate the `&$name` string.
- The value assigned to `$name` is a plain PHP string; keep it that way. Core escapes the formatted
  name on output — do not wrap it in `Markup`/mark it safe, or you would opt the name out of
  escaping everywhere it is printed.

## Where the raw username still shows (not covered by the hook)

The hook only affects code paths that *format an account's name*. These read `name` directly and
are unaffected, which matters when the goal is privacy:

- the people listing at `/admin/people` (Views `name` field),
- JSON:API / REST user resources (`name` property),
- any View that adds the user `name` field rather than rendering the account entity,
- login and password-reset flows.
