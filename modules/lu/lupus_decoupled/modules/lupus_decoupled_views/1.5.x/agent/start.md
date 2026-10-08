<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Lupus Decoupled Views (lupus_decoupled_views) — agent index

Submodule of **lupus_decoupled**. Views plugins rendering a **View as custom elements**.
Version **1.5.1**. Core `^10 || ^11`.

Keeps filters, sorts, contextual arguments, **access checks**, pagers and caching in Drupal — the
subset a front end reimplements is rarely the access checks. A site builder changing a View
changes the front end with no deployment.

**Plan the pager early**: how the front end requests the next page, and how that interacts with
front-end routing (infinite scroll vs paged URLs, and what a shared URL points at).