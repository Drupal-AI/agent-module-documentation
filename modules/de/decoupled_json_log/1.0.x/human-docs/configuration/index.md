# Configuration

The module works as soon as it is enabled and the *Create json logs* permission is
granted. The settings form only tunes the safety limits — how many logs each user
may create, and how large each entry may be.

## Open the settings form

1. Log in as a user with the **Administer log_json types** permission.
2. Go to **`/admin/config/decoupled_json_log`**.

## Rate limiting

Rate limiting stops a buggy or malicious front end from flooding your site with log
entries. Each user is limited to a maximum number of entries per rolling time
window:

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
by the server, so clients cannot evade the rate limit by spoofing them.

## Payload size limits

To stop oversized entries from bloating your database, the two JSON fields are
capped by byte size. An entry that exceeds its limit is rejected, and the oversized
payload is recorded in the module's log channel.

- **Maximum log size** (`max_payload_bytes.log`, default **65536**, i.e. 64 KB) —
  the maximum size in bytes of the `log` field.
- **Maximum device info size** (`max_payload_bytes.device_info`, default **8192**,
  i.e. 8 KB) — the maximum size in bytes of the `device_info` field.

## Save

Click **Save configuration**. The new limits apply to subsequent log submissions
immediately.

## Related admin pages

- **Permissions** (`/admin/people/permissions`) — grant **Create json logs** to
  the roles that should be able to log (often anonymous for public apps). Keep the
  view/edit/delete permissions restricted to admins.
- **Log types** (`/admin/structure/log_json_types`) — add extra bundles beyond the
  default `error` bundle to categorize your logs.
- **Reviewing entries** — logs are managed inside Drupal (build a View, use bulk
  operations, or hook up ECA for alerts). They cannot be listed, edited, or deleted
  through the API by design; only creation is exposed.
