<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Condition Plugins — agent index

A **collection of extra Condition plugins** for Drupal's condition/visibility API. Version **2.0.x**.
Core `^8 || ^9 || ^10`. No dependencies, no routes, no own permissions.

Registers additional plugins with the condition plugin manager; they surface wherever conditions are
configured (block visibility, Context, etc.). Pure plugin-provider module — no untrusted input path, no
callbacks. Security surface is limited to the host UIs that consume conditions.
