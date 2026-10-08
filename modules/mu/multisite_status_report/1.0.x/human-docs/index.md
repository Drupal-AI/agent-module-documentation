# Multisite Status Report — manual setup guide

**Multisite Status Report** (`multisite_status_report`) is the *agent* side of a
fleet‑monitoring pair: it securely exposes a single Drupal site's status report,
available updates, and security information as **JSON endpoints**, so an external
monitor can track the site's health without anyone logging in. It turns the data
you already see on **Reports → Status report** and **Reports → Available
updates** into machine‑readable JSON — protected by strong authentication so that
sensitive site information is never open to whoever guesses or sniffs a URL.

It provides three read‑only endpoints: a full **status report**, a list of
enabled projects with available‑update and security info
(**modules‑updates**), and a compact **summary** tailored for dashboards. Every
request must be signed with **HMAC‑SHA256** — clients send a key id, a timestamp,
a nonce, and a signature in request headers, and the shared secret itself never
travels over the wire, even if the URL is intercepted. The module adds
**replay protection** (a timestamp window plus a single‑use nonce store),
**brute‑force protection** (per‑IP throttling through core's Flood API and
constant‑time signature comparison with `hash_equals()`), and it needs **no
contributed dependencies** — the authentication is a native Drupal auth provider,
no OAuth or JWT modules required.

On install it generates a key identifier and a strong shared secret, creates a
dedicated login‑blocked service account that carries the access permission, and
activates the endpoints. Its natural companion is the **Multisite Status
Dashboard** module, which aggregates many sites running this module onto one
screen.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — read the key id, generate/rotate the
   shared secret, add site notes, and toggle the endpoints.

## Where it lives in the admin menu

The settings form is at **Configuration → Development → Multisite Status Report**
(`/admin/config/development/multisite-status-report`), reachable by users with the
restricted **administer multisite status report** permission. The three JSON
endpoints live under `/multisite-status-report/…` and are consumed by machines,
not browsed by people.
