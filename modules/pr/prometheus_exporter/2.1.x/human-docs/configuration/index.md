# Configuration

Setting up Prometheus Exporter is three steps: **enable the collectors** you want,
**open the `/metrics` endpoint** to your scraper, and **protect** that endpoint.
Nothing is exported until you do the first two, because every collector is disabled
and the endpoint is closed by default.

## The settings form

1. Log in as a user with the **Administer Prometheus exporter settings** permission.
2. Go to **Configuration → System → Prometheus Exporter**, or navigate directly to
   `/admin/config/system/prometheus_exporter`.

The form lists every available collector. For each one you get:

- an **enable** checkbox,
- a **drag handle / weight** to set the order metrics appear in, and
- a **settings** area (in vertical tabs) for the collectors that have options.

Tick the collectors you want, adjust any of their options, order them, and **Save**.

### The built-in collectors

- **User count** — total number of users.
- **Node count** — number of nodes, broken down per content‑type **bundle**. Its
  settings let you choose which bundles to count.
- **Revision count** — number of node revisions per bundle (same bundle selection as
  Node count).
- **Queue size** — the size of each queue, useful for spotting a cron/background
  backlog.
- **Active user count** — users active within a recent window. Its setting is the
  window length in **seconds** (default 900, i.e. 15 minutes).
- **Anonymous session count** — number of open anonymous sessions.
- **Authenticated session count** — number of open authenticated sessions.
- **PHP info** — PHP runtime information exposed as metrics.

If you enabled the optional submodules, you'll also see **Comment count** and
**Update status** collectors in the list.

You can also enable collectors from the command line or in configuration, for
example:

```bash
drush cset prometheus_exporter.settings collectors.user_count.enabled true -y
```

## The `/metrics` endpoint and access control

Metrics are served at **`/metrics`** (GET only). This endpoint is gated by the
**Access Prometheus metrics** permission, which is granted to **no role by default**,
so it returns 403 until you open it. You have two ways to let a scraper in:

- **Grant the permission** to a role your scraper authenticates as. The endpoint
  accepts any of the site's installed authentication providers (basic auth, OAuth2,
  cookie, and so on), so the scraper can log in as that role.
- **Use a token** by enabling the `prometheus_exporter_token_access` submodule, which
  lets a static token in the query string or a `Bearer` header stand in for the
  permission. (Check that submodule's own security note first.)

### Please protect it

Metrics can disclose operational detail — module versions, user/session/queue counts,
PHP configuration. Treat the endpoint as sensitive:

- **Do not** grant *Access Prometheus metrics* to the **anonymous** role unless the
  endpoint is behind a firewall or WAF — doing so publishes all of the above to the
  public internet.
- Prefer keeping `/metrics` off the public internet entirely and reachable only by
  your internal scraper, optionally fronted by basic auth.

## Scraping the metrics

Once collectors are enabled and access is granted:

```bash
# Over HTTP (requires the permission or a token):
curl -s https://your-site/metrics

# On the CLI (bypasses HTTP and the endpoint permission — anyone with shell/drush access):
drush prometheus:export
```

Both produce the same Prometheus‑format output from every enabled collector; disabled
collectors produce nothing. Point your Prometheus server at the `/metrics` URL and,
if you like, build a Grafana dashboard on top to track the metrics over time.
