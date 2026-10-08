# Configuration

Setting up Entity Translation Sync is a three‑step routine: enable the entities
and fields you want to sync, clear caches, and assign the permissions that decide
who may run a sync.

## 1. Enable the supported entities, bundles, and fields

1. Log in as a user with **Administer site configuration** (the settings form is
   gated by this core permission, not by the module's own permissions).
2. Go to **Configuration → Regional and language → Entity translation sync**, or
   navigate directly to `/admin/config/regional/entity-translation-sync`.
3. Choose which **entity types**, **bundles**, and **fields** are supported for
   synchronization. Only the fields you enable here become available to propagate.

Remember the limitation: Paragraph fields, and any field based on entity reference
revisions, cannot be synced and won't be offered.

## 2. Clear caches

**Clear the cache after saving.** This is required every time you enable or
disable an entity type — for example with `drush cr`, or via **Configuration →
Development → Performance**. Without it, the new sync tab and behavior may not
appear.

## 3. Assign permissions

Access to *perform* a sync is controlled by the module's own permissions (separate
from the settings form's `administer site configuration` gate):

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Grant the relevant permission to the appropriate roles. There is a
   per‑entity‑type permission (for example *Synchronize node translation*) as well
   as a global **Synchronize any entity translation** permission.
3. Save permissions.

## Using it

Once configured, open a supported translatable entity and click its **"Entity
translation sync"** tab. On that page a form lets you select which fields from the
current language should be copied to which other languages. Syncing happens **on
save**.

> **Backfilling existing content:** because syncing only runs on save, translations
> that already diverge before a field was added to the sync set are not reconciled
> automatically. To bring existing content into line, re‑save the affected entities
> (for example with a bulk re‑save tool) after configuring the sync.
