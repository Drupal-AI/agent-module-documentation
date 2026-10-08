# Configure: arranging the split account fields

The module has **no configure route of its own** (`configure` is `null` in info.yml).
Everything is done on the core user **Manage form display**:

- Admin UI: `/admin/config/people/accounts/form-display`
  (route `entity.entity_form_display.user.default`).
- Config entity: `core.entity_form_display.user.user.default`.

## The seven pseudo-fields the module adds

After enabling, these appear as separate rows (component keys) on the form display,
replacing the single bundled "User name and password" element (`account`), which the module
removes from the list:

| Component key | Label |
|---|---|
| `name` | Username |
| `mail` | E-mail address |
| `pass` | Password |
| `current_pass` | Current password |
| `roles` | Roles |
| `status` | Status |
| `notify` | Notify user about new account |

Each is an ordinary form-display component: it has a `weight` and a `region`
(`content` = visible, or the `hidden` region = disabled). Lower weight sorts earlier.

## Reorder / hide with drush (no UI)

```php
// E-mail above Username, and hide Current password.
drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("user.user.default");
  $fd->setComponent("mail", ["weight" => -5, "region" => "content"]);   // show, sort early
  $fd->setComponent("name", ["weight" => -4, "region" => "content"]);
  $fd->removeComponent("current_pass");                                  // disable/hide it
  $fd->save();
'
drush cr
```

- `setComponent($key, ['weight' => N, 'region' => 'content'])` shows/positions a field.
- `removeComponent($key)` moves it to the disabled/`hidden` region (it stops rendering).
- Read current state with `$fd->getComponent($key)` (returns `null` if hidden) or
  `drush cget core.entity_form_display.user.user.default`.

## Notes

- Install sets the module weight to **101** so its form alters run after other modules.
- On the anonymous `user.reset` route the module skips splitting when `simple_pass_reset`
  is enabled, to stay compatible with that flow.
- Because these are standard components, they work with the Field Group module and can be
  interleaved with real user fields (picture, contact, timezone, custom fields).
- There is no separate "revert" config — to restore core behaviour, uninstall the module
  (its uninstall hook invalidates the form-display cache).
