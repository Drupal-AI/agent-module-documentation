<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How encryption/decryption works

## What is encrypted

The two email columns of `users_field_data`: **`mail`** and **`init`** (init = the address the
account originally registered with). Only **syntactically valid** emails are encrypted
(`dbee_email_to_alter()` uses `email.validator`); empty/invalid values are stored unchanged.
Encryption uses `\Drupal::service('encryption')->encrypt($value, EncryptionProfile 'dbee')`
(Real AES / AES-256). Every value gets a random IV, so the same email encrypts to different
ciphertext each time.

## Helper functions (in `dbee.module`)

| Function | Purpose |
|---|---|
| `dbee_encrypt($string)` | Encrypt one email (round-trips to verify; returns input on failure). |
| `dbee_decrypt($string, $prev = FALSE)` | Decrypt one email; `$prev` uses the `dbee_prev` profile during key changes. |
| `dbee_store(['mail'=>…,'init'=>…])` | Encrypt both fields for storage. |
| `dbee_unstore([...], $prev)` | Decrypt both fields. |
| `dbee_extract(&$account)` | Decrypt `mail`/`init` on a loaded user object. |
| `dbee_stored_users($uid, …)` | Read the **raw (still-encrypted)** rows directly (bypasses the query alter). |

## Where it hooks in

- **Encrypt on write:** `hook_entity_presave` + `hook_user_insert`/`hook_user_update`
  (weighted late).
- **Decrypt on read:** `hook_entity_load` (weighted early, so other modules see plaintext).
- **Session:** the core cookie provider bypasses `entity_load`, so dbee replaces it with
  `Drupal\dbee\Authentication\Provider\DbeeCookie`
  (`authentication_provider` service tagged `provider_id: cookie`, priority -10) which decrypts
  the current user's `mail`/`init` on `getUserFromSession()`.
- **Look-ups by email:** `hook_query_alter` (`Drupal\dbee\Query`) rewrites any dynamic query
  whose WHERE clause references `mail`/`init` (e.g. `user_load_by_mail()`,
  `user_load_multiple`). Since AES ciphertext can't be matched in SQL, dbee decrypts all stored
  emails in PHP and converts the condition to a uid match. This is CPU-intensive and cached in
  a static (`_dbee_all_users_uncrypted()`).

### Query tags that control the alter

- `dbee_disabled` — skip dbee entirely for this query.
- `dbee_mail_disable_insensitive_case` / `dbee_init_disable_insensitive_case` — make the match
  case-sensitive (default is case-insensitive).
- dbee itself adds `dbee_mail` / `dbee_init` tags when it acts on those fields.

## Unique-email validation

Encrypted storage breaks the core SQL-based unique-email check, so dbee provides
`UserMailUniqueDbee` (extends core `UserMailUnique`, `caseSensitive = FALSE`,
`validatedBy` → `UserMailUniqueDbeeValidator`) to enforce uniqueness against decrypted values.

## Reading raw vs. decrypted (for agents)

- `User::load($uid)->getEmail()` and `user_load_by_mail($email)` return **plaintext**
  (decrypted transparently).
- A **static** DB read — `\Drupal::database()->query('SELECT mail FROM {users_field_data}
  WHERE uid = :uid', [':uid' => $uid])` — is **not** altered and returns the **ciphertext**.
  (`hook_query_alter` only fires on dynamic tagged queries, and only when `mail`/`init` is in
  the WHERE clause.)
