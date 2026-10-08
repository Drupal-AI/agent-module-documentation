<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Lunr — agent index

Integrates Drupal with **Lunr.js** for **client-side (in-browser) search** (a JSON index the browser loads —
static/Tome/JAMstack sites, no live backend). `lunr_facet_example` submodule; provides permissions. Version
**8.x-1.7**. Core `^8||^9||^10||^11`.

**SECURITY CAVEAT:** the search index is **public + client-side** (served whole to the browser, no
server-side access check at search) — **only index PUBLIC content** (exclude unpublished/restricted content
and non-public fields). No access role.
