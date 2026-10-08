# Cloudflare SDK — manual setup guide

**Cloudflare SDK** (`cloudflare_sdk`) is the framework layer for the Cloudflare
module suite. Built on top of the standalone [Cloudflare
API](../../cloudflare_api/1.0.x/human-docs/index.md) client, it provides the
shared plumbing the other Cloudflare modules rely on: named **credential sets**,
resolution of account IDs and API tokens from `settings.php`, a shared HTTP client
factory, and a Cloudflare **asset registry** with a provisioning framework that
feature modules use to declare the Cloudflare resources they need.

You usually install this module because another Cloudflare module — for example
[Cloudflare AI](../../cloudflare_ai/1.0.x/human-docs/index.md) or the Cloudflare
AI Gateway — depends on it. On its own it makes no calls to Cloudflare; it simply
gives the suite one shared credential model and a small admin screen for managing
credential sets.

The key design decision is that **nothing account‑specific is stored in
configuration or the database**. A credential set is just a machine name and a
label. The actual account ID and API token are read from `settings.php`, keyed by
that machine name — a secure pattern that keeps secrets out of exported config and
out of version control. The credential resolver sits behind an interface, so the
secret source can be swapped without changing the modules that use it. The admin
UI is gated by the **Administer Cloudflare** permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no traditional settings form** for this module — it exposes a small
credential‑set admin screen rather than a configuration page, and the actual
secrets live in `settings.php`. Set‑up is described below.

## Where it lives in the admin menu

Credential sets are managed at **Configuration → Web services → Cloudflare
credentials**. The screen requires the **Administer Cloudflare** permission.

## Set up a credential set

There are two halves — a named credential set in the UI, and its secret values in
`settings.php`:

1. Go to **Configuration → Web services → Cloudflare credentials** and add a
   credential set, giving it a **machine name** (for example `my_account`). The
   set stores only that machine name and a human label.
2. Add the account ID and API token to `settings.php`, keyed by the same machine
   name:

   ```php
   $settings['cloudflare']['credentials']['my_account'] = [
     'account_id' => 'your-account-id',
     'token' => 'your-token',
   ];
   ```

3. Other Cloudflare modules then reference the credential set by its machine name.

> **Keep the token a secret.** Rather than pasting the token straight into
> `settings.php`, store it in an environment variable — with DDEV, run
> `ddev dotenv set .ddev/.env --cloudflare-token=<value>` then `ddev restart`, and
> read it with `getenv('CLOUDFLARE_TOKEN')` in `settings.php`. Give the token only
> the permissions the resources you use actually need. Cloudflare's own guide to
> creating a token is at
> `developers.cloudflare.com/fundamentals/api/get-started/create-token`.
