# Beta Site — manual setup guide

**Beta Site** (`betasite`) gives you a way to run a "beta" version of pages
alongside your normal, published site. It adds a second, parallel set of URL
aliases — a *beta* namespace — so a page can have both its standard address and a
beta address, and it provides UI helpers that let a visitor switch between the two.

The typical use is to show testers a work-in-progress variant of some content or
section while everyone else keeps seeing the live version. Its optional toggle
submodule adds a block (and a small behind-the-scenes link endpoint) that flips a
visitor between the standard and the beta version of whatever page they are on.

Beta Site is really a small toolkit rather than a single feature: the base module
provides the beta-alias plumbing, and several optional submodules add the pieces
you actually place on the page — a toggle block, layout-builder support, and
breadcrumb/menu-trail helpers. Enable only the submodules you need. It supports
Drupal 9 and 10.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and pick the submodules you need.

## Where it lives in the admin menu

Once enabled, Beta Site's administration section sits at **Configuration →
Development → Beta Site** (`/admin/config/development/betasite`), reachable by
users with the **Access administration pages** permission.

## How to use it

1. Enable the base `betasite` module and whichever submodules you want (see
   [Installation](installation/index.md)).
2. If you enabled **Beta Site Toggle Block** (`betasite_toggle_block`), place its
   block in a region through **Structure → Block layout** so testers get a control
   to switch between the standard and beta version of the current page. Behind that
   control the submodule exposes a small `/beta-link` endpoint that, given a domain
   and path, returns the matching beta or standard alias — you do not call it
   directly; the toggle UI uses it.
3. Beta aliases are stored alongside your normal path aliases, so a page that has
   no beta alias simply resolves to its standard address — nothing breaks for
   content you have not prepared a beta version of.
