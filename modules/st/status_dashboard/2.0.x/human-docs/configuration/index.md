# Configuration

Setting up Status dashboard means connecting it to each site you want to monitor,
optionally turning on email notifications, and — importantly — locking down who can
see it.

## Open the settings form

1. Log in as an administrator.
2. Go to **Configuration → Development → Status Dashboard**
   (`/admin/config/development/status-dashboard`).

## Connect the client sites

The **URL and Secret** fieldset is where you list the sites to monitor. It is a
repeatable ("multiple") set — add one row per site:

- **URL** — the address of the client site whose updates you want to monitor.
- **Secret** — the shared secret used to connect to that client site. This must
  match the secret you set in that site's own Status Dashboard Client
  configuration (`/admin/config/development/status-dashboard-client`).

Add a row for each site, then save.

## Email notifications (optional)

If you want update alerts by email, tick **Enable email notifications** in the
**Email notifications** fieldset and fill in:

- **Email** — the address that should receive the notifications.
- **Period** — how often to send: **Daily**, **Weekly**, or **Monthly**.
- **Notification types** — which kinds of updates to include: **Core updates**,
  **Security updates**, and/or **Feature updates**.

## How updates get collected

Once configured, the dashboard checks each connected client site after every
**cron run** and displays the results. Open the dashboard from the **Status
Dashboard** link in the administration menu to see the collected update
information for all your sites.

## Lock down access — do this

The update and version information the dashboard shows is **sensitive**: it lists
exactly which module versions are installed and which have known-vulnerability
updates pending. That is precisely the information an attacker would want.

- Grant the dashboard's permissions only to **trusted administrators**.
- **Never** expose the dashboard to anonymous or untrusted users, and never make it
  publicly reachable.

Treat the dashboard as an internal operations tool for people who are already
allowed to patch the sites.
