# Implement an EncryptionMethod plugin

The cipher itself is a plugin. Managed by `plugin.manager.encrypt.encryption_methods`
(`EncryptionMethodManager`), discovered in `src/Plugin/EncryptionMethod/`.

## Skeleton
```php
namespace Drupal\my_module\Plugin\EncryptionMethod;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\encrypt\Attribute\EncryptionMethod;
use Drupal\encrypt\Plugin\EncryptionMethod\EncryptionMethodBase;

#[EncryptionMethod(
  id: 'my_cipher',
  title: new TranslatableMarkup('My Cipher'),
  description: new TranslatableMarkup('AES-256 via libsodium.'),
  key_type: ['encryption'],   // restrict allowed Key types (optional)
  can_decrypt: true,          // false for public-key-only methods
  deprecated: false,          // true = usable only by existing profiles
)]
class MyCipher extends EncryptionMethodBase {

  public function encrypt($text, $key) { /* return ciphertext */ }
  public function decrypt($text, $key) { /* return plaintext */ }
  public function checkDependencies($text = NULL, $key = NULL) {
    // return array of error strings if the method can't run (e.g. missing lib).
    return [];
  }
}
```

Older plugins use the annotation form `@EncryptionMethod` (`src/Annotation/EncryptionMethod.php`);
new code should use the PHP `#[EncryptionMethod]` attribute (`src/Attribute/EncryptionMethod.php`).

## Interface (`EncryptionMethodInterface`)
`encrypt($text,$key)`, `decrypt($text,$key)`, `checkDependencies($text,$key)`, `getLabel()`,
`canDecrypt()`, `isDeprecated()`. Implement
`EncryptionMethodPluginFormInterface` (build/validate/submit) if the method needs its own
configuration form on the profile. Core ships only a base/stub; real ciphers come from add-on
modules such as **Real AES** — model new methods on those.
