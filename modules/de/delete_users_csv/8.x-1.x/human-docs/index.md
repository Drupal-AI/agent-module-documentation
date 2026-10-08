# Delete Users CSV — manual setup guide

**Delete Users CSV** (`delete_users_csv`) deletes multiple user accounts in bulk
by reading a CSV file of email addresses and removing the matching users in a
batch. It is a straightforward administration tool for large user‑base cleanups —
you upload a CSV, click "Upload and delete users", and it works through the list.

The whole workflow is one screen: go to the module's page, upload a CSV whose rows
are the email addresses of the accounts you want gone, and run the deletion. It is
gated by the **administer users** permission — the appropriate strong permission
for an action that removes accounts — and it has no unauthenticated surface.

> ## ⚠️ This is destructive and irreversible — and it involves PII
>
> Deleting users **cannot be undone**, and it is a high‑impact operation:
>
> - **Back up your database first.** There is no rollback.
> - **Verify the CSV carefully** before uploading — every email that matches an
>   account will have that account deleted. A stray or wrong address means a
>   wrongly deleted user.
> - **Deleting a user cascades to their content** according to your site's
>   account‑cancellation settings (their content may be deleted or reassigned) —
>   understand which behavior your site uses before running this.
> - The CSV itself is a file full of **personal data (email addresses)** — handle
>   and store it responsibly, and delete it when you are done.
> - **Keep the `administer users` permission to trusted administrators only.**

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is no ongoing settings page — the module provides an upload‑and‑delete
action, whose workflow is described below.

## Where it lives in the admin menu

The tool is at `/admin/delete-users-csv`, available to users with the **administer
users** permission.

## How to use it

1. **Take a database backup.** Deletion cannot be reversed.
2. **Confirm your site's account‑cancellation setting** (under People settings),
   so you know what happens to each deleted user's content.
3. Prepare and **carefully verify** a CSV file listing the email addresses of the
   accounts to delete.
4. Go to `/admin/delete-users-csv`, upload the CSV, and click **Upload and delete
   users**.
5. The module deletes the matching accounts in a batch.
6. Securely delete the CSV file afterward — it contains personal data.
