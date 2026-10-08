# Configuration

Health Checker has one short settings form. Log in as an administrator and go to
**Configuration → Development → Health Checker Settings**
(`/admin/config/development/healthchecker`).

## Settings

- **Health check page URL / endpoint path** — the path the health-check page
  responds on. It defaults to `/health-check`; change it to whatever suits your
  monitoring (for example `/site-up`). Choosing a non-obvious path is one simple
  way to keep the endpoint out of casual view.
- **Include the timestamp** — a toggle for whether the JSON response includes a
  timestamp. Turn it on if your monitoring wants to record when each probe was
  answered; leave it off for the most minimal response.

Save the form when you're done.

## Point your monitor at it

Once configured, set your external monitoring service (uptime monitor, load
balancer health check, container orchestrator liveness probe) to request the
endpoint path you chose. A successful response with the expected JSON status means
the site is up.

## A note on access

The endpoint deliberately returns only a minimal status — it does not disclose
version numbers or internal sensor details — so leaving it public reveals only
that the site responds, which is the intended behaviour for a monitor probe. If
your policy requires it, you can restrict access using the permission this module
provides (grant it only to the role your monitor authenticates as), or rely on a
non-guessable path. Beyond that, the module plays no part in access control.
