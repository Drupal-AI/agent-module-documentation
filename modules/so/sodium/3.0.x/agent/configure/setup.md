<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setup: extension, key, profile

## 1. Requirements

```bash
php -m | grep -i sodium          # libsodium PHP extension must be listed
php -r 'echo SODIUM_CRYPTO_STREAM_KEYBYTES;'   # 32
composer require drupal/sodium   # pulls halite, encrypt, key
drush en sodium -y               # fails at requirements check if Halite is missing
```

`hook_requirements('install')` errors with *"Sodium requires the Halite PHP library"* when
`\ParagonIE\Halite\Symmetric\Crypto` is not autoloadable — that is a Composer problem, not a
Drupal one.

## 2. Generate a 256-bit key

The key must be **exactly 32 bytes**. Two common shapes:

```bash
# a) raw binary file, kept outside the docroot
dd if=/dev/urandom bs=32 count=1 > /var/secrets/sodium.key

# b) base64 for pasting into a Key entity or an env var
dd if=/dev/urandom bs=32 count=1 | base64 -i -
```

## 3. Create the Key entity

UI: `/admin/config/system/keys/add` — *Key type* **Encryption**, *Key size* **256**, then pick a
provider (File for (a), Configuration for (b), or a secrets-manager provider).

From Drush, using the env provider (preferred — nothing secret in the database or in config
exports):

```bash
ddev dotenv set .ddev/.env --sodium-key="$(dd if=/dev/urandom bs=32 count=1 2>/dev/null | base64)"
ddev restart
ddev exec 'test -n "$SODIUM_KEY"' && echo "env var present"

drush key:save sodium_key \
  --label='Sodium encryption key' \
  --key-type=encryption \
  --key-type-settings='{"key_size":"256"}' \
  --key-provider=env \
  --key-provider-settings='{"env_variable":"SODIUM_KEY","base64_encoded":true,"strip_line_breaks":true}' \
  --key-input=none -y

drush cget key.key.sodium_key
```

Base64 handling is a common footgun: check *Base64-encoded* in the provider settings **only** if
the stored value is base64. A 44-character base64 string decodes to 32 bytes; storing it without
the flag makes the key 44 bytes and `checkDependencies()` rejects it with
*"The encryption key must be exactly 32 bytes."*

## 4. Create the encryption profile

UI: `/admin/config/system/encryption/profiles/add` — *Encryption method* **Sodium**, *Encryption
key* = the key from step 3.

```bash
drush php:eval '
\Drupal\encrypt\Entity\EncryptionProfile::create([
  "id" => "sodium_default",
  "label" => "Sodium default",
  "encryption_method" => "sodium",
  "encryption_key" => "sodium_key",
])->save();
'
drush cget encrypt.profile.sodium_default
```

## 5. Test it

UI: the profiles listing at `/admin/config/system/encryption/profiles` has a **Test** operation.

From code:

```bash
drush php:eval '
$p = \Drupal\encrypt\Entity\EncryptionProfile::load("sodium_default");
$svc = \Drupal::service("encryption");
$ct = $svc->encrypt("hello", $p);
print "roundtrip: " . var_export($svc->decrypt($ct, $p) === "hello", TRUE) . "\n";
print "ciphertext is binary: " . var_export($ct !== base64_encode($ct), TRUE) . "\n";
'
```

## Storage note

`Crypto::encrypt(..., TRUE)` returns **raw binary**. Storing it in a `varchar`/`text` column with
a strict charset can mangle it. Either store in a `BLOB`/binary column or base64-encode before
persisting:

```php
$stored = base64_encode(\Drupal::service('encryption')->encrypt($plaintext, $profile));
$plain  = \Drupal::service('encryption')->decrypt(base64_decode($stored), $profile);
```

Modules that integrate with Encrypt (Field Encryption, Webform encryption, Real AES consumers)
handle this themselves.

## Key rotation

There is no re-encrypt helper here. Rotation means: create a new Key entity and a new profile,
decrypt with the old profile and re-encrypt with the new one for every stored value, then retire
the old key. Keep the old key available until that pass completes — losing it means losing the
data, since the ciphertext is authenticated and unrecoverable without the key.
