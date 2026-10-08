# real_aes — agent start

Adds one `EncryptionMethod` plugin ("Authenticated AES (Real AES)", id `real_aes`) to the
**Encrypt** module — AES-256 CBC + HMAC via the Defuse PHP-Encryption library. No UI, config, or
permissions of its own; you use it through Encrypt's encryption profiles. Requires the Key module
to hold a 256-bit key and the `defuse/php-encryption` Composer library.

- Set up a key + encryption profile and test it → [configure/setup.md](configure/setup.md)
