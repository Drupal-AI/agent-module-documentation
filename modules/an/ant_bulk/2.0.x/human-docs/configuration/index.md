# Configuration

Auto Node Translate Bulk has a settings form of its own, a restricted permission,
and a bulk translation form. The translation *provider* is configured in Auto Node
Translate, not here.

## Settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Regional and language → Auto Node Translate Bulk
   settings**, or navigate directly to `/admin/config/regional/ant-bulk-settings`.

Adjust the module's bulk options here and save.

## Permission — treat it as a spending control

The module provides the **Use bulk auto translate** permission, granted under
**People → Permissions**. It is deliberately marked "restrict access":

> Bulk translation sends every selected node's content to your translation
> provider, and providers bill **per character**. Granting this permission is
> effectively granting permission to spend the translation budget. Give it only to
> trusted users.

The settings form is separately gated by **Administer site configuration**.

## Run a bulk translation

1. Go to `/ant-bulk/translate` (requires **Use bulk auto translate**).
2. Select the content to translate — you can work one content type at a time.
3. Start the job.

For large runs, prefer the module's **Drush commands** over the browser form, and
consider scheduling them outside peak hours.

## Before you run it

- **Content leaves the site.** Everything selected — including unpublished nodes if
  they are in the selection — is transmitted to a third‑party provider. Confirm that
  is acceptable for confidential or draft material.
- **Review the output.** Machine translations should be checked by a human before
  publication; treat them as drafts for post‑editing.
- **Estimate the cost** before committing to a large batch, since billing is
  per character.
