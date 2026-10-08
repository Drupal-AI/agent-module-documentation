<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Lupus Decoupled Layout Builder (lupus_decoupled_layout_builder) — agent index

Submodule of **lupus_decoupled**. Base setup for **Layout Builder** output through the
custom-elements pipeline. Version **1.5.1**. Core `^10 || ^11`.

The capability a naive decoupled build loses first — layout is data in Drupal, rendering is
Drupal's, and a front end fetching entity fields sees none of it.

**Settle the component contract early**: which Drupal layouts map to which front-end components,
and what happens when an editor uses one the front end has not implemented. Without that, editors
compose pages that render as unstyled elements.