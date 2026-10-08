# Configuration

Cloudflare Purge has two admin forms: a **Credentials** form (what you must fill in
before anything works) and an **Auto-Purge Settings** form (all optional). Both
live under **Configuration → Cloudflare Purge**.

## Step 1 — Enter your credentials

Go to **Configuration → Cloudflare Purge → Credentials**
(`/admin/config/cloudflare-purge/credentials`). You need the **Administer
cloudflare purge** permission to see this form.

- **Authentication method** — choose **Bearer Token** (recommended) or **Email +
  Global API Key** (legacy). A Bearer Token can be scoped in Cloudflare to just the
  *Zone → Cache Purge → Purge* permission, so it can do far less damage if leaked
  than the all-powerful Global API Key.
- **Zone ID** — the 32-character hex ID of the Cloudflare zone for your domain
  (found on your domain's Overview page in Cloudflare). The module validates it
  against the pattern `^[a-f0-9]{32}$`.
- **Bearer Token** — for the Bearer method: the API token you created in
  Cloudflare.
- **Email** and **Global API Key** — for the legacy method: your Cloudflare account
  email and Global API Key.

Click **Save**, then run `drush cloudflare:status` (or reload the page) to confirm
the module recognizes valid credentials. Until it does, the manual purge forms stay
disabled.

### Where credentials are stored (three tiers)

The module resolves each credential in priority order, so you can keep secrets out
of the database:

1. **`settings.php` override** (highest priority) — set
   `$settings['cloudflare_purge_credentials']` with your `zone_id` and
   `bearer_token` (or `email` + `authorization` for legacy). A **complete** set
   here disables the on-screen credentials form entirely; a partial set warns but
   leaves the form editable.
2. **Key module** — if [Key](https://www.drupal.org/project/key) is enabled, the
   credential fields can point at Key entities instead of holding the raw value.
   This is the recommended production choice.
3. **Plain config** — the values typed straight into the form. Convenient for
   local development, but the secret then lives in `cloudflare_purge.settings`.

```php
// settings.php — Bearer Token (recommended)
$settings['cloudflare_purge_credentials'] = [
  'zone_id'      => '<32-hex zone id>',
  'bearer_token' => '<token with Zone > Cache Purge > Purge>',
];
```

## Step 2 (optional) — Automatic purging

Everything below is opt-in. If you never open the Auto-Purge Settings form
(`/admin/config/cloudflare-purge/settings`), the module simply waits for you to
purge manually.

### Auto-purge basics

- **Enable automatic purging** *(off by default)* — when on, Drupal tells
  Cloudflare to purge whenever cache tags for the selected entity types are
  invalidated (i.e. when that content is saved or deleted).
- **Entity types** — which entity types trigger a purge. Defaults to **node**,
  **taxonomy_term**, and **media**.
- **Use queue (process on cron)** *(off by default)* — instead of purging
  immediately as content is saved, collect the tags and send them to Cloudflare in
  batches on the next cron run. Turn this on for high-traffic sites so you stay
  under Cloudflare's rate limits.
- **Purge everything on cache flush** *(off by default)* — purge the **entire**
  Cloudflare zone every time Drupal does a full cache flush (`drush cr`). This is
  heavy and rate-limited, so leave it off unless you really want it.
- **Queue max age** *(off by default; 900 seconds)* — discard queued purge items
  older than this many seconds. Useful when Cloudflare's own edge TTL would already
  have expired the content, so there is no point purging it late.

### Multi-site and rate limiting

- **Tag prefix** *(empty by default)* — a string added in front of every cache tag
  sent to Cloudflare. Use it to keep tags distinct when several Drupal sites share
  one Cloudflare zone.
- **Rate limit** *(off by default; 60 per minute)* — cap how many purge requests
  the module makes per minute. This protects a free-tier Cloudflare account. Note
  the limit is tracked per web server, not globally across a cluster.
- **Enable logging** *(off by default)* — log *successful* purges too, not just
  errors (errors are always logged). Turn this on to get a full **Purge History**
  page. Requires the core Database Logging (`dblog`) module.
- **History limit** *(100; max 1000)* — how many rows the Purge History page shows.

### Cache-Tag response header

Cloudflare can purge by tag most reliably when your pages advertise their tags in a
`Cache-Tag` HTTP response header. The module can emit that header, and the same
formatting rules are used for the header and for tag purges so the two always
agree.

- **Filter header tags** *(on by default)* — include only purgeable (entity-type)
  tags in the header, not every internal Drupal tag.
- **Hash tags** *(off by default)* — hash the tags in both the header and the purge
  call. Because both sides are hashed identically, purging still matches. Useful to
  keep tag names opaque and short.
- **Hash length** *(16; range 6–64)* — length of each hashed tag.
- **Header max bytes** *(7168; range 1024–16384)* — cap the header size so it stays
  under the roughly 8 KB limit most servers and CDNs enforce. This prevents 5xx
  errors on pages that carry a lot of tags.

## Saving and setting values from Drush

Click **Save configuration** on either form to apply changes. You can also set
values from the command line:

```bash
drush cset cloudflare_purge.settings auto_purge_enabled true -y
drush cset cloudflare_purge.settings auth_method bearer -y
```

## Permissions

Four permissions govern who can do what:

- **Administer cloudflare purge** *(restricted)* — the Credentials and Auto-Purge
  Settings forms, and clearing history. Trusted admins only.
- **Cloudflare purge** — the manual purge forms (by URL, tag, prefix, hostname) and
  the queued-tags view. Safe to delegate to editors.
- **Cloudflare purge everything** *(restricted)* — the destructive "Purge
  Everything" confirm form.
- **View cloudflare purge history** — the Purge History page.
