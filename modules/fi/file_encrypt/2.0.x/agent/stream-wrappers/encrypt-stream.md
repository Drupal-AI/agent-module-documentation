<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `encrypt://` stream wrapper and stream filters

## Wrapper
`Drupal\file_encrypt\EncryptStreamWrapper` extends core `LocalStream`; registered as service
`stream_wrapper.encrypt` with tag `{ name: stream_wrapper, scheme: encrypt }`.

- **Base path**: `EncryptStreamWrapper::basePath()` = `Settings::get('encrypted_file_path', '')`.
  Files physically live under this directory (kept outside the public web root; `hook_cron()` also
  drops a deny-all `.htaccess` there).
- **URI form**: `encrypt://{encryption_profile}/{path/to/file.ext}`. The **profile id is the URL
  host** (`parse_url($uri, PHP_URL_HOST)`), resolved via
  `encrypt.encryption_profile.manager`::`getEncryptionProfile()` in `extractEncryptionProfile()`
  (throws if the profile is missing).
- **Image-style URIs** get special-cased: `encrypt://styles/{style}/encrypt/{profile}/…` — the
  profile is pulled out with a regex, and `getTarget()` keeps the `styles/…` prefix intact.
- `getExternalUrl()` builds a URL to route `system.encrypt_file_download`
  (`/encrypt/files/{filepath}`), with `filepath = {profile}/{target}`.

## How encrypt/decrypt is wired
The wrapper does **no cryptography itself**. In `stream_open()`:
1. `ensureEncryptedFilesDirectory()` `mkdir`s the base path (mode 0755) if missing.
2. `parent::stream_open()` opens the real local file handle.
3. `appendAllStreamFilters($uri)` registers + appends two filters onto that handle, passing
   `encryption_service` (the `encryption` service = `Drupal\encrypt\EncryptService`) and
   `encryption_profile` (resolved `EncryptionProfileInterface`) as params:
   - `EncryptStreamFilter` (`STREAM_FILTER_WRITE`)
   - `DecryptStreamFilter` (`STREAM_FILTER_READ`)

So any normal `fopen('encrypt://…','w')` / read transparently encrypts on write and decrypts on read
by delegating to `EncryptService::encrypt()/decrypt($data, $profile)`. The **cipher, IV/nonce and any
authentication tag are entirely determined by the encryption-method plugin** the profile selects in
the `encrypt` module (e.g. `real_aes` → AES-256-CBC + HMAC-SHA256 with a random IV per call, via
defuse/php-encryption; or sodium-based methods). This module never touches openssl/sodium/keys
directly and never derives a key from `hash_salt`.

## On-disk format (stream filters)
Both filters extend `StreamFilterBase` (`HEADER_LENGTH = 7`, padding `"\0"`).

- **Write** — `EncryptStreamFilter::filterData()` for each PHP stream bucket:
  `payload = encryption->encrypt(bucket, profile)`, validates `strlen(payload) <= 9999999`
  (7 nines), then emits `str_pad(strlen(payload), 7, "\0") . payload`.
- **Read** — `DecryptStreamFilter::filter()` buffers incoming bytes, alternately reading a 7-byte
  header (payload length) and then that many ciphertext bytes, calling
  `encryption->decrypt(chunk, profile)` on each ciphertext unit.

**Consequence**: a stored file is a sequence of independently-encrypted chunks
`[7-byte len][ciphertext] [7-byte len][ciphertext] …`, one per stream bucket (~8 KiB writes). Each
chunk is its own ciphertext with (for authenticated methods) its own IV and MAC. Confidentiality and
per-chunk integrity therefore follow the chosen method; whole-file integrity (chunk count/order) is
not separately bound by this module.

## Practical notes
- **`EncryptBinaryFileResponse`** exists because Symfony's `BinaryFileResponse` sends the wrong
  `Content-Length` for filter-modified files (symfony/symfony#19738); it re-reads the decrypted
  stream to compute the true length and calls `setPrivate()`.
- Encryption is not cheap on large files (chunk-wise encrypt/decrypt on every read); the response
  also reads the file twice (once for length, once to send).
- **Key/profile availability is fatal**: a missing profile throws; a lost key makes files
  permanently unreadable.
