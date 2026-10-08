# Configuration

Login History works the moment it is enabled — it records logins with no setup. The
only thing to configure is how much history to keep, plus deciding who can view the
data and whether to show the "Last login" block.

## The settings form

Go to **Configuration → People → Login history**
(`/admin/config/people/login-history`), which requires the **Administer login
history** permission. It has a single field:

- **Per User** (`keep_user`, default **50**) — the maximum number of login rows kept
  for each user. When a user goes over the limit, the oldest rows are pruned. Set it
  to **0** to keep everything with no pruning — useful for a full‑audit environment,
  at the cost of unbounded table growth.

Pruning happens automatically in two places: immediately after each login for that
user, and on **cron** for any user who is over the limit. When a user account is
deleted, all of its login rows are removed too.

You can also read or set the value from the command line:

```bash
drush cget login_history.settings keep_user
drush cset login_history.settings keep_user 10 -y
```

## The reports

- **Site‑wide report** — **Reports → Login history**
  (`/admin/reports/login-history`), for users with **View all login histories**.
  It is backed by a default Views view (`login_history`) that you can customize or
  clone.
- **Per‑user history** — `/user/{uid}/login-history`, for users with **View own login
  history** (they see their own).

Because the login data is a Views base table, you can build your own reports: filter
by user, login date, IP address, or the one‑time‑login flag; add a date‑range exposed
filter; count logins per user; or add a data‑export display to produce CSV for
compliance. A built‑in **Logins** relationship on the users table lets a user‑based
view pull in each user's historical logins.

## The "Last login" block

The module provides a **Last login** block (in the "User" category). Place it from
**Structure → Block layout** (`/admin/structure/block`) in any region. For a
logged‑in user it shows a message like "You last logged in from <IP> using
<browser>," drawn from their previous login, and — if they have the **View own login
history** permission — a link to their full history. It only appears to authenticated
users.

## Permissions recap

Three permissions at **People → Permissions** govern access:

- **View own login history** — a user's own history page and the block link.
- **View all login histories** — the site‑wide report.
- **Administer login history** — the settings form above.

## Where the data lives

Login History stores its rows in a plain `login_history` database table (not an
entity), capturing the user, timestamp, IP/hostname, browser, and the one‑time‑login
flag. If you need to query it directly for a custom dashboard, you can read it with
the database API or SQL — for example:

```bash
drush sqlq "SELECT uid, login, hostname, one_time FROM login_history ORDER BY login DESC LIMIT 5"
```
