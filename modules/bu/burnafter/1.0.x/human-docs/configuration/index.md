# Configuration

## Open the settings form

1. Log in as a user with the **administer burnafter settings** permission.
2. Go to **Configuration → System → BurnAfter**, or navigate directly to
   `/admin/config/system/burnafter`.

This form (config object `burnafter.settings`) controls how BurnAfter items
behave and, in particular, whether their content is encrypted at rest.

## Encryption at rest

BurnAfter can optionally encrypt each item's body before it is stored, using the
contrib **Encrypt** module. To use this:

1. Install and enable Encrypt (see [Installation](../installation/index.md)).
2. Create an **encryption profile** in Encrypt (it defines the encryption method
   and the key it uses).
3. On the BurnAfter settings form, enable encryption and select that profile.

With encryption on, the content is decrypted only when an item is viewed. Without
it, the body is stored as ordinary text.

## Permissions

BurnAfter provides its own permissions — set them under **People → Permissions**
(`/admin/people/permissions`):

- **administer burnafter settings** — reach this settings form. Give it only to
  trusted operators.
- **create burnafter entity** — create new items at `/burnafter/add`.
- **view burnafter entity** — view an item at its UUID link. Remember that viewing
  also requires knowing the random UUID, so the link itself acts as a second
  factor.

## A note on how the "burn" happens

Deletion of over-viewed or expired items runs on **cron**, not at the instant of
the final view. Make sure cron runs regularly so items are cleaned up promptly.
