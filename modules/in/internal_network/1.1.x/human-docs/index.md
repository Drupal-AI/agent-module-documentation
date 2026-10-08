# Internal Network Condition — manual setup guide

**Internal Network Condition** (`internal_network`) shows or hides content based on
whether a visitor's IP address falls inside the internal network ranges you define
using standard CIDR notation. It's the tool for "office/VPN users see this,
everyone else doesn't" scenarios — internal announcements, staff resources,
pre‑decisional documents, or intranet sections carved out of a public site.

It works in several ways at once. It adds a **block‑visibility condition** so any
block can be shown only to internal IPs; a Twig function, `is_internal_network()`,
for conditional rendering inside templates; **route access restriction** (return a
403 or redirect to the homepage for external visitors); automatic **menu‑link
hiding** for restricted routes; and, new in 1.1.0, **taxonomy‑term restriction** so
tagging content with a restricted term controls its visibility by IP at the node or
paragraph level. A central admin page ties it together with global IP ranges,
optional logging, a test mode, and bypass roles.

Please read one thing carefully before relying on it. Most of what this module does
is **visibility**, not a hard security boundary — hiding a block or a menu link does
not by itself make the underlying content unreachable. For genuinely sensitive
content, use Drupal's real access controls (permissions, entity access, and the
module's hard‑deny 403 route/term options) rather than visibility alone. Equally
important: the module keys on the **client IP**, whose accuracy depends on your
site's reverse‑proxy trust settings. If `X-Forwarded-For` is trusted incorrectly, a
client can spoof an internal IP and satisfy the condition — so behind a proxy or CDN
you must configure Drupal's `reverse_proxy` settings correctly.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set your internal IP ranges and choose
   what to restrict.

## Where it lives in the admin menu

The central settings page is at **Configuration → System → Internal Network**
(`/admin/config/system/internal-network`). Block‑level use happens on each block's
visibility settings, and Twig use happens in your templates. See
[Configuration](configuration/index.md).
