# Configuration

The module works as soon as it is enabled and the *Create json logs* permission is
granted. The settings tune the safety limits — how many logs each user may create,
and how large each entry may be — with **site‑wide defaults** on the settings form
and **per‑log‑type overrides** on each bundle.

## Open the settings form

1. Log in as a user with the **Administer log_json types** permission.
2. Go to **`/admin/config/decoupled_json_log`**.

These values are the **defaults** (stored in `decoupled_json_log.settings`); each
log type can override the rate‑limit values individually (see below).

## Rate limiting (applied per log type)

Rate limiting stops a buggy or malicious front end from flooding your site with log
entries. In 1.1.x the counts are tracked **separately per log type (bundle)**, so
entries of one type never consume another type's allowance. Each user is limited to
a maximum number of entries per rolling window:

- **Count for anonymous users** (`rate_limit.count_anon`, default **500**) — the
  maximum number of entries the anonymous user can create during the interval.
  Because *every* anonymous visitor shares the one anonymous account, this limit is
  shared across all of them, so it is usually set higher than the authenticated
  limit.
- **Count for authenticated users** (`rate_limit.count_auth`, default **50**) —
  the maximum number of entries **each** authenticated user can create during the
  interval.
- **Interval** (`rate_limit.interval_seconds`, default **86400**, i.e. one day) —
  the length of the rolling window, in seconds, over which entries are counted.

The author (`uid`) and creation time (`created`) of each entry are always stamped
by the server in `preSave()`, so clients cannot evade the rate limit by spoofing
the author or backdating an entry.

## Per‑log‑type overrides

On each log type's form at **`/admin/structure/log_json_types`** you can override
the defaults with `rate_limit_count_anon`, `rate_limit_count_auth`, and
`rate_limit_interval_seconds`. Leaving a field empty (NULL) inherits the site‑wide
default. A count of **`0`** rejects *every* client‑validated submission to that
type — useful for a **server‑only** log type that your own code writes
programmatically (a programmatic `save()` skips entity validation, so server writes
still succeed while client POSTs are refused).

## Payload size limits

A `MaxPayloadSize` validation constraint rejects an entry whose field exceeds its
byte limit and logs a warning to the `decoupled_json_log` channel. Size is measured
in bytes; empty fields are skipped.

- **Maximum log size** (`max_payload_bytes.log`, default **65536**, i.e. 64 KB) —
  caps the `log` field.
- **Maximum device info size** (`max_payload_bytes.device_info`, default **8192**,
  i.e. 8 KB) — caps the `device_info` field.

## Save

Click **Save configuration**. The new defaults apply to subsequent log submissions
immediately; per‑type overrides take effect when you save the log type.

## Related admin pages

- **Permissions** (`/admin/people/permissions`) — grant **Create json logs** to
  the roles that should be able to log (often anonymous for public apps). The
  view/edit/delete permissions are restricted and should stay with admins.
- **Log types** (`/admin/structure/log_json_types`) — add bundles beyond the
  default `error` bundle and set their per‑type rate‑limit overrides.
- **Reviewing entries** (`/admin/content/log-json`) — logs are managed inside
  Drupal (build a View, use bulk operations, or hook up ECA for alerts). They
  cannot be listed, edited, or deleted through the API by design; only creation is
  exposed.
