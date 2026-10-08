<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Lupus Decoupled Canvas (lupus_decoupled_canvas) — agent index

Submodule of **lupus_decoupled**. Theme configuration for **Canvas** editor routes and previews on
a decoupled site. Version **1.5.1**. Core `^10 || ^11`.

The mismatch it addresses: Canvas's editing experience runs inside Drupal while the site being
built runs elsewhere, so editor routes and previews need a theme that Drupal has and the decoupled
front end does not.

**Documented from source.** Canvas could not be kept enabled on the review install — its SDC
component discovery asserted and fataled the container build with third-party components present
(see `canvas_field_component`). Resolve that interaction before combining Canvas with this suite;
it is a development-environment failure (assertions compiled out in production) but it stops local
work dead.