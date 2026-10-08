# Flexible Access — manual setup guide

**Flexible Access** (`flexible_access`) is an **access-control** framework. It lets
site administrators define configurable *access rules* that decide who may view or
edit entities, layered on top of Drupal's normal entity-access system — so you can
implement custom access policies without writing code.

The most important thing to understand before you use it is the *direction* in
which it works. Flexible Access **grants** access: its rules return results that
can **allow** access that core would otherwise leave denied (neutral). That makes
it powerful, but it also means a rule that is too broad or misconfigured can
**expose content** to people who should not see it. A `forbidden` result from any
access handler still wins — so Flexible Access cannot override an explicit deny —
but it *can* widen visibility beyond what you intended, which is especially risky
for unpublished or private content.

Treat rule-building as a security task. Write rules narrowly, test each one
against every role (including the anonymous user), and verify they do not
over-grant. Flexible Access composes with core entity access and with any other
access modules you run, so always confirm the *combined* result, not just what one
rule does in isolation.

Note this release is an early one (**1.0.0-beta2**) and is *not* covered by
Drupal's security advisory policy — a further reason to test carefully before
relying on it for anything sensitive.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the access-rule model, the
   permissions it provides, and how to configure rules safely.

## Where it lives in the admin menu

Flexible Access provides its own permissions (assign them under **People →
Permissions**) and an admin area for managing its access rules. Because it changes
who can reach content, plan to review its effect on the site's real roles right
after you configure it.
