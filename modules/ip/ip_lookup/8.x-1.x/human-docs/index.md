# User IP Lookup — manual setup guide

**User IP Lookup** (`ip_lookup`) keeps an audit trail of your users' logins. Every
time a user signs in (and when a new user account is created), it records who they
are and how they connected: the user ID and username, the browser name, version,
and platform derived from their User‑Agent, their IP address, and the **city and
region** resolved from that IP. You review it all in an admin report.

The geolocation part uses the [ipdata.co](https://ipdata.co) service. To save API
calls, the module first checks its own local table for a previously seen IP and
only queries ipdata.co when it hasn't. It's worth knowing this is a well‑behaved
lookup: it only ever geolocates the *connecting user's own IP* against the fixed
ipdata.co host — it never takes a URL or host from the request — so it isn't an
SSRF risk, it uses TLS‑verified HTTPS, and the report escapes its output.

Setup is quick: install, enter an ipdata.co API key, and grant the permission for
who may see the report. The module ships defaulting to ipdata's shared `test` key,
which allows only a limited number of lookups — replace it with your own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set your ipdata.co API key and
   grant the report permission.

## Where it lives in the admin menu

- **Settings:** **Configuration → People → IP Lookup**
  (`/admin/config/people/ip-lookup`, route `ip_lookup.api_settings_form`) — where
  you enter the ipdata.co API key.
- **The report:** **People → IP Lookup** (`/admin/people/ip-lookup`) — the login
  history, both gated by the *access iplookup table* permission.

## How to use it

Once the API key is set and users start logging in, open **People → IP Lookup** to
see the login history. The report is paginated and sortable, captures browser and
location details per login, and highlights the current user's own rows. Use it to
audit where and how your users sign in.
