# Behat UI — manual setup guide

**Behat UI** (`behat_ui`) lets you author and run
[Behat](https://behat.org/)/Mink functional tests from a web interface inside
Drupal. Behat/Mink drives browser-based tests — logging in as users, clicking
through pages, checking that the site behaves — and this module gives you a UI to
write and run those tests without dropping to the command line.

**Running tests is a powerful and sensitive capability, and this module should be
treated accordingly.** Tests can create content, log in as users, and exercise the
whole site, so the ability to run them must be restricted tightly to trusted
developers. Just as importantly, this belongs in **development or CI
environments, not production** — tests mutate data and consume resources, and
running them against a live site can damage real content. The safest posture is to
confirm the interface is admin/developer-gated and, ideally, to not enable this
module in production at all.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (in a dev/CI environment).

## Where it lives in the admin menu

Behat UI adds a developer-facing interface for authoring and running tests. Because
that interface can drive the whole site, make sure it is reachable only by trusted
developer/administrator roles, and check that gating on your site before relying on
it.

## How to use it

1. Enable the module **only in a development or CI environment** — not production
   (see [Installation](installation/index.md)).
2. Confirm the test-running interface is restricted to trusted
   developer/administrator roles.
3. Author Behat/Mink tests in the UI and run them there.
4. Keep the module disabled in production so tests can never run against live
   data.
