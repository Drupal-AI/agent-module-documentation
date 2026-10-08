# Server-side A/B Testing — manual setup guide

**Server-side A/B Testing** (`server_side_ab_testing`) is a lightweight framework
for running A/B experiments directly inside Drupal, without relying on an external
SaaS platform. Its defining feature is that it chooses which content variant a
visitor sees **on the server, before the HTML is delivered** — which avoids the
flicker and layout shifts that client-side (JavaScript) A/B tests are prone to,
and gives you stronger control over performance, caching, and SEO.

Experiments are built out of ordinary Drupal nodes. Each experiment has an
explicit model: a **Main Page** (the entry-point URL that triggers the
experiment), a **Control Page** (the baseline version), and one or more
**Alternative Variants** (additional nodes, each with a weight that controls how
often it is shown). When a visitor requests the Main Page, the module works out
whether it belongs to an active experiment, assigns the visitor to the control or
one of the variants, and serves that node transparently — attaching experiment
metadata for analytics and cache variation as it goes.

Assignments are **sticky**, so a visitor stays in the same variant for the
duration of the experiment: anonymous visitors are tracked with a long-lived
cookie persisted in the database, authenticated users by their user ID, and an
anonymous visitor's assignment is migrated to their account automatically when
they log in. The framework is cache-aware (it integrates with Drupal cache
contexts), SEO-safe (canonical handling and redirects help avoid duplicate-content
problems), and it exposes experiment data to **GA4 / Google Tag Manager** through
`drupalSettings` and analytics events. Experiments can be Active, Paused, Draft, or
Finished, which controls whether assignment and variant-redirect logic apply.

Experiments are managed as Drupal entities through the admin UI, so there is setup
to do before anything runs — you create experiments and wire up their control and
variant nodes. The module depends on core's **Node** and **User** modules and runs
on Drupal 10 and 11. It ships several permissions (for administering experiments,
settings, resetting, previewing variants, and a `bypass server-side ab testing`
permission), and you should restrict the administration and bypass permissions to
trusted roles.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Node and User.
2. [Configuration](configuration/index.md) — build an experiment, set the control
   and variants, and manage its status and permissions.

## How to use it

Once you have created an experiment and set it Active, visitors to its Main Page
are transparently assigned to the control or a variant and served that content,
with their assignment kept stable across visits. Experiment data flows into GA4 /
GTM so you can measure how each variant performs, and the whole assignment happens
server-side so page caching keeps working.
