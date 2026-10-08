# Set up Real AES encryption

Real AES contributes the plugin; the Encrypt + Key modules provide the UI. There is **no
Real AES settings form**.

## Steps
1. Enable `real_aes`, `encrypt`, and `key`.
2. Generate a random **256-bit** key, e.g.
   `dd if=/dev/urandom bs=32 count=1 | base64 -i -` (base64) or write raw bytes to a file
   outside the web root: `dd if=/dev/urandom bs=32 count=1 > /path/secret.key`.
3. Create a Key at `/admin/config/system/keys/add`:
   - Key type: **Encryption**, key size **256**.
   - Key provider: **File** (store outside web root) or an off-site manager (Lockr, etc.).
     The **Configuration** provider is dev-only — too insecure for production.
4. Create an encryption profile at
   `/admin/config/system/encryption/profiles/add`:
   - Encryption method: **Authenticated AES (Real AES)**.
   - Key: the key from step 3.
5. Test via **Operations → Test** on the profiles list
   (`/admin/config/system/encryption/profiles`).

## Plugin details
`@EncryptionMethod(id = "real_aes", key_type_group = {"encryption"}, can_decrypt = TRUE)` —
`RealAESEncryptionMethod` wraps Defuse `Crypto::encrypt()/decrypt()`, throwing
`EncryptException` on failure. `checkDependencies()` and `hook_requirements()` both verify
`\Defuse\Crypto\Crypto` exists.

## Use in code
Encrypt/decrypt through the profile, not the plugin directly:
```php
$profile = \Drupal::entityTypeManager()->getStorage('encryption_profile')->load('my_profile');
$cipher  = \Drupal::service('encryption')->encrypt($plaintext, $profile);
$plain   = \Drupal::service('encryption')->decrypt($cipher, $profile);
```
Integrity is checked before decryption; tampered ciphertext throws rather than returning data.
