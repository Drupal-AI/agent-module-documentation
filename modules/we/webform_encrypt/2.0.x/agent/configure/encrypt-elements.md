<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable encryption on a webform element

There is **no module settings form and no configure route**. Encryption is turned on
per element, per webform, either in the element UI or directly in the webform config.

## Prerequisite: an encryption profile

Encryption uses an **Encrypt** module encryption profile (`encrypt.profile.<id>`), which in
turn references a **Key** (`key.key.<id>`). If no profile exists, the Encryption fieldset shows
"Please configure the encryption profile to enable encryption for the element." Create one at
*Configuration → System → Encryption profiles* (`/admin/config/system/encryption/profiles`).

## Where the setting is stored

Config entity: `webform.webform.<webform_id>`
Path within it:

```yaml
third_party_settings:
  webform_encrypt:
    element:
      <element_key>:
        encrypt: true
        encrypt_profile: <encryption_profile_id>
```

Each encrypted element is one entry under `element`, keyed by the element machine name.
If no element on a webform is encrypted, the whole `webform_encrypt` third-party setting is
removed (the module unsets it to avoid a spurious config dependency).

## Via the UI

1. Edit the webform, open the element you want to protect (**Build** tab → the element's *Edit*).
2. Go to the **Advanced** tab; find the **Encryption** fieldset.
3. Tick **Encrypt this field's value** and pick an **Encryption Profile**.
4. Save the element, then save the webform.

Only **input** elements offer the fieldset (`$element_handler->isInput()` must be TRUE); markup /
container elements do not.

## Via drush php:eval (scriptable)

```php
$webform = \Drupal\webform\Entity\Webform::load('contact');
$config = $webform->getThirdPartySetting('webform_encrypt', 'element') ?? [];
$config['ssn'] = ['encrypt' => TRUE, 'encrypt_profile' => 'my_profile'];
$webform->setThirdPartySetting('webform_encrypt', 'element', $config);
$webform->save();
```

To stop encrypting an element, unset its key; if the array becomes empty call
`$webform->unsetThirdPartySetting('webform_encrypt', 'element')` before saving.

## Read it back

```bash
drush config:get webform.webform.contact third_party_settings.webform_encrypt
```

Or in PHP: `\Drupal\webform\Entity\Webform::load('contact')->getThirdPartySetting('webform_encrypt', 'element')`.

## Notes

- Turning encryption on affects **new** submissions saved after the change; existing rows keep
  their current (plaintext or previously-encrypted) form until re-saved.
- The stored value is `serialize(['data' => <ciphertext>, 'encrypt_profile' => <id>])`, so the
  module can decrypt even if the element's configured profile later changes.
- Config schema `webform.settings.third_party.webform_encrypt` validates the `encrypt` (boolean)
  and `encrypt_profile` (string) keys.
