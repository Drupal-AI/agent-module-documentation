# Pages Restriction Access — manual setup guide

**Pages Restriction Access** (`pages_restriction`) protects pages that should
only be reached as part of a flow — a "thank you" page after a form, a "payment
complete" screen, a gated download landing page — from being deep-linked,
bookmarked, or stumbled upon directly. You give the module a list of
**restricted page → target page** pairs. When a visitor lands on a restricted
page, they're redirected to its target page instead, unless they're allowed
through.

There are two ways a visitor can be allowed through. First, you can nominate one
or more **bypass roles** whose logged-in users skip all restrictions — handy for
administrators, editors, or QA. Second, the module can grant a **one-time
session bypass**: when a user legitimately completes the preceding step (for
example, submits the form), your code marks that page as allowed for them once,
so they can view it — but a later direct visit is still redirected.

All of this is driven by one simple settings form and stored in a single,
deployable configuration object. The module enforces the rules with an early
request subscriber that runs on every page load, matching against the current
page's URL alias. It adds no permissions of its own (the settings form uses
core's **Administer site configuration**) and no Drush commands.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — define restricted/target page
   pairs, keep query parameters, and choose bypass roles.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Development → Pages
Restriction Access** (`/admin/config/development/pages-restriction/settings`).
