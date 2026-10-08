# Seeds Administration — manual setup guide

**Seeds Administration** (`seeds_administration`) is a convenience "starter" module for
the **Seeds** distribution. Setting up a pleasant Drupal back-end usually means
enabling several separate modules — an admin toolbar, admin-theme helpers, content
tools, and so on. Seeds Administration bundles that work into a single opinionated
package: enable it, and it brings in a curated stack of administration modules so your
site starts from a sensible admin baseline instead of a bare install.

Think of it as an aggregator rather than a feature in its own right. It adds
functionality, not risk — but because it is opinionated, the sensible step after
enabling it is to **review which modules it pulled in** and confirm their configuration
suits your site. It is designed for the Seeds distribution, but it works just as well
as a curated admin starter on a non-Seeds site, provided you do that review.

There is nothing to configure in Seeds Administration itself — it has no settings form.
Any tuning you do afterwards happens in the individual modules it enabled, through their
own admin screens.

This guide is written for a **human** installing the module. If you are an AI coding
agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module to pull in the curated admin stack.

## How to use it

Enable the module and let it bring in its administration stack. Then visit
**Extend** (`/admin/modules`) to see exactly which modules are now enabled, and step
through their respective configuration pages to confirm the defaults match what you
want. Because it is a bundle, treat the first run as a review exercise rather than a
one-and-done install.
