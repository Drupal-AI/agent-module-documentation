<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UserRestrictionType plugins

Restriction kinds are pluggable. A `user_restrictions` rule stores a `plugin` ID; when the rule is
evaluated, `UserRestrictions::matches()` asks that plugin (`getTypePlugin()->buildData(...)`) to
produce the value to test, then runs `preg_match('/' . $pattern . '/i', $value)`.

## Plugin system
- Namespace: `Plugin/UserRestrictionType`.
- Attribute: `Drupal\user_restrictions\Attribute\UserRestrictionType` (`id`, `label`, optional
  `weight`, `deriver`). A legacy annotation class `Annotation/UserRestrictionType` also exists.
- Interface: `Drupal\user_restrictions\Plugin\UserRestrictionTypeInterface`.
- Base class: `Plugin/UserRestrictionType/UserRestrictionTypeBase` (injects entity storage,
  logger channel `logger.channel.user_restrictions`, `datetime.time`).
- Manager service: `plugin.manager.user_restriction_type`
  (`Drupal\user_restrictions\UserRestrictionTypeManager`), interface-aliased as
  `Drupal\user_restrictions\UserRestrictionTypeManagerInterface` (and `user_restrictions.type_manager`).
  Alter hook: `user_restriction_type_info`. `getTypesAsOptions()` supplies the radios on the edit form.
- Each rule holds one plugin via a `UserRestrictionTypePluginCollection`
  (`DefaultSingleLazyPluginCollection`).

## The interface (2.1.x)
The active method is:

```php
public function buildData(array $form, FormStateInterface $form_state, string $form_id, string $type = 'string'): string|object|null;
```

It returns the string to match (or `null` to opt out for this form). Plugins also set a log
message and an error message via `setLogMessage()` / `setErrorMessage()`, surfaced by
`getLogMessage()` / `getErrorMessage()`; the label is exposed via `getLabel()`.

Deprecated (removed in 3.0.0, kept as `@trigger_error` stubs): `matches()`, `getPatterns()`,
`matchesValue()`, and the manager's `getTypes()` / `getType()`.

## Built-in plugins
| ID | Class | Label | Value matched |
|----|-------|-------|---------------|
| `name` | `Name` | Username | `$form_state->getValue('name')` |
| `user_restrictions_email` | `Email` | Email | `$form_state->getValue('mail')` |
| `user_restrictions_client_ip` | `ClientIp` | Client IP | `$requestStack->getCurrentRequest()->getClientIp()` |

`ClientIp` uses `Request::getClientIp()`, which respects Drupal's configured trusted reverse
proxies (`$settings['reverse_proxy']` / `reverse_proxy_addresses`) rather than reading a raw
`X-Forwarded-For` header — so it is not trivially spoofable when trusted proxies are set correctly.

## Username plugin ID inconsistency
`Name` registers with `id: 'name'` (`src/Plugin/UserRestrictionType/Name.php`), but:
- the entity's default `$plugin` property is `'user_restrictions_username'`
  (`src/Entity/UserRestrictions.php`), and
- `user_restrictions_post_update_change_plugin_id()` rewrites stored `name` →
  `user_restrictions_username` (`user_restrictions.post_update.php`).

No plugin registers under `user_restrictions_username`. New rules created through the UI store
`name` (from `getTypesAsOptions()`) and work; rules migrated by that post-update to
`user_restrictions_username` reference a non-existent plugin. Verify a site's stored `plugin`
values match a registered ID before relying on username rules.

## Adding a restriction type
Create a class in `your_module/Plugin/UserRestrictionType/`, add the
`#[UserRestrictionType(id: '...', label: new TranslatableMarkup('...'))]` attribute, extend
`UserRestrictionTypeBase`, and implement `buildData()` to return the value to match (reading from
`$form_state`, the request, the loaded account, etc.). Set log/error messages inside `buildData()`.
