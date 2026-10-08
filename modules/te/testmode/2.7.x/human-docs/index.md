# Testmode — manual setup guide

**Testmode** (`testmode`) alters existing site content and configuration while
automated tests are running, so that tests see predictable, controlled
conditions instead of being confused by whatever real content happens to be on
the site. It is a development and testing aid, not a feature you ship to
visitors.

The problem it solves is false positives in behavioural tests. Imagine a view
that lists three featured articles and a test that creates three of its own
featured articles and checks the list. If the live site already has featured
articles, the test's items get mixed in with the real ones and the assertion
fails for reasons that have nothing to do with the code under test. Testmode's
approach is that test content follows a naming pattern (for example node titles
that start with `[TEST]`), you register the machine name of the view you want to
test on the settings form, and a test tagged `@testmode` puts the site into test
mode — which filters that view down to only the items matching the test pattern,
leaving the test's own content and nothing else.

Testmode has no dependencies beyond Drupal core (it runs on Drupal 10 and 11),
adds no permissions, and ships no submodules. It does nothing until a test
activates it, but it does expose a settings form so you can tell it which views
and patterns to work with.

**Important caveat:** because Testmode is designed to *change content and
configuration* when it is active, it should stay scoped to your test and CI
environments. If it were ever active on a live site it could alter what visitors
see or how the site behaves. Keep it out of production, or at least make sure it
is never switched on there.

This guide is written for a **human** setting the module up through the admin
UI. If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it in your test/CI environment.
2. [Configuration](configuration/index.md) — the settings form where you tell
   Testmode which views and patterns to filter.

## Where it lives in the admin menu

Once enabled, Testmode's settings form is reached through its configuration
route `testmode.admin_settings`. From there you register the views and content
patterns that test mode should act on.
