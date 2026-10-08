<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Lupus Decoupled Block (lupus_decoupled_block) — agent index

Submodule of **lupus_decoupled**. Exposes **block layout** to the front end.
Version **1.5.1**. Core `^10 || ^11`.

Keeps the block layer usable — otherwise every promo, notice and switcher becomes front-end code
and a site builder cannot place anything without a deployment.

**Two planning points:** visibility conditions are evaluated **in Drupal** (correct — a
role-restricted block should not be sent to a browser that shouldn't see it), so **responses vary
and caching must account for it**; and the front end needs an agreed **region mapping**, since
Drupal's region names are the theme's and the front end's layout is its own.