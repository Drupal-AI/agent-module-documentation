<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Key integration + configuration (KeyType / KeyInput)

This module has **no config form of its own**. The "Vault Transit key" is just the **name** of a key in
Vault's Transit engine, entered through the Key module using the two plugins below. The Vault connection
(address, TLS, auth token) is configured entirely in the **Vault** module.

## KeyType: vault_transit

File: `src/Plugin/KeyType/VaultTransitKeyType.php` — `class VaultTransitKeyType extends KeyTypeBase`.
```
@KeyType(
  id = "vault_transit",
  label = @Translation("Vault Transit Key"),
  description = @Translation("The name of a Vault Transit key"),
  group = "encryption",
  key_value = { "plugin" = "vault_transit_key" }
)
```
- `generateKeyValue(array $configuration): string` returns `''` (no auto-generation; the key already
  exists in Vault).
- `validateKeyValue(array $form, FormStateInterface $form_state, $key_value): void` is a no-op (comment:
  *"Validation of the key value is optional."*).
- `group = "encryption"` places it under the encryption group in Key's UI; `key_value.plugin` binds it
  to the KeyInput below.

## KeyInput: vault_transit_key

File: `src/Plugin/KeyInput/VaultTransitKeyInput.php` — `class VaultTransitKeyInput extends TextFieldKeyInput`
(from the **key** module).
```
@KeyInput(
  id = "vault_transit_key",
  label = @Translation("Vault Transit Key"),
  description = @Translation("The transit encryption key you wish to use.")
)
```
- `buildConfigurationForm()` calls the parent, then sets `key_value` title to *"Vault Transit Key"* and
  description to *"The name of the Vault transit key you wish to configure."* — i.e. a plain text field
  holding the transit key **name**, not secret material.

## End-to-end configuration flow (from the dependency chain)

1. Enable `encrypt`, `key`, `vault`, `encrypt_vault_transit`.
2. In the **Vault** module: set the Vault server address and the auth token (the token is stored via the
   **Key** module). Ensure the Transit secrets engine is enabled in Vault and a key exists in it.
3. Create a **Key** (Key module) of type **Vault Transit Key** (`vault_transit`); its value is the name
   of the Vault transit key.
4. Create an **Encryption Profile** (Encrypt module) whose encryption method is **Vault Transit**
   (`vault_transit`) and which uses the Key from step 3.
5. Any Encrypt-consuming code/module then encrypts/decrypts through Vault via that profile.

## What this module does NOT provide

No routes, no permissions, no services, no menu links, no `.module`/`.install`, no `config/install` or
`config/schema`. `configure` route is null. All persistence and access control come from the Encrypt,
Key, and Vault modules.
