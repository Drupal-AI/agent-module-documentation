<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Credential storage, transport crypto, and agent authentication

DRD keeps two independent secret layers per managed domain: an **authentication** secret (proves
the dashboard's identity to the agent) and a **transport encryption** key (protects the command
payload). Both are stored on the `drd_domain` entity and protected at rest by a third mechanism, the
Encrypt module.

## At-rest encryption (`src/Encryption.php`, service `drd.encrypt`)

- Constructed with the config factory and the optional `@?encryption` service (Encrypt module). It
  reads the admin-chosen profile id from `drd.general:encryption_profile` and loads that
  `EncryptionProfile`; if none is configured it raises an error message pointing at `/drd/settings`.
- `encrypt(&$plain)` / `decrypt(&$encrypted)` recurse through arrays and delegate to
  `EncryptService::encrypt/decrypt` with the profile. **Exceptions are swallowed** — the comment
  notes this "results in unencrypted operations", i.e. if the profile/key is unavailable the value
  is left in plaintext rather than failing.
- `setOldProfileId()` supports re-keying: on a profile change, `Form\Settings::submitForm()` calls
  `EncryptionUpdate::update()` (service `drd.encrypt.update`) to decrypt with the old profile and
  re-encrypt every stored secret with the new one.
- The `drd_domain` fields `authsetting` and `cryptsetting` (both `map` fields) are the encrypted
  payload; `Domain::getAuthSetting()/getCryptSetting()` decrypt on read, the setters encrypt on
  write. The local-copy DB password in `drd.general:local.db.pass` is also encrypted here.

The Encrypt module needs a real symmetric key/method (the module *recommends* `real_aes`). DRD only
selects the profile; key management is delegated to Encrypt + the Key module.

## Authentication to the agent (`src/Plugin/Auth/`, `plugin.manager.drd_auth`)

Auth plugins (`@Auth` annotation) implement `BaseInterface`:

- **`shared_secret`** (`SharedSecret.php`) — a random string known to both dashboard and agent;
  `storeSettingRemotely()` is TRUE (the agent stores it too). `initValues()` seeds a 50-char
  generated secret.
- **`username_password`** (`UsernamePassword.php`) — a real remote admin account; actions then run
  with that user's permissions. `storeSettingRemotely()` is FALSE.

Both plugins encrypt their settings via `drd.encrypt` in `settingsFormValues()`.

## Transport crypto (`src/Crypt/`)

`CryptBase::getMethods()` scans `Crypt/Method/` and returns those whose `isAvailable()` is TRUE.
Methods implement `BaseMethodInterface` (`BaseMethod.php` base):

- **`OpenSsl`** — `openssl_encrypt/decrypt` with `OPENSSL_RAW_DATA`, ciphers `aes-256-ctr` /
  `aes-128-cbc`, a random IV per message (`openssl_random_pseudo_bytes`), and a base64-stored random
  password. The message payload is encoded before encryption and decoded on the return path.
- **`Mcrypt`** — legacy `mcrypt_*` (only available on ancient PHP); same payload encoding.
- **`Tls`** — a "no additional encryption" method that relies entirely on the HTTPS transport;
  `requiresPassword()` is FALSE and `authBeforeDecrypt()` is TRUE (the agent authenticates before the
  payload is decoded).

`resetCryptSettings()` on the domain negotiates a method both ends support (preferring `OpenSsl`)
and generates a fresh key. Passwords/keys are generated with `random_bytes` (`generatePassword()`)
or core's password generator.

`BaseMethod` also provides `encryptFile()/decryptFile()` that shell out to the `openssl` CLI for
database-dump encryption during downloads.

## Setup handshake

New domains are authorised out-of-band: `Domain::getRemoteSetupToken()` builds a base64url token
carrying uuid, auth, crypt settings and the dashboard's own IPs; `authorizeBySecret()` and
`pushOtt()` (one-time token) POST it to the agent's `drd-agent-authorize-secret` / `drd-agent`
setup endpoints. The browser round-trip returns via `Controller\Domain::returnFromRemote()`
(route `entity.drd_domain.return_remote`, CSRF-token protected).
