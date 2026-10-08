# Open Y Socrates — manual setup guide

**Open Y Socrates** (`openy_socrates`) is a **facade / middleware service** that
lets the many modules in an Open Y (YMCA Website Services) site talk to each other
without depending on each other directly. It is an implementation of the classic
*strategy pattern*: a module asks Socrates for the data it needs, and Socrates
knows which module answers — choosing the highest-priority provider when several
are available.

A distribution the size of Open Y has dozens of modules that need each other's
data: a schedule needs locations, a landing page needs programme information, a
search needs both. Wiring those together with direct dependencies produces a
dependency graph nobody can change, where removing one module breaks five. A facade
breaks that knot. Consumers depend on the **facade**, not on the provider — so a
provider can be swapped out, and a site that does not install a particular provider
degrades gracefully rather than fatally erroring.

This is an **architectural** module, not a feature you configure and see. Its value
is to someone working *inside* Open Y: reading it is the fastest way to understand
how the distribution is assembled, and implementing against it is how a custom
module joins the ecosystem without hard-wiring itself to a specific set of Open Y
modules. On a site that is not Open Y it has nothing to do — if you find it enabled
there, it arrived as a dependency of something else in the family.

(The name is a gentle joke about a middleware that answers questions — worth
recognising as such rather than hunting for a feature it does not have.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

This module has **no settings form** — there is nothing to configure through the
UI. It is consumed by code, described in "How to use it" below.

## Where it lives in the admin menu

Open Y Socrates adds no configuration page. It registers a `socrates` service that
other modules call in code; there is no admin screen to visit.

## How to use it

This section is for developers extending an Open Y site.

- **Ask the facade for data:** in code, call the `socrates` service — for example
  `\Drupal::service('socrates')->someMethod()` — instead of depending on a specific
  provider module.
- **Register a data provider:** implement `OpenyDataServiceInterface` on your
  service class and tag it in your module's `*.services.yml` with
  `{ name: openy_data_service, priority: 1000 }`. The highest-priority tagged
  service wins when Socrates resolves a request.
- **Register a cron provider:** implement `OpenyCronServiceInterface` and tag your
  service with `openy_cron_service` and a `periodicity` (in seconds), then add a
  crontab entry that runs
  `drush ev '\Drupal::service("socrates")->cron();'` on your chosen interval.

The point throughout is that consumers depend on the Socrates facade, keeping the
distribution's modules loosely coupled and individually replaceable.
