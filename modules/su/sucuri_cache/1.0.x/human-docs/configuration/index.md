# Configuration

Sucuri Cache needs your Sucuri API credentials before it can purge anything. Once
those are in place, the module handles cache clearing for you — the maintainer's own
words are that you configure it once and "don't need to think on it again".

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Web services → Sucuri Cache**, or navigate directly to
   `/admin/config/services/sucuri_cache`.

## Enter your Sucuri credentials

On the settings form, define the connection to Sucuri:

- **API Endpoint** — the Sucuri API endpoint to use.
- **API Key** — your Sucuri API key.
- **API Secret** — your Sucuri API secret.

You get all three from your Sucuri Website Firewall account, which must have API
access enabled.

**Keep the credentials secure.** The API key and secret are sensitive — anyone with
them can purge your Sucuri cache. Follow the project's recommendation to store them
in an environment-backed way rather than committing them to exported configuration
or version control, so the secret never lands in your repository.

Save the form. With the credentials in place the module does the rest.

## Clearing the cache

Once configured, you can purge Sucuri's cache in several ways:

- **Automatically on content change** — node caches are purged on Sucuri when the
  node is updated, so published changes go live without waiting for a time-based
  expiry.
- **A single node** — clear an individual node's cache with a simple action.
- **Multiple nodes at once** — clear caches for several nodes together.
- **The whole site** — an admin button performs a full Sucuri cache purge, handy
  after a major update or deployment.

Every cache-clear action is logged, so you have a trail of what was purged and when.

## Who can purge — permissions

Purging is governed by Drupal permissions, so you can let content managers clear
caches without giving them your Sucuri API credentials:

| Permission | Lets a user… |
|------------|--------------|
| **Purge Sucuri cache (all)** (`purge sucuri cache all`) | Perform a full site-wide Sucuri cache purge. |
| **Purge Sucuri cache (entity)** (`purge sucuri cache entity`) | Purge the cache for individual entities/nodes. |

Grant these at **People → Permissions** (`/admin/people/permissions`) to the roles
that should be able to clear the cache.
