<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — encryption service and trait

The whole module is a single service `encryption` and the trait it is built from.
Both expose the same three methods. Use the service when you just need to
encrypt/decrypt from code; use the trait when you want the methods directly on your
own class (e.g. a settings form) without a service call.

- Service id: `encryption`
- Class: `Drupal\encryption\EncryptionService` (empty — just `use EncryptionTrait;`)
- Interface: `Drupal\encryption\EncryptionServiceInterface`
- Trait: `Drupal\encryption\EncryptionTrait`

Requires a valid key in `$settings['encryption_key']` — see
[configure/key.md](../configure/key.md). Every method returns `NULL` when no valid
32-byte key is present.

## Methods

| Method | Signature | Returns |
|---|---|---|
| `encrypt` | `encrypt(string $value, bool $raw_output = FALSE)` | URL-safe base64 string by default; raw binary message if `$raw_output = TRUE`; `NULL` if the key is missing/invalid. |
| `decrypt` | `decrypt(string $value, bool $raw_input = FALSE)` | The original plaintext string; `NULL` if `$value` is empty, the key is missing/invalid, or the integrity check fails. Pass `$raw_input = TRUE` when `$value` is the raw binary message rather than the URL-safe base64 form. |
| `getEncryptionKey` | `getEncryptionKey()` | The 32 raw key bytes (`base64_decode` of the setting), or `NULL` if the decoded key is not exactly 32 bytes long. |

Notes on behavior (from `EncryptionTrait`):

- A **fresh random 16-byte IV** (`random_bytes(16)`) is generated on every `encrypt()`
  call, so encrypting the same input twice yields different output. `decrypt()` reads
  the IV back out of the message, so you do not store or pass it separately.
- The default output is **URL-safe base64**: standard base64 with `+ / =` rewritten to
  `- _` and `=` stripped. `decrypt()` reverses that before decoding. Use the
  `$raw_output` / `$raw_input` flags together when you want to store the compact raw
  binary instead.
- `decrypt()` verifies an embedded HMAC-SHA256 tag with `hash_equals()` before
  decrypting; a value that does not verify returns `NULL` rather than garbage.

## Message format

The raw binary message that `encrypt()` builds (and that the default URL-safe base64
wraps) is, in order:

| Bytes | Contents |
|---|---|
| 0–31 | HMAC-SHA256 tag over the rest of the message (format code + IV + ciphertext) |
| 32–33 | Format code `03` (two ASCII bytes) |
| 34–49 | Initialization vector (16 bytes) |
| 50…  | `AES-256-CTR` ciphertext |

## Usage — via the service

```php
/** @var \Drupal\encryption\EncryptionServiceInterface $enc */
$enc = \Drupal::service('encryption');

$stored = $enc->encrypt('big time secrets!');   // URL-safe base64, safe to store
$plain  = $enc->decrypt($stored);               // 'big time secrets!'
```

Prefer dependency injection over `\Drupal::service()` in your own services/controllers:
inject the `encryption` service and type-hint `EncryptionServiceInterface`.

## Usage — via the trait

Pull the methods straight onto a form handler when you want to persist an encrypted
value in configuration without exposing the plaintext on disk:

```php
use Drupal\encryption\EncryptionTrait;

class ExampleSettings extends ConfigFormBase {

  use EncryptionTrait;

  public function buildForm(array $form, FormStateInterface $form_state) {
    $config = $this->config('example_module.settings');
    $form['example_secret'] = [
      '#type' => 'textfield',
      '#title' => $this->t('Example Secret'),
      '#default_value' => $this->decrypt($config->get('example_secret')),
    ];
    return parent::buildForm($form, $form_state);
  }

  public function submitForm(array &$form, FormStateInterface $form_state) {
    parent::submitForm($form, $form_state);
    $this->config('example_module.settings')
      ->set('example_secret', $this->encrypt($form_state->getValue('example_secret')))
      ->save();
  }
}
```

A value encrypted under one `encryption_key` cannot be decrypted after the key
changes — `decrypt()` will return `NULL`. Keep the same key across instances that
share the same encrypted config export.
