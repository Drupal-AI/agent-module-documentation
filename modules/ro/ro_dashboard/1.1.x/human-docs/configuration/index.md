# Configuration

Configuring RO Dashboard means telling it which sites to watch, connecting each to
its Site Guardian reports, and tuning what it should ignore so the status view
stays meaningful.

## 1. Grant permissions to trusted operators

Because the dashboard aggregates operational data across sites, restrict access
tightly. Go to **People → Permissions** (`/admin/people/permissions`) and grant RO
Dashboard's permissions only to the roles that genuinely need to see and manage
multi-site status. Save.

## 2. Add the sites you want to monitor

Each monitored site is modelled as a **Site entity**:

1. From the RO Dashboard admin area, create a new **Site** entity for a site you
   want to watch.
2. Enter the details it needs to reach that site's **Site Guardian** reports —
   including the Site Guardian **secret** used to authenticate to those reports.
3. Save. Site entities are **revisionable**, so you can review how a site's
   configuration has changed over time.

> **The Site Guardian secret is stored as plain text in this version.** The
> maintainer has flagged this as a known limitation to improve. Until then, treat
> Site entities as sensitive records: keep the dashboard's permissions restricted to
> trusted operators, secure the connection to each monitored site (authentication +
> HTTPS), and don't expose these entities more widely than necessary.

## 3. Let it scan

RO Dashboard **scans the monitored sites once a day as part of cron** and parses
the Site Guardian reports it finds — the main Site Guardian report, User Status,
PHP Status, Server Benchmarks, and the Watchdog Summary. Make sure cron is running
regularly so the status view stays current. The dashboard then shows a simple view
of each site and its overall status.

## 4. Tune the ignore lists

Once you've reviewed a finding and decided it's acceptable, you can stop it from
flagging a site as "warning" or "error":

- **Global ignore list** — items or modules to ignore across *all* monitored
  sites.
- **Per-site ignore list** — items or modules to ignore for one specific site.
  These are **always added on top of** the global list, so a per-site ignore never
  removes a global one.

Use these to silence known, accepted conditions so the dashboard only lights up for
things that genuinely need attention.
