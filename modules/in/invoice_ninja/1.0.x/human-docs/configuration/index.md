# Configuration

All of Invoice Ninja's connection settings live on one form at **Configuration →
System → Invoice Ninja** (`/admin/config/system/invoice_ninja`, route
`invoice_ninja.settings`). You need the *Administer invoice_ninja
configuration* permission to open it.

## The settings form, field by field

- **Invoice Ninja URL** — the base URL of your Invoice Ninja instance, for
  example `https://ninja.example.com` for a self‑hosted install, or the hosted
  service's URL. Required.
- **API Token** — the API token generated in your Invoice Ninja account. It is
  shown as a password field in the form. Required. **Note:** despite the masked
  field, the token is saved in plain text (see the warning below).
- **Synchronize Users** — a checkbox that turns user synchronization on. When on,
  only users who have the sync permission are synced.
- **Admin User Password** — needed for certain privileged requests. This field
  only appears when *Synchronize Users* is enabled. Like the token, it is stored
  in plain text.

Click **Save configuration** to store the connection details.

## Permissions

Three permissions govern the module:

- **Administer invoice_ninja configuration** — can edit the connection settings
  above. This is a restricted, trusted‑admin permission.
- **Administer invoice_ninja** / **Access invoice_ninja** — control which users
  are eligible to be synced to Invoice Ninja. Grant these deliberately, since
  they determine whose data leaves your site.

## Important: secret storage and plain‑text credentials

This module writes the **API token** and the **admin password** directly into the
`invoice_ninja.settings` configuration object with **no encryption and no Key
module integration**. That means both secrets end up in:

- your database, and
- any configuration export (`drush cex`).

Handle this carefully:

- **Exclude `invoice_ninja.settings` from committed/shared config exports** so the
  token never lands in version control. The
  [Config Ignore](https://www.drupal.org/project/config_ignore) module (or a
  split) is the usual way to do this.
- **Rotate the API token immediately** if a config export or database dump is
  ever exposed.
- Treat database backups that contain this config as sensitive.

For reference, the same values can be set from the command line without the UI:

```bash
drush cset invoice_ninja.settings invoice_ninja_url 'https://ninja.example.com' -y
drush cset invoice_ninja.settings invoice_ninja_api_token 'YOUR_TOKEN' -y
```

TLS (HTTPS certificate verification) for the outbound calls is left at the SDK's
own default — this module does not disable it — so always use an `https://` URL
for your Invoice Ninja instance.

## Triggering a sync

Once connected, you can push records to Invoice Ninja in several ways:

- **Batch‑sync all permitted users:** `drush invoice_ninja:synchronize_users`
  (alias `insu`).
- **Sync one entity:** run the *Sync Client*, *Sync Invoice*, or *Sync VAT*
  action from Views Bulk Operations, an ECA model, or as a core action.
- **Branch an ECA model** on whether a record is already synced using the
  *SyncStatus* condition (useful for "create vs. update" logic).
