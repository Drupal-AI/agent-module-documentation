# Semantic versioning example — manual setup guide

**Semantic versioning example** (`semver_example`) is a deliberately empty module.
It ships no features, no settings, and no UI — it exists purely as a demonstration
and testing artifact for Drupal.org's handling of semantic version numbers and
release naming. Maintainers and the Drupal.org packaging infrastructure use it to
exercise how different release version strings are produced and consumed.

In the module's own words, it "does nothing, and does it very well." It is
explicitly **not for use on real sites** — there is no reason to install it on a
production site, and its maintenance status is *Unsupported*. It runs on Drupal 8
and later, and is not covered by Drupal's security advisory policy.

This guide is written for a **human**. If you want a terse, token‑cheap reference
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — how to install and enable it, if you
   need it for testing.

## How to use it

There is nothing to use. Once enabled, the module simply appears in the list of
installed modules. Its only real "output" is its release version number, which is
the whole point of the project — it lets people study how a given `semver`‑style
version behaves on Drupal.org. There is no configuration, no admin page, and no
behavior on your site.
