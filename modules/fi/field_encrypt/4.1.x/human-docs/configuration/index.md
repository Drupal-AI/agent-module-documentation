# Configuration

Setting up Field Encrypt has a definite order: **make a key and an encryption
profile → select that profile globally → encrypt the fields you want.** You can't
skip ahead — the per‑field "Encrypt field" checkbox doesn't appear until a global
profile is set.

> ⚠️ **Read this first.** Everything below depends on an encryption key you must not
> lose. If the key behind your profile is destroyed, the encrypted data cannot be
> recovered. Back the key up securely, keep it outside the database and codebase, and
> keep the old key until any key rotation has finished re‑encrypting existing data.

## Step 1 — Create a key and an encryption profile

Field Encrypt itself defines no keys or algorithms; it uses an **encryption
profile** from the Encrypt module, which in turn references a **Key**.

1. **Create a key** (Key module) at **Configuration → System → Keys**. Use a
   provider that stores the key material **outside** the database and codebase — a
   file outside the web root, or an environment variable — not a key typed directly
   into config.
2. **Create an encryption profile** at **Configuration → System → Encryption
   profiles** (`/admin/config/system/encryption/profiles`). Choose an encryption
   method (for example AES) and point it at the key you just made.

## Step 2 — Select the profile in Field Encrypt's settings

1. Log in as a user with the **Administer field encryption** permission.
2. Go to **Configuration → System → Field Encrypt**
   (`/admin/config/system/field-encrypt`).
3. Set the options:

   - **Encryption profile** *(required)* — pick the profile from Step 1. **Nothing
     encrypts until this is set**, and the per‑field encrypt controls only appear
     once it is. New entities and revisions always use the currently selected
     profile.
   - **Make entities uncacheable** *(default on)* — keeps entity types that have
     encrypted fields out of Drupal's persistent render/entity caches, so plaintext
     never lands in a cache table. Leave this on unless you fully understand the
     consequences of turning it off.
   - **Default properties** — which field properties are pre‑ticked per field type on
     the encrypt form (for example text fields default to `value`, link fields to
     `uri` and `title`). These are just sensible defaults you can override per field.
   - **Batch size** *(default 5)* — how many entities are processed per step during
     re‑encryption. Raise it to speed up re‑encrypting large tables, lower it if the
     batch is straining the server.

4. Save.

## Step 3 — Encrypt a field

Encryption is set on a field's **storage** configuration, so it applies everywhere
that field is used.

1. Go to the bundle's **Manage fields**, find the field, and open its **storage /
   edit** settings form.
2. Under **Field encryption**, tick **Encrypt field**.
3. Under **Properties**, choose which properties to encrypt. Sensible defaults for
   the field type are pre‑selected (for example a link field offers `uri` and
   `title`, so you could encrypt the URL but leave the visible title in the clear).
4. **Save.** If the field already contains data, you'll be warned and a **batch
   re‑encryption** runs to encrypt all existing rows.

You can encrypt **base fields** too (like a node's title), configured from the
per‑entity‑type settings page rather than the field's edit form.

## Turning encryption off (decrypting a field)

To go back to plaintext, either untick **Encrypt field** on the field's storage
form, or use the dedicated **field‑decrypt** confirmation flow linked from the
Field Encrypt pages. Existing rows are rewritten as plaintext via the same
queue/batch mechanism. (The data must still be decryptable at that moment — i.e. the
key it was encrypted with must be available.)

## Running the re‑encryption queue

Any change to a **populated** field — encrypting it, decrypting it, or switching its
profile — queues the affected entities for re‑encryption. That queue is normally
processed by **cron**, but you can run it immediately at:

- **Process queues:** `/admin/config/system/field-encrypt/process-queues`

Related pages, all requiring **Administer field encryption**:

- **Per‑entity‑type settings** — `/admin/config/system/field-encrypt/entity-types/{entity_type}`:
  update an entity type's existing data to the current profile, and manage base‑field
  encryption.
- **Switch encryption profile (key rotation)** — a confirmation flow reached from
  the entity‑type page that re‑encrypts an entity type's data with a new profile.
  Keep the old key available until this completes.
- **Field overview** — `/admin/config/system/field-encrypt/field-overview`: see
  which fields are encrypted.

## Permission

- **Administer field encryption** (`administer field encryption`) — a
  security‑sensitive, restricted permission that gates every Field Encrypt page and
  the encrypt controls on field forms. Because it controls what is encrypted and can
  trigger **decryption** of data, grant it only to fully trusted administrators.

Grant it at **People → Permissions**, or via Drush:

```bash
drush role:perm:add administrator 'administer field encryption'
```

## For developers

Other modules can veto encryption for a specific entity instance with
`hook_field_encrypt_allow_encryption()` — for example to skip encrypting published
nodes while encrypting drafts. See the agent docs at
[`agent/hooks/allow-encryption.md`](../agent/hooks/allow-encryption.md) and
[`agent/api/services.md`](../agent/api/services.md) for the runtime internals.
