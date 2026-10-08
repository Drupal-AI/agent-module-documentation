# Condition path — manual setup guide

**Condition path** (`condition_path`) adds one new visibility rule to Drupal —
a condition plugin called **Request Path Include Exclude**
(`request_path_inclexcl`) — that lets you *include and exclude* paths at the same
time in a single rule. Core's built‑in Request Path condition can only work one
way at a time: either a whitelist ("show only on these paths") or a blacklist
("show everywhere except these paths"). This module lets you mix both in one
textarea, so you can say "show on this whole section and its subpages, but hide
it on these specific child pages" without stacking two conditions.

It works anywhere Drupal exposes Conditions — most commonly the **Visibility**
settings when you place a block, but also Page Manager, Rules, and any other
consumer of the condition system. On block forms the module relabels the control
to **Pages (include and exclude)** and places it next to core's own Pages field,
so editors see a familiar, self‑explanatory option.

There is nothing to configure globally: the module has no settings page and no
permissions. You install it, and the new condition simply becomes available
wherever you set visibility rules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Condition path adds **no** menu items and **no** settings page. Instead, look for
its condition wherever you set visibility. The usual spot is **Structure → Block
layout**, then **Place block** (or **Configure** an existing block) → the
**Visibility** section, where it appears as **Pages (include and exclude)**.

## How to use it

Each line in the *Pages* textarea is one path pattern:

- A plain line is an **include** — for example `/news` or `/news/*`.
- A line that starts with `!` is an **exclude** — for example
  `!/news/*/comments`.
- `<front>` targets the front page (and `!<front>` excludes it).
- `*` is a wildcard, so `/news/*` matches everything under `/news`, and a single
  `*` means "all pages."
- Both the internal path and the URL alias are matched, and matching is
  case‑insensitive.

**Order matters.** The module groups consecutive include lines and consecutive
exclude lines, evaluates the groups top to bottom, and the **last group that
matches wins**. So put your broad rules first and your more specific exceptions
lower down. A worked example:

```
# Show on /news and all its subpages, but NOT on comment pages
/news
/news/*
!/news/*/comments
```

Every non‑empty line must be `<front>`/`!<front>` or start with `/`, `!/`, `*`,
or `!*` — the form will show a validation error otherwise. The standard
**Negate** checkbox that Drupal shows for every condition still applies and flips
the whole result. Leaving the textarea empty means "always visible."
