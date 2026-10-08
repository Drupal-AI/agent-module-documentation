# Configuration

Fastly's settings are spread across several forms under **Configuration → Web
services → Fastly** (`/admin/config/services/fastly`). All of them require the
**Administer Fastly** (`administer fastly`) permission. This page walks through
each form in turn.

Note that the module ships no default configuration — settings only come into
existence once you save each form.

## Credentials: the main form

The main Fastly settings form is where the integration comes to life:

- **API token** — your Fastly API token. To save it, the token needs the
  `global:read` and `purge_all` scopes. The module will validate that the token
  and service work before treating the credentials as usable.
- **Service ID** — the ID of the Fastly service that fronts this site.
- **Site ID** — an optional prefix added to your cache tags before they're hashed
  into Surrogate Keys. Set this when several Drupal sites share one Fastly service,
  so their purges don't collide. If you leave it blank, a random one is generated
  and stored for you.

### Credentials via environment variables (recommended)

Rather than storing secrets in configuration, you can supply them through
environment variables. When these are set, they take precedence over the stored
config and the matching fields are locked in the UI:

| Variable | Overrides |
|----------|-----------|
| `FASTLY_API_TOKEN` | API token |
| `FASTLY_API_SERVICE` | Service ID |
| `FASTLY_SITE_ID` | Site ID |
| `FASTLY_CACHE_TAG_HASH_LENGTH` | Surrogate‑Key hash length |

This is the safer approach — the token never lands in your exported
configuration.

## Purge Options

- **Purge method** — choose **Instant** *(default)*, which purges content from
  Fastly immediately, or **Soft**, which marks content as stale so Fastly can
  serve it while revalidating in the background. Soft purging pairs naturally with
  the stale‑content options below.
- **Cache tag hash length** — how many characters of each hashed cache tag go into
  the `Surrogate-Key` header. Fastly caps that header at 16 KB, so on pages with
  many cache tags you may need to shorten this to stay under the limit.
- **Purge logging** — log every purge operation, useful while debugging.

## Stale Content Options

These let Fastly keep serving something rather than nothing while it refreshes or
when your origin has trouble:

- **Stale while revalidate** (with a value in seconds) — serve the cached (stale)
  copy for up to N seconds while Fastly fetches a fresh version in the background,
  smoothing origin load.
- **Stale if error** (with a value in seconds) — serve the stale copy for up to N
  seconds if your origin returns an error, so visitors see a page instead of an
  error during a hiccup.

## Image Optimizer

If your Fastly service has the Image Optimizer enabled, this form lets Drupal
route images through it:

- **Enable image optimization** — the master switch.
- **WebP** and **WebP quality** — automatically serve WebP where supported, at a
  quality you choose.
- **JPEG quality** and **JPEG type**, plus options like **optimize**, **resize
  filter**, and **upscale** — tune how images are compressed and resized at the
  edge.

Once enabled, a **Fastly** image field formatter becomes available. Select it on
an image field's **Manage display** to render that field through the optimizer.

## Webhooks

- **Enable webhooks** — turn on outgoing notifications.
- **Webhook URL** — where Fastly‑related notifications are posted (for example, a
  Slack incoming webhook).
- **Notifications** — pick which events (such as purges) trigger a post.

## Edge Modules

The Edge Modules screen is a UI for enabling pre‑built Fastly edge behaviors,
each of which uploads its own VCL to your service when turned on. Available
modules include **CORS headers**, **country block**, **redirect hosts**, **URL
rewrites**, **disable cache**, several third‑party integrations (**Datadome**,
**Netacea**, **Blackfire**, other‑CMS), and operational helpers like **increase
timeouts for long jobs** and **force cache miss on hard reload for admins**. Enable
only the ones you need — each writes VCL to Fastly, so they require working
credentials.

## Verify it worked

After entering credentials, the module tracks whether they're sufficient to purge.
The quickest confirmation is to run a purge from the command line:

```bash
drush fastly:purge:all
```

A success line means your token and service are wired up correctly. From then on,
content edits purge the affected pages automatically.
