# Audit — manual setup guide

**Audit** (`audit`) is a framework of tools for auditing and analysing a Drupal
site. Rather than doing one thing, it provides a base module plus a large set of
submodules, each covering a dimension of the site — security, SEO, performance,
database, entities, fields, views, modules, updates, code quality (PHPStan, PHPCS,
PHPUnit), Twig, images, internationalisation, complexity, duplication, watchdog
and more. An `audit_all` submodule aggregates the individual audits so you can run
everything at once.

Its job is to **read the site's state and produce reports** that guide reviews,
optimisation and cleanup — it analyses, it does not change anything. Think of it
as a governance / QA tool for developers and administrators: run the relevant
sub-audits, read the findings, act on them. Audit provides its own permissions and
its own **Drush commands**, so audits can run from the UI or the command line, and
it works on Drupal 10.2, 11 and 12.

One security note worth taking seriously: audit output — especially the security
and status dimensions — can reveal sensitive configuration and weaknesses in the
site. **Restrict who can see the audit reports** to trusted administrators, and
treat any exported findings as sensitive.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module, and pick the sub-audits you need.
2. [Configuration](configuration/index.md) — the settings form, the permissions to
   grant, and running audits from the UI or Drush.

## Where it lives in the admin menu

Audit's settings form is registered under **Configuration** (route
`audit.settings`); you can reach it from the module's **Configure** link on the
**Extend** (module list) page. The individual audit reports appear under Drupal's
**Reports** area once their submodules are enabled.
