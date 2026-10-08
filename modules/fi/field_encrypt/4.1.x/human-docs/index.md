# Field Encrypt — manual setup guide

**Field Encrypt** (`field_encrypt`) extends Drupal's Field API so that the values in
selected fields are **encrypted before they're written to the database** and
**decrypted when they're loaded** — automatically and transparently. Your fields
work exactly as before in code, in Views, and in the UI; the difference is that
anyone who gets hold of a raw database dump sees ciphertext, not the real values.
It's the tool of choice for protecting personal data (PII), API keys, medical or
financial notes, and anything else you need encrypted "at rest" to satisfy an audit
or a compliance requirement like GDPR.

It works by marking, per field, which properties should be encrypted (stored as a
setting on the field's *storage* configuration). At runtime the module swaps the
real value in the normal database columns for a placeholder and keeps the ciphertext
in a dedicated hidden storage field, using an **encryption profile** from the
Encrypt module to do the actual encrypting and decrypting. Because plaintext must
never leak into caches, entity types that have encrypted fields are (by default)
kept out of Drupal's persistent render and entity caches.

There are a few things to know before you start. Field Encrypt does **not** ship its
own encryption keys or algorithms — it relies on the **Encrypt** module (and
normally the **Key** module) to define an encryption profile, and you must select
that profile before any encryption can happen. Turning encryption on or off for a
field that already contains data triggers a batch/queue re‑encryption of the
existing rows. And one permission, **Administer field encryption**, gates
everything.

> ## ⚠️ Back up your encryption keys — first, and forever
>
> Your encrypted field data is only as recoverable as the **key** behind its
> encryption profile. **If you lose the key, the data is gone** — there is no
> recovery, no reset, no support ticket that brings it back. Before you encrypt a
> single field:
>
> - **Store the key outside the database and outside the codebase** (use a
>   Key‑module provider such as a file or environment variable, not a key pasted
>   into config).
> - **Back the key up securely**, in more than one place, and make sure your backups
>   and disaster‑recovery plan include it.
> - **Keep the key when rotating.** If you switch a site's data to a new profile
>   (key rotation), the existing ciphertext must be re‑encrypted while the old key is
>   still available — don't destroy the old key until that migration has completed.
> - **Test a restore** on a non‑production copy so you know your key + backup + data
>   round‑trips correctly.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the storage config
shape and the runtime services — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install Field Encrypt (and its Encrypt/
   Key prerequisites) with Composer and enable them.
2. [Configuration](configuration/index.md) — create an encryption profile, choose
   the global settings, encrypt (and later decrypt) specific fields, and run the
   re‑encryption queue.

## Where it lives in the admin menu

- **Global settings:** **Configuration → System → Field Encrypt**
  (`/admin/config/system/field-encrypt`).
- **Per‑field:** the **Encrypt field** controls appear on each field's **storage**
  edit form (under Manage fields), but only after a global encryption profile is
  selected.
- **Encryption profiles** themselves live under the Encrypt module at
  **Configuration → System → Encryption profiles**
  (`/admin/config/system/encryption/profiles`).

It adds one restricted permission, **Administer field encryption**, and no Drush
commands.
