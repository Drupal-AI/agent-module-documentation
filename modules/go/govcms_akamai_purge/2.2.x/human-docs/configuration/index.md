# Configuration

Unlike most modules, GovCMS Akamai Purge is configured almost entirely through
**environment variables** rather than an admin settings form. The GovCMS platform
supplies these; the module reads them to build the internal HTTP requests it sends
to the Akamai purge API proxy (which handles validation and authorisation for
GovCMS sites).

## The environment variables

| Variable | Purpose |
|----------|---------|
| `LAGOON_PROJECT` | Identifies the hosting project. |
| `AKAMAI_PURGE_TOKEN` | The authorisation token for purge API calls — a **secret**. |
| `AKAMAI_PURGE_SERVICE_HOSTNAME` | Hostname of the purge service proxy. |
| `AKAMAI_PURGE_SERVICE_PORT` | Port of the purge service proxy. |
| `AKAMAI_PURGE_SERVICE_SCHEME` | Scheme (`http`/`https`) of the purge service proxy. |

On the GovCMS platform these are provided for you. If you need to set them in a
local or non-platform environment, treat `AKAMAI_PURGE_TOKEN` as a secret.

## Keep the purge token secret

The token authorises cache-purge operations, so never hard-code it or commit it to
Git. With DDEV, store it in the dotenv file and let DDEV inject it into the
container:

```bash
ddev dotenv set .ddev/.env --akamai-purge-token=YOUR_TOKEN_HERE
ddev restart
```

The flag `--akamai-purge-token` becomes the environment variable
`AKAMAI_PURGE_TOKEN` inside the web container. Keep `.ddev/.env` out of version
control, and scope the token to purge operations with least privilege.

## The purge pipeline

The module registers with the Purge suite: the Core Tags queuer queues invalidations
based on cache tags, and the Late Runtime processor sends the purge requests to the
Akamai service. You can review the purger and pipeline under
**Configuration → Development → Performance → Purge**
(`/admin/config/development/performance/purge`).

## Purge by path

For ad-hoc invalidation, the module provides a custom administration form that lets
you purge specific paths. It also ships **Drush commands** for triggering purges
from the command line or scripts.

## A note on data flow

Purge requests are internal HTTP calls to the configured Akamai service proxy,
authorised by the purge token. Keep the token secret and the service details
accurate so purges reach the right endpoint.
