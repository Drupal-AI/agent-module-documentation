# Configuration

Setting up encryption is three steps: create a **key**, create an **encryption
profile** that binds a cipher to that key, and (optionally) test it and adjust the
module settings.

## Step 1 — Create a key

Keys are managed by the **Key** module, so the secret lives there rather than in the
profile.

1. Go to **Configuration → System → Keys** (`/admin/config/system/keys`) and click
   **Add key**.
2. Choose a **key type** appropriate to the encryption method you'll use (for
   example, an *Encryption* key of the right byte length for Real AES).
3. Choose a **key provider** — for production, prefer the environment-variable or
   file provider over storing the value in configuration, so the secret stays out
   of version control.
4. Save the key.

## Step 2 — Create an encryption profile

1. Go to **Configuration → System → Encryption profiles**
   (`/admin/config/system/encryption/profiles`) and click **Add encryption
   profile**.
2. Choose an **Encryption method** — one of the encryption-method plugins provided
   by the modules you enabled (e.g. **Real AES**). A method may restrict which key
   types are selectable.
3. Choose the **Key** you created in step 1.
4. Save. Each profile links exactly one method and one key.

Profiles are exportable configuration (`encrypt.profile.*`) — the cipher is in the
plugin and the secret is in Key, so the exported profile references but never
contains the key material.

## Step 3 — Test the profile

From a profile's **Test** tab you can round-trip a sample string to confirm the
method and key work together correctly. (Remember that access to this form is
sensitive — it can decrypt arbitrary text — so restrict the `administer encrypt`
permission.)

You can also validate from the CLI:

```bash
drush encrypt:validate-profile <profile_id>
```

## Module settings

A small settings form lives at
**Configuration → System → Encryption profiles → Settings**
(`/admin/config/system/encryption/profiles/settings`):

- **Show the validation status of encryption profiles** (`check_profile_status`,
  default on) — validates each profile on the overview page, which loads its key.
  Turn it off if you have many profiles or want to avoid loading key material
  during the status check.
- **Allow the use of deprecated plugins** (`allow_deprecated_plugins`, default off)
  — when on, deprecated encryption methods may be selected for **new** profiles.
  When off, deprecated methods remain usable only by existing profiles (so old data
  still decrypts) but can't be chosen for new ones. Enable this only when a
  migration requires it.

These can also be set with Drush, e.g.:

```bash
drush config:set encrypt.settings allow_deprecated_plugins 1 -y
```

## Using a profile in practice

Other modules (Encrypted Field, Webform encrypt, etc.) let you pick an encryption
profile in their own settings. In custom code, call the `encryption` service's
`encrypt($text, $profile)` and `decrypt($text, $profile)` methods. Note that
**asymmetric** methods (such as Encrypt RSA) can encrypt within Drupal but not
decrypt — useful when Drupal should encrypt data that is only decrypted in a
separate, more secure environment.
