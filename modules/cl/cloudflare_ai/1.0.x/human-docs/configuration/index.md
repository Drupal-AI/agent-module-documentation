# Configuration

Cloudflare AI has no single settings form. Instead you set up a **credential
set** (in the Cloudflare SDK) and then add one or more **resources** — an AI
Gateway or a Vectorize index — as configuration entities. Each resource references
the credential set that supplies its token.

> This release (1.0.0‑alpha3) provides the **AI Gateway** and **Vectorize**
> resources only; there is no AI Search resource in this version.

## Step 1 — Add a credential set

Credential sets are provided by the Cloudflare SDK module:

1. Go to **Configuration → Web services → Cloudflare credentials** and add a set,
   giving it a **machine name** (for example `my_account`).
2. Put its account ID and token in `settings.php`, keyed by that machine name:

   ```php
   $settings['cloudflare']['credentials']['my_account'] = [
     'account_id' => 'your-account-id',
     'token' => 'your-token',
   ];
   ```

   Give the token the permissions for the resources you plan to use (AI Gateway
   and Vectorize). The account ID is resolved from the credential set, so
   nothing account‑specific ends up in exported configuration.

> **Keep the token a secret.** Prefer an environment variable over a literal in
> `settings.php` — with DDEV, `ddev dotenv set .ddev/.env --cloudflare-token=<value>`
> then `ddev restart`, and read it with `getenv('CLOUDFLARE_TOKEN')`.

## Step 2 — Add an AI Gateway

Under **Configuration → Web services → Cloudflare AI Gateways**, add a gateway.
The gateway configuration entity captures its **host**, **slug**, a **default
provider**, and the **credential set** that authorises it. Once created, the
gateway knows how to build the URLs for its endpoint styles (the OpenAI‑compatible
endpoint, the universal endpoint, and per‑provider passthrough) and how to send
the `cf-aig-*` request headers that control cache TTL, metadata and fallbacks.
Each gateway has a detail page showing its request volume and cache hit‑rate for
the last 24 hours, and it exposes the gateway's live model catalogue (cached per
gateway).

To actually route the Drupal AI module through the gateway, install the
**Cloudflare AI Gateway Provider** and point it at this gateway.

## Step 3 — Add a Vectorize index (optional)

Under **Configuration → Web services → Cloudflare Vectorize**, add an index. The
entity captures the index **name**, its **vector dimensions**, the **distance
metric**, and the **credential set**. The module's data‑plane client can then
create, describe and delete indexes and upsert, query, fetch and delete vectors
over the Vectorize v2 REST API — useful for building semantic search.

## Save

Each resource form saves independently. Because credentials live in `settings.php`
and only the machine name is stored in config, you can safely export and commit
these resource entities without leaking secrets.
