<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Integration plugins (`@Integration`)

Pluggable account-resolution layer that turns a BankID response into a Drupal user.

## Plugin type wiring
- Annotation: `Drupal\bankid\Annotation\Integration` (id, label).
- Interface: `IntegrationInterface` — `getLabel()`, `getUser(string $response): EntityInterface|NULL`, `createUser(string $response): UserInterface`, `hash(string $str): string`.
- Base: `IntegrationBase` (abstract, `PluginBase` + `ContainerFactoryPluginInterface`), injects `externalauth.externalauth`. Const `PROVIDER_NAME = 'bankid'`. `hash()` = `hash('sha256', $str . Settings::get('hash_salt', ''))`.
- Manager: `IntegrationManager` (`DefaultPluginManager`), service `plugin.manager.bankid.integration`, discovery dir `src/Plugin/BankID`, alter hook `hook_bankid_integration_info`, cache tag `bankid_integration_info`.
- Default plugin: `Drupal\bankid\Plugin\BankID\DefaultIntegration` (id `default`).

## DefaultIntegration
- `getUser($response)`: `json_decode` → `authname = hash(completionData.user.personalNumber)` → `externalAuth->load($authname, 'bankid')` or NULL.
- `createUser($response)`: same `authname`; Drupal username = `md5($authname)` (personnummer hash is >60 chars); `externalAuth->register($authname, 'bankid', ['name' => $name])`. No password (externalauth account).

The externalauth `authname` is the salted SHA-256 of the personal number, so the raw
personnummer is never stored as the mapping key; the account is matched purely on that hash.

## Writing a custom integration
1. In a custom module create `src/Plugin/BankID/MyIntegration.php` extending `IntegrationBase`.
2. Annotate `@Integration(id = "my_id", label = @Translation("My integration"))`.
3. Implement `getUser()` (return an existing account or NULL) and `createUser()` (provision + return a `UserInterface`), typically deriving identity from `completionData.user.personalNumber` and syncing to a CRM.
4. Enable the module; select the plugin under BankID Settings → "BankID integration".
`BankIDSettingsForm::buildIntegrationOptions()` lists every discovered plugin (sorted by label).

## Related account behaviour (`bankid.module`)
- `hook_validation_constraint_alter`: swaps core `ProtectedUserField` for
  `BankIDProtectedUserFieldConstraint` + `...Validator`, which **skips** the protected-field
  check (which normally demands the current password) for accounts mapped to provider `bankid`
  (via `authmap->get(uid, 'bankid')`) — since those users have no Drupal password.
- `hook_form_user_form_alter`: for a BankID-provisioned user, hides `current_pass` and `pass`
  on the user-edit form.
