# Pantheon Secrets — manual setup guide

**Pantheon Secrets** (`pantheon_secrets`) lets Drupal read secrets stored in
**Pantheon's Secrets Manager** through the **Key** module, so API keys and
credentials never live in your code, your `settings.php` or your exported
configuration. If your site is hosted on Pantheon, this is the clean way to keep
third‑party credentials — SendGrid, Stripe, an AI provider, S3, SMTP — out of the
codebase and out of version control, while still letting any Key‑aware module consume
them as normal.

It works as a bridge between two things: the contributed **Key** module (which gives
Drupal a standard way to reference a secret as a "Key" entity) and Pantheon's Customer
Secrets service. The module adds one **key provider** with the id `pantheon`: a Key
configured to use it stores only the *name* of the Pantheon secret, never the value.
At read time the module fetches the value from Pantheon's SDK on demand, so the secret
itself is never written to Drupal's database, config or an export. Change the value in
Pantheon and Drupal picks it up immediately, with no deployment.

On top of the provider it adds a **bulk importer**: one click (or one Drush command)
creates a Key entity for every secret your site can see that isn't already referenced.
The secrets themselves are created *outside* Drupal with Pantheon's `terminus`
command; the module never writes to Pantheon, and deleting a Key in Drupal
deliberately does **not** delete the underlying secret.

The module has **no settings form of its own** — its configuration lives inside the
Key entities you create — but there is a real configuration workflow (creating
Pantheon‑backed keys and running the sync), covered on the Configuration page. It
requires PHP 8.2+, the Key module (`^1.16`) and Pantheon's Customer Secrets PHP SDK,
and it supports Drupal 10 and 11.

This guide is written for a **human** setting the module up. If you want the terse,
token‑cheap reference for an AI coding agent — the provider plugin internals, the
config shape and the syncer service — read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer (it
   brings in the Key module) and enable it.
2. [Configuration](configuration/index.md) — create a Key backed by a Pantheon
   secret, use the bulk sync, and consume the value in code.

## Where it lives in the admin menu

Pantheon Secrets has no settings page of its own. You work with it through the **Key**
module at **Configuration → System → Keys** (`/admin/config/system/keys`), where a
new *Pantheon* option appears in the key‑provider list, and a **"Sync Pantheon
Secrets"** tab (`/admin/config/system/keys/pantheon`) offers the bulk importer. That
sync page is gated by the **Sync pantheon_secrets keys** permission the module
provides.

## How to use it

1. Create the secret in Pantheon (outside Drupal) with terminus — scope must be
   `web`:

   ```bash
   terminus secret:set <site> --scope=web --type=runtime <secret_name> <secret_value>
   ```
2. In Drupal, create a **Key** that uses the **Pantheon** provider and points at that
   secret name (or bulk‑import all secrets at once). See
   [Configuration](configuration/index.md).
3. Point any Key‑aware module (an AI provider, SendGrid, S3, SMTP, a payment gateway…)
   at that Key. It works unchanged, now backed by a Pantheon‑managed secret you can
   rotate centrally without a code deploy.
