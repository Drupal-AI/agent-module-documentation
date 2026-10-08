# Custom Filter — manual setup guide

**Custom Filter** (`customfilter`) lets a trusted administrator define their own
**text‑format filters** through the admin UI — regular‑expression search‑and‑replace
rules, optionally running PHP replacement code — without writing a custom module. Once
you've defined a filter, it becomes selectable on any text format (Basic HTML, Full
HTML, and so on), just like core's built‑in filters.

Typical uses: wrap bare URLs in links, turn shortcodes or `[tokens]` into markup,
auto‑link `#hashtags`, replace banned words, add `rel="nofollow"` to outbound links,
or rewrite legacy inline markup. Each filter is a container made of ordered **rules**;
each rule has a regex **pattern**, a **replacement**, and a flag that decides whether
the replacement is plain text (with `$1`‑style backreferences) or PHP code. Rules can
even nest into **subrules** that reprocess a captured piece of a parent match.

> **Important trust note.** A filter author is trusted exactly like an admin who can
> create a PHP or Full‑HTML text format. Non‑code rules insert their replacement into
> content **verbatim** (raw HTML), and code rules run arbitrary **PHP** on the server.
> The single **Administer customfilter** permission that gates all of this is
> therefore effectively a code‑execution / raw‑HTML permission — grant it only to
> fully trusted administrators. This is by design, not a vulnerability.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — create filters, rules, and subrules, and
   enable a filter on a text format.

## Where it lives in the admin menu

Manage your filters at **Configuration → Content authoring → Custom Filter**
(`/admin/config/content/customfilter`), gated by the **Administer customfilter**
permission. A filter you define only starts affecting content once a text‑format admin
turns it on for a specific format at **Configuration → Content authoring → Text
formats and editors** (`/admin/config/content/formats`).
