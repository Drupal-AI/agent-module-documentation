# Configuration

Configuring the dashboard is mostly a matter of telling it which remote sites to
watch and giving it the credentials to sign each request. This page walks through
that, then covers the two access considerations that matter most: **where the
shared secrets live** and **who can see the dashboard**.

## Before you start: set up each remote site

The dashboard only reads; the real work happens on the sites you want to monitor.
On each of those sites:

1. Install and enable the **Multisite Status Report** module.
2. Note its **key identifier** and its **shared secret**. You will paste both
   into the dashboard.

## Add a monitored site

1. Log in as a user with the restricted **administer multisite status dashboard**
   permission.
2. Go to **Configuration → Web services → Multisite Status Dashboard → Monitored
   sites** (`/admin/config/services/multisite-status-dashboard/sites`).
3. Add a site and fill in its fields:
   - **Label** — a human‑friendly name for the site.
   - **Base URL** — the remote site's URL. Use **HTTPS**: HMAC protects the
     secret, but the status response still contains sensitive information about
     the site, so it must travel encrypted.
   - **Key identifier** — the `key_id` from that site's Multisite Status Report
     configuration.
   - **Secret** — the shared secret from that site. It is used only to compute
     the request signature locally and is **never transmitted**.
   - **Enabled** — whether this site is actively polled. Disable a site to pause
     monitoring it without deleting its definition.
4. Save. Repeat for each site in your fleet.

## Fetching the data

Once sites are added, status is gathered two ways:

- **In the background**, on cron, via a queue worker — this keeps the dashboard
  fast and resilient.
- **On demand**, with the **Refresh now** button on the dashboard, which runs an
  immediate fetch through the Batch API.

Fetched results are stored in the **key/value store**, not in configuration, so
this volatile runtime data never lands in your exported config. Unreachable sites
show an error row with the last error preserved so you can see what went wrong.

## Handling the shared secrets

The per‑site secret is part of the `monitored_site` configuration entity. To keep
the secrets out of shared configuration:

- Keep the exported configuration **out of public version control**, or
- **Override** the secret per environment (for example in `settings.php`), or
- Use **Config Ignore** / **Config Split** to keep the per‑site secrets out of
  shared configuration.

Because these secrets are project credentials rather than a value the module
reads from a Key entity, storing them as environment variables and injecting them
per environment is the safest pattern. Treat them like any other API credential:
never hard‑code them into committed config.

## Egress and access considerations

- **Outbound requests (egress):** the dashboard site makes signed HTTPS requests
  out to every monitored site's `/multisite-status-report/summary` endpoint. Make
  sure the dashboard server is allowed to reach those hosts, and that outbound
  TLS verification (which the client uses by default) is not disabled.
- **Who can view the dashboard:** the aggregated report reveals which sites are
  behind on updates or have pending security releases, so treat it as sensitive.
  Grant **view multisite status dashboard** only to the operators
  who genuinely need the fleet overview, and keep the restricted **administer**
  permission (which exposes the secrets on the edit forms) to administrators
  alone. The dashboard view itself does not render the stored secrets.
