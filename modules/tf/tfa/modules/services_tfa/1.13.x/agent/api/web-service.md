<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `tfa_login` Services endpoint

> **Deprecated.** The submodule (`lifecycle: deprecated`) and the `GenericValidation` class
> (`@deprecated in tfa:8.x-1.4`, removed in `tfa:2.0.0-alpha3`) have no replacement. Prefer the
> browser login flow of the base module. Documented here for maintenance of existing sites.

## Install

```bash
drush en services_tfa -y
```

Requires the contrib **`services`** module and the **`tfa`** base module. The endpoint's actual URL
prefix, request formats, and access are governed by the Services endpoint you attach this
definition to (Services configuration), not by this submodule.

## Plugin

`Drupal\services_tfa\Plugin\ServiceDefinition\GenericValidation` (extends
`Drupal\services\ServiceDefinitionBase`, implements `ContainerFactoryPluginInterface`):

```
@ServiceDefinition(
  id = "tfa_login",
  methods = { "POST" },
  title = "TFA Login",
  category = "Security",
  path = "auth/tfa"
)
```

Injected services (`create()`): `user.data`, `plugin.manager.tfa.validation`, `lock`,
`config.factory`.

## Request handling (`processRequest`)

Reads three request parameters:

| Param | Meaning |
|---|---|
| `id` | User id (uid) whose second factor is being validated. |
| `code` | The one-time code to check. |
| `plugin_id` | Validation plugin id (e.g. `tfa_totp`, `tfa_hotp`, `tfa_recovery_code`). |

Steps:

1. If any of `id` / `code` / `plugin_id` is empty → `AccessDeniedHttpException('Required parameters missing.')`.
2. If `plugin_id` is **not** a key of `tfa.settings.allowed_validation_plugins` →
   `AccessDeniedHttpException('Invalid plugin_id.')`.
3. Instantiate the plugin for that uid (`createInstance($plugin_id, ['uid' => $uid])`), acquire a
   per-uid lock `tfa_validate_<uid>`, and call `$plugin->validateRequest($code)` (which, for TOTP,
   left-pads the code and records the accepted code on success to block replay).
4. Release the lock. If `isAlreadyAccepted()` → `AccessDeniedHttpException` ("recently used"); else
   if not valid → `AccessDeniedHttpException('Invalid application code...')`; else return `1`.

## Notes for maintainers

- `validateRequest()` is not part of `TfaValidationInterface` (there is a `@todo` about it in the
  source); it exists on the built-in TOTP/HOTP/recovery-code plugins. A custom validation plugin
  used here must implement it (and `isAlreadyAccepted()`).
- All secret handling (seed decryption via the Encrypt profile, HOTP counter/TOTP time-window
  advancement, recovery-code consumption) happens in the base module's plugin — this endpoint adds
  none of its own.
- A commented-out `processRoute()` note in the source indicates an unresolved 403 when trying to set
  `_user_is_logged_in: FALSE` on the route.
