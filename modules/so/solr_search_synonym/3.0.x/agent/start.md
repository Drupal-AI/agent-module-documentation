<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SOLR Search Synonym — agent index

Manages **search synonyms** in Drupal and **exports them to Solr** (equivalent terms → better recall).
Depends on core `system` (>=11), `options`, `views`, `search_api`, `search_api_solr`. Config via the
synonym collection; provides permissions. Version **3.0.2**. Core `^11`.

Search/index-layer feature — shapes matching, not access (respects index + entity access).
