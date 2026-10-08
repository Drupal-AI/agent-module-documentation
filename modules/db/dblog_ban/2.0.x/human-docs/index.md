# Database logging ban operation — manual setup guide

**Database logging ban operation** (`dblog_ban`) adds a **Ban / Unban** link to
the entries in Drupal's Database Logging (`dblog`) report, so you can block a
misbehaving IP address straight from the log. If you have ever scrolled the
*Recent log messages* report on a public site and seen the same IP repeatedly
probing `node/add`, hammering the login form, or fishing for backend scripts, this
module turns "I should block that" into a couple of clicks — the link shows *Ban*
when the IP is currently allowed and *Unban* when it is already banned.

Under the hood it relies on Drupal core's **Ban** module (`ban.ip_manager`) to do
the actual enforcement; this module just adds the convenient action to the log.
It's a security-positive, incident-response convenience rather than an
access-control system in its own right, and a dedicated permission controls who is
allowed to ban.

One important setup detail on Drupal 9/10/11: unlike the old Drupal 7 version, the
Ban/Unban link does **not** appear automatically when you enable the module. You
have to add a field to the *watchdog* View once (described under "How to use it"
below). Note also that the link currently appears on the log **overview** screen;
a Ban/Unban link on the individual message *Details* page is a known gap.

**A couple of caveats about IP banning.** If your site sits behind a reverse proxy
or CDN, make sure Drupal records the *real* client IP (configure trusted proxies),
or you may ban the proxy instead of the attacker. And remember that IP addresses
are often shared or dynamic, so a ban can catch innocent visitors — treat IP bans
as a blunt, usually temporary measure.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside core's Ban and Database Logging modules.

There is **no settings form** for this module. Its one setup step is adding the
Ban/Unban link field to the watchdog View, described below.

## Where it lives in the admin menu

The Ban/Unban links appear on **Reports → Recent log messages**
(`/admin/reports/dblog`) once you have added the link field to the View. Banned IPs
are managed by core's Ban module at **Configuration → People → IP address bans**
(`/admin/config/people/ban`).

## How to use it

After enabling the module, add its link field to the log View one time:

1. Go to **Structure → Views** and edit the **watchdog** view
   (`/admin/structure/views/view/watchdog`).
2. Add a new field named **Ban/Unban link** (machine name
   `dblog_ban_ban_unban_link`). Note this is a separate field from the core
   *Operations* column.
3. **Save** the view.

Now visit **Reports → Recent log messages**. Each entry shows a Ban or Unban link
(depending on the IP's current state); clicking it bans or unbans that IP through
core Ban. Grant the module's ban permission only to trusted administrators.
