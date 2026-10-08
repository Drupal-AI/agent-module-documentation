# Protected Pages — manual setup guide

**Protected Pages** (`protected_pages`) lets you put a password in front of any
page on your site. You add a path plus a password on an admin form, and from then
on visitors must enter the password before they can see that page. Unlike the
similar Protected Node module — which only protects nodes — Protected Pages can
protect **any path**, including private files, and it supports wildcards so you
can lock down a whole section (or the entire site) at once.

It's handy for staging a page for a client behind a shared password, gating a
downloadable file, or hiding a section from the public without building a full
permission scheme. You can set a **global password** that unlocks every protected
page, a **per-page password**, or a mix of the two, and you can email the page's
URL to people so they know where to go.

The module does nothing until you configure it: you set global options once, then
add each path you want to protect. Users who hold the "bypass" permission skip the
prompt entirely. Protected Pages depends only on core's **Path Alias** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and set permissions.
2. [Configuration](configuration/index.md) — the global settings form, adding
   protected paths, the password prompt text, and brute-force protection.

## Where it lives in the admin menu

Protected Pages lives under **Configuration → System → Protected Pages**:

- `/admin/config/system/protected_pages` — the list of protected pages, where you
  add and manage paths.
- `/admin/config/system/protected_pages/settings` — the global settings form
  (route `protected_pages_settings`).

All of these admin screens require the **Administer protected pages
configuration** permission. The visitor-facing password prompt itself lives at
`/protected-page`.

## How to use it

The typical flow is: set permissions, decide on your global settings (password
mode, how long an unlock lasts, and the prompt wording), then add one row per path
you want to protect. Each path can start with `/` and use `*` wildcards — for
example `/new-events/*` protects everything beneath that path, and `/*` protects
the whole site. When a visitor without the bypass permission requests a protected
path, they get the password prompt; once they enter a correct password the unlock
lasts for the session length you configured.
