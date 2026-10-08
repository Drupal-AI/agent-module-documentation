# Database SSL Check — manual setup guide

**Database SSL Check** (`database_ssl_check`) answers a question most sites never
check: is the connection between Drupal and its database actually encrypted? Your
visitors reach the site over HTTPS, but the *back‑end* link to the database is easy
to overlook — and if the database lives on another host (a managed or remote DB in
particular), an unencrypted connection is a real exposure. This module adds entries
to Drupal's **Status Report** describing how your site connects to the database:
whether the connection uses SSL/TLS, the cipher in use (if any), and the client
library version.

It is a small, read‑only diagnostic — a *positive* security check that helps you
confirm a best practice rather than something you configure. It has no other module
dependencies and runs on Drupal 9, 10, and 11 (and is declared compatible through
12). It adds no permission of its own and plays no part in access control; the
information simply appears on the Status Report, which is already an
administrator‑only page.

Because the details it surfaces (database connection parameters, cipher) are
operational and sensitive, they belong on that admin‑gated Status Report and should
not be exposed publicly — which, since it only writes to the Status Report, is
already how it behaves.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form. Once
enabled, its checks appear automatically on the Status Report.

## Where it lives in the admin menu

After enabling, look under **Reports → Status report**
(`/admin/reports/status`). New entries there describe your database connection's
SSL/TLS status, the cipher used (if any), and the client library version.

## How to use it

There is nothing to run — just read the Status Report. If the entries show the
connection is **not** encrypted and your database is remote or managed, that is your
signal to configure SSL/TLS on the database connection (typically by adding the
relevant PDO SSL options to the connection in `settings.php`). Re‑check the Status
Report afterwards to confirm the connection now reports as encrypted.
