# Configuration

Custom Admin URL has one job to configure: tell it which **back‑office host/URL**
is allowed to serve admin and user routes. Everything else is about making sure
that host can be trusted.

## Set the back‑office URL

1. Log in as an administrator (on the back‑office host, so you don't lock yourself
   out).
2. Go to **Configuration → System → Custom Admin URL**
   (`/admin/config/system/custom-admin-url`).
3. Enter the **back‑office URL** — the host/URL through which administration should
   be reachable.
4. Save.

From then on, admin and user routes reached through any other (front‑office) host
return a **403**, while the back‑office host serves them normally.

## Make the host trustworthy

This module keys its decision on the request host, so that host must not be
spoofable. Two prerequisites live outside this form:

- **Configure `trusted_host_patterns`** in `settings.php` so Drupal only accepts
  requests for hosts you expect. Without this, the `Host` header can be forged and
  the restriction can be bypassed.
- **Ensure the front‑office host genuinely cannot serve admin routes** at the web
  server / hosting layer where practical, so this check is one layer among several
  rather than the only barrier.

## Important: this is defense‑in‑depth, not your only guard

Restricting the admin path by host is helpful, but it is a hardening layer — a form
of security‑by‑obscurity — not a replacement for access control. Keep Drupal's
**roles and permissions** correct regardless: every admin route should still be
protected by the right permissions, so that even if someone reaches it, core denies
them. Never treat "the admin URL is hidden" as protection on its own.

## Verify

Reach `/admin` through the **front‑office** host and confirm you get a **403**;
reach it through the **back‑office** host and confirm it loads (subject to your
permissions). If a legitimate admin request is unexpectedly blocked, re‑check the
back‑office URL value and your `trusted_host_patterns`.
