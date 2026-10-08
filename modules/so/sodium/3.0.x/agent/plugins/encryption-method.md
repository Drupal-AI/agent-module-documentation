<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The encryption method plugin

## Definition

```php
#[EncryptionMethod(
  id: "sodium",
  title: new TranslatableMarkup("Sodium"),
  description: new TranslatableMarkup("Uses Libsodium for cryptographic operations."),
  key_type: ["encryption"]
)]
class SodiumEncryptionMethod extends EncryptionMethodBase implements EncryptionMethodInterface
```

This is the Encrypt module's plugin type (`Drupal\encrypt\Attribute\EncryptionMethod`, discovered
under `Plugin/EncryptionMethod/`). `key_type` restricts profile forms to Key entities of type
`encryption`.

## `checkDependencies($text = NULL, $key = NULL): array`

Returns an array of error strings; empty means usable. Two checks:

1. `class_exists('\ParagonIE\Halite\Symmetric\Crypto')` → *"Sodium requires the Halite PHP library."*
2. When a key is supplied and `strlen($key) !== SODIUM_CRYPTO_STREAM_KEYBYTES` (32) →
   *"The encryption key must be exactly 32 bytes."*

Encrypt calls this before encrypt/decrypt, so a wrong-sized key surfaces as a profile error rather
than a crash.

## `encrypt($text, $key): string`

```php
$key_hidden     = new HiddenString($key);
$encryption_key = new EncryptionKey($key_hidden);     // InvalidKey → EncryptException
$text_hidden    = new HiddenString($text);
return Crypto::encrypt($text_hidden, $encryption_key, TRUE);   // HaliteAlert → EncryptException
```

- `HiddenString` keeps the secret out of `var_dump()`, `print_r()`, serialization and stack traces.
- The third argument `TRUE` selects **raw binary** output instead of hex.
- Output is authenticated: Halite appends a MAC, so any modification makes decryption fail.

## `decrypt($text, $key): string`

Mirror image — rebuilds the `EncryptionKey`, calls `Crypto::decrypt()`, and converts
`InvalidKey`/`HaliteAlert` into `EncryptException`. A wrong key, truncated ciphertext or tampered
bytes all raise `EncryptException` rather than returning corrupt plaintext.

## Error handling in callers

```php
use Drupal\encrypt\Exception\EncryptException;

try {
  $ciphertext = \Drupal::service('encryption')->encrypt($plaintext, $profile);
}
catch (EncryptException $e) {
  // Missing library, wrong key size, or a Halite-level failure.
  \Drupal::logger('my_module')->error('Encryption failed: @m', ['@m' => $e->getMessage()]);
}
```

Only `EncryptException` needs catching — Halite's own exception classes never escape the plugin.

## Sensitivity annotations

`checkDependencies()`, `encrypt()` and `decrypt()` all mark their `$text`/`$key` parameters
`#[\SensitiveParameter]`. PHP 8.2+ replaces those arguments with `Object(SensitiveParameterValue)`
in stack traces, so an uncaught exception in production will not print keys or plaintext into
watchdog. Preserve those attributes if you subclass.

## Writing a comparable method

Use this plugin as the template when adding another cipher to Encrypt:

```php
#[EncryptionMethod(
  id: "my_method",
  title: new TranslatableMarkup("My method"),
  description: new TranslatableMarkup("…"),
  key_type: ["encryption"]
)]
class MyEncryptionMethod extends EncryptionMethodBase implements EncryptionMethodInterface {
  public function checkDependencies(#[\SensitiveParameter] $text = NULL, #[\SensitiveParameter] $key = NULL): array { … }
  public function encrypt(#[\SensitiveParameter] $text, #[\SensitiveParameter] $key): string { … }
  public function decrypt(#[\SensitiveParameter] $text, #[\SensitiveParameter] $key): string { … }
}
```

Add `#[\Override]` on the three methods (this module does) so a signature drift in
`EncryptionMethodBase` fails loudly at compile time.

## What this module deliberately does not do

- No key generation — that is the Key module's or your shell's job.
- No key rotation or bulk re-encryption helper.
- No configuration of its own: no settings form, no config schema, no default config.
- No integration with specific fields — pair it with Field Encryption or another Encrypt consumer.
