<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# dkan_metastore — agent index

Submodule of **dkan** (project **dkan**). Stores dataset JSON metadata as Drupal content and exposes the metadata API. Version **4.1.2**.
Core `^10.2 || ^11`. Depends on: `dkan:dkan_common`.
Writes → `MetastoreAccessManager::canUpdate` (legacy perm `post put delete datasets through the api`, else entity access handler). Nested: `dkan_data_dictionary_widget`, `dkan_metastore_admin`, `dkan_metastore_facets`, `dkan_metastore_search`.

Part of the DKAN open-data portal pipeline. See [[dkan]] for the whole flow and the API access
model.