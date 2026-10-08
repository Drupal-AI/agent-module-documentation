# Configuration

Counter has a settings page for tuning how it records and refreshes data, and it
displays through a block (and, optionally, through Views).

## Open the settings

1. Log in as a user with the **`administer counter`** permission.
2. Go to **Configuration → Counter settings** (`/admin/config/counter`). The page
   offers a basic form and an advanced form.

## Performance‑related settings

Two delay settings on the configuration page let you trade freshness for
performance:

- **Refresh delay (seconds)** — how long the module waits before refreshing the
  counter data it displays. Between refreshes the value is read from cache, which
  is faster and lighter on your site. A higher delay means better performance but
  slightly less up‑to‑the‑second numbers.
- **Recording delay (seconds)** — how long to wait before recording the next data
  point. This is useful for high‑volume sites (or a slower database): if you set it
  to, say, 10 seconds, repeated hits within that window are collapsed rather than
  each writing a row.

You can also set **initial values** for the counters, so the displayed numbers can
start from a chosen baseline rather than zero.

## Displaying the counter — the block

The statistics are shown through the Counter **block**:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Place the **Counter** block in a region — a footer or sidebar is typical for a
   "visitor number" display.
3. Configure block visibility as needed and save.

The block can show the site visit counter, node count, unique visitors, and the
client IP, depending on what you enable.

## Reporting with Views

Counter integrates with the **Views** module. To build your own reports, create a
new View and select **Counter** as the data source. The recorded fields include the
counter ID / node ID, content type, browser name and version, platform, IP address,
access date, and accessed URL — so you can build per‑day, per‑week, per‑month, or
per‑year statistics tables.

## Reminders before public use

- **Recording IP addresses is personal data under GDPR** — have a lawful basis, a
  retention period, and a privacy‑notice entry.
- **Behind a proxy or CDN**, configure `reverse_proxy` and
  `reverse_proxy_addresses` in `settings.php` or the client IP will be wrong.
- **Page caching** and a per‑request counter can conflict; verify behavior under
  anonymous traffic.
