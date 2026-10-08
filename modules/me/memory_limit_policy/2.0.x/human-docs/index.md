# Memory Limit Policy — manual setup guide

**Memory Limit Policy** (`memory_limit_policy`) lets you raise (or lower) PHP's
`memory_limit` for *specific* requests instead of bumping it globally in
`php.ini`. You define **policies** through an admin UI; each policy names a target
memory value (like `256M`, `512M` or `1G`) and a set of **constraints** describing
which requests it applies to. On every request the module checks your policies,
and when a request matches all of a policy's constraints it applies that policy's
memory value with PHP's `ini_set()`.

The everyday use case is stopping "Allowed memory size exhausted" fatals on a
narrow slice of the site — a heavy admin report, a node edit form packed with
media, a bulk operation, a specific API endpoint — without over-provisioning
PHP-FPM for every worker and every anonymous page view. You can scope a policy by
role, path, route, HTTP method, HTTP header, query parameter, domain, environment
variable, or Drush command; combine several constraints so a policy is very
targeted; and negate a constraint to mean "everywhere except." Because policies are
configuration, you keep memory tuning in your site's tracked config and deploy it
across environments, rather than juggling server-managed ini files.

An important design point: **the base module ships no constraint types on its own.**
The actual conditions come from **submodules** (role, path, route, HTTP method, and
so on), so you must enable at least one of them before a policy can match anything.
This guide is written for a **human** clicking through the admin UI; if you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead. The module depends on Drupal core only,
provides a permission, and includes ten optional submodules.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   (crucially) enable the constraint submodules you need.
2. [Configuration](configuration/index.md) — the policy UI: creating policies,
   memory value, weight and order, constraints and negation, the permission, and
   the debug-headers toggle.

## Where it lives in the admin menu

The policy manager lives under **Configuration**, at
`/admin/config/performance/memory-limit-policy/list`, and its settings form is at
`/admin/config/performance/memory-limit-policy/settings`. Access is controlled by
the **Administer memory limit policies** (`administer memory limit policies`)
permission.

## How it works, in short

Each policy has a memory value, a **weight** (evaluation order), an on/off
**status**, and an ordered list of **constraints**. A policy applies only when
**all** its constraints pass (logical AND), and any constraint can be individually
negated. Policies are evaluated in weight order, and — this is the key rule — the
**last** matching policy wins, so a broad low-limit policy can be superseded by a
more targeted high-limit one by giving the targeted one a higher weight. See
[Configuration](configuration/index.md) for the full walkthrough.
