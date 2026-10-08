# Bundle name in tabs — manual setup guide

**Bundle name in tabs** (`bundle_tabs`) makes admin tabs clearer by adding the
bundle name to their titles. On admin listing and edit screens, the local-task
tabs (the row of tabs like *View / Edit / Manage fields*) normally read the same
whichever bundle you are working on. This module appends the bundle name — so a
tab reads, for example, *Manage fields (Article)* — which helps you tell tabs
apart when you move between multiple content types, vocabularies, or other
bundles.

It changes tab titles only. It does not touch content or access in any way and
has no access-control role. There is nothing to configure — the moment you enable
it, tab titles start including the bundle name. It has no dependencies beyond
Drupal core and runs on Drupal 8, 9, 10, and 11.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere in particular — the module has no settings page. Its effect shows up
across existing admin tabs, which now include the relevant bundle name in their
titles.

## How to use it

Just enable it. From then on, admin tab titles include the bundle name
automatically; there are no settings to adjust.
