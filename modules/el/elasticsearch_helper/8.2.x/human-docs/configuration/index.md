# Configuration

Elasticsearch Helper needs to know how to reach your Elasticsearch cluster. That's
what its settings form is for — pointing the module at the cluster and telling it
how to authenticate.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Search and metadata → Elasticsearch Helper** (route
   `elasticsearch_helper.elasticsearch_helper_settings_form`).

## Configure the connection

On this form you set the connection to your Elasticsearch cluster — the host
address, port, and scheme (HTTP/HTTPS), plus any authentication credentials the
cluster requires (for example a username and password for basic auth). Enter the
details that match your cluster and save. If you run several environments
(local/DDEV, staging, production), each will point at a different cluster, so the
connection values typically differ per environment.

## Secure the connection

Because this module talks to Elasticsearch directly, a few security points matter:

- **The credential has index-write access.** Whatever you enter here can create,
  write, and delete index data — so keep it out of exported configuration. If you
  use DDEV, store credentials in environment variables — for example
  `ddev dotenv set .ddev/.env --elasticsearch-password=<value>` (keep `.ddev/.env`
  out of version control), then `ddev restart` — and, where supported, reference a
  Key entity backed by that variable rather than pasting a secret into config that
  gets committed.
- **Use TLS and authentication.** Connect over HTTPS and require authentication on
  the cluster; don't rely on network position alone.
- **Don't expose the Elasticsearch host publicly.** The cluster should sit behind
  your network boundary, reachable only by the site — not open to the internet.
- **Remember the access model.** Indexed documents leave Drupal's access system
  behind: anything that can query the index directly sees everything in it. That's
  fine for a public site search, but think carefully before indexing anything
  restricted, and make sure only the site (not arbitrary clients) can reach the
  cluster.

## Handling an unreachable cluster

The cluster is a network dependency. Decide what should happen when it's down,
because an unhandled indexing failure during a content save can turn into a failed
content save. This is handled in your index plugin code rather than on this form,
but it's worth planning for before you go live.

## After changing the connection

If you change the connection or a mapping, reindex your content so the cluster
reflects the new settings — the companion
[Index Management](https://www.drupal.org/project/elasticsearch_helper_index_management)
module gives you setup/reindex/drop operations from the admin UI for this.
