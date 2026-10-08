# Configuration

Health Check URL works the moment you enable it, serving a timestamp at `/health`.
The settings form lets you change what the endpoint returns, where it lives, and
whether it stays up during maintenance.

## Open the settings form

1. Log in as a user with the **Health Check URL administration** permission (an
   administrator by default).
2. Go to **Configuration → Development → Health Check URL settings**, or navigate
   directly to `/admin/config/development/health`.

## Response type

This chooses the format of the plain‑text body the endpoint returns. There are
five options:

- **Timestamp** *(default)* — a Unix timestamp (the current time in seconds).
  Because the endpoint is never cached, a fresh timestamp on each request proves
  the response is live, not a cached copy.
- **String** — the fixed marker text you set below, returned verbatim (for
  example `Passed`). Best when your monitor simply string‑matches the body.
- **String with timestamp** — the marker string followed by a Unix timestamp, so
  you get both a recognizable marker and proof of freshness.
- **String with date and time** — the marker string followed by a human‑readable
  time and date.
- **String with date and timestamp** — the marker string with both a
  human‑readable date/time and a Unix timestamp, handy for log correlation.

## Marker string

The text used by all of the "string" response types. The default is **`Passed`**.
Set it to whatever your monitor expects to see — for example a per‑environment
value like `prod-ok` or `stage-ok`. It is ignored when the response type is plain
**Timestamp**.

## Endpoint path

The path where the health endpoint is served. The default is **`/health`**. You
can move it to a custom, less‑guessable path — for example `/healthz` for a
Kubernetes‑style probe. The path must start with a leading slash.

Because the endpoint lives in a route built from this setting, changing it here
triggers an automatic router rebuild so the new path takes effect immediately. (If
you ever change the path directly in configuration instead of through this form,
run `drush cr` so the route is regenerated.)

## Maintenance mode access

A checkbox controlling whether the endpoint keeps responding while the site is in
**maintenance mode**. It is **off** by default, meaning the health check follows
normal maintenance behavior. Turn it **on** if you want load balancers and
monitors to still receive a healthy response while you have the site in
maintenance — for example so a node is not pulled from a pool during routine work.

## Save

Click **Save configuration**. Your changes take effect immediately — a changed
path is served right away thanks to the automatic router rebuild. Point your load
balancer or uptime monitor at the endpoint URL and you are done.
