<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# dkan_datastore — agent index

Submodule of **dkan** (project **dkan**). Imports tabular dataset resources into a queryable datastore and exposes the datastore API. Version **4.1.2**.
Core `^10.2 || ^11`. Depends on: `dkan:dkan_metastore`, `dkan:dkan_common`.
Nested submodule `dkan_datastore_mysql_import` — MySQL-native fast import. Permissions: `datastore_api_import`, `datastore_api_drop`.

Part of the DKAN open-data portal pipeline. See [[dkan]] for the whole flow and the API access
model.