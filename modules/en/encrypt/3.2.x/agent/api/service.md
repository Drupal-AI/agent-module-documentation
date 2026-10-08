# Encrypt / decrypt in code

Service id `encryption` (`Drupal\encrypt\EncryptService`, interface
`EncryptServiceInterface`).

```php
$profile = \Drupal::entityTypeManager()
  ->getStorage('encryption_profile')
  ->load('my_profile');

$service = \Drupal::service('encryption');
$cipher  = $service->encrypt('secret value', $profile);   // string
$plain   = $service->decrypt($cipher, $profile);          // string
```

Interface methods:
| Method | Purpose |
|---|---|
| `encrypt($text, EncryptionProfileInterface $profile)` | Encrypt `$text` using the profile's method + key. |
| `decrypt($text, EncryptionProfileInterface $profile)` | Reverse of the above. Throws if the method `canDecrypt()` is false. |
| `loadEncryptionMethods($with_deprecated = TRUE)` | List available `EncryptionMethod` plugin definitions. |

Inject `@encryption` into your own services rather than using `\Drupal::service()`.

## Finding profiles
Service `encrypt.encryption_profile.manager`
(`EncryptionProfileManagerInterface`): `getEncryptionProfile($id)`,
`getAllEncryptionProfiles()`, `getEncryptionProfilesByEncryptionMethod($method_id)`,
`getEncryptionProfilesByEncryptionKey($key_id)`, `getEncryptionProfileNamesAsOptions()`.

Exceptions live in `Drupal\encrypt\Exception\` (`EncryptException`,
`EncryptionMethodCanNotDecryptException`).
