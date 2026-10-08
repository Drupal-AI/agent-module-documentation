<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Lupus Decoupled Site Info (lupus_decoupled_site_info) — agent index

Submodule of **lupus_decoupled**. Exposes **basic site information** (name, slogan, front page,
language) to the front end. Version **1.5.1**. Core `^10 || ^11`.

Removes two sources of truth and the deployment needed to change a site name.

**Plan caching**: needed on every render, changes rarely — fetch once and cache in the front end
with sensible invalidation, not per page.