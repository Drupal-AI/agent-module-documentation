# Configuration

Configuring Disk Quota has three parts: set the default limits per role, grant the
permissions that control who can see and manage quotas, and (optionally) override
the limit for specific individuals.

## Step 1 — set role‑based quota limits

1. Log in as an administrator.
2. Go to **Configuration → People → Account settings → Disk Quota**, or navigate
   directly to `/admin/config/people/accounts/disk-quota`.
3. For each user role, set the maximum total upload size that users in that role
   are allowed. This is the baseline that applies to everyone in the role unless
   they have a per‑user override.
4. Save the form.

Remember that the running total counts **only files uploaded through Drupal forms**
— files added by FTP or other means are not counted.

## Step 2 — grant the permissions

Go to **People → Permissions** (`/admin/people/permissions`) and assign the
module's permissions to the appropriate roles:

- **View own storage quota** — lets a user see how much of their quota they have
  used.
- **Edit own storage quota** — lets a user change their own quota (grant with care).
- **Edit any storage quota** — lets a user change any other user's quota.
- **Create storage quota** — lets a user create quota records.
- **Administer user roles storage quota** — access to the role‑based settings.
- **Edit *[role]* role storage quota** — a dynamic permission generated per role,
  for delegating control of a single role's quota.

Grant the broad permissions (edit any, administer) only to trusted administrators.

## Step 3 — per‑user overrides (optional)

To give a specific person a larger or smaller allowance than their role default,
edit that user (**People → *(user)* → Edit**) and set the per‑user quota override
on their edit page. This takes precedence over the role‑based limit.

## How the limit is enforced

The module tracks each user's cumulative upload size. When a new upload would push
that total over the user's effective limit (override if set, otherwise the role
default), the upload is rejected. Freeing space by deleting previously uploaded
files lowers the total again.
