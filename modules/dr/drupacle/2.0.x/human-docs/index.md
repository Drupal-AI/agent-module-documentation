# Drupacle — manual setup guide

**Drupacle** (`drupacle`) is a tool for connecting Drupal to an **Oracle**
database. You give it connection details for an Oracle database, and it generates
a reusable "Oracle database object" (referenced by a short‑code) that your code
can use to talk to that database through PHP's OCI8 functions. It supports
connecting to **multiple** Oracle databases, which makes it handy for integrations
that must read from or write to Oracle systems alongside your normal Drupal
database.

Using it is a three‑step flow, per the project page: install and enable the OCI8
Oracle driver on the server; create a Drupacle connection under
**/admin/drupacle/connections**; then copy the generated short‑code and use it in
your code to run queries against Oracle.

Drupacle provides its own permissions to gate who can create and manage
connections — keep those restricted to trusted users. The connection details you
enter (including the Oracle password) are saved in the connection's
configuration, so control who can manage connections and be mindful of where that
configuration is exported. You write the OCI8 queries yourself in your own code
using the short‑code; follow normal Drupal/PHP database practice (bind variables)
when you do.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the OCI8 driver, install with
   Composer, and enable the module.
2. [Configuration](configuration/index.md) — create and manage Oracle connections,
   and how to handle credentials safely.

## Where it lives in the admin menu

Drupacle's connection manager lives at **/admin/drupacle/connections**, where you
create and manage the Oracle database connections. See
[Configuration](configuration/index.md) for the full walkthrough.
