<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Solr Connector plugins

The module defines two `@SolrConnector` plugins (Search API Solr's plugin type) in
`src/Plugin/SolrConnector/`. Both self-populate connection settings from your opensolr account so the
only real choice on the form is **which core**.

## `opensolr` — `OpensolrSolrConnector`

Extends `StandardSolrConnector`. On `buildConfigurationForm()` it calls
`OpenSolrIndex::getIndexList()`; if the account/connection is invalid it shows an error linking to the
settings form. Otherwise it renders an **OpenSolr → Select your core** select (`opensolr[index]`) plus
the parent Standard form with the opensolr-managed fields hidden (`getOpenSolrConfigs()`). On validate,
`setOpenSolrDefaultValues()` loads the core (`getCoreInfo`) and fills the hidden connection fields from
the core's `connection_url`. `getServerInfo()` is overridden to call `CORE_NAME/admin/system` instead of
`admin/info/system` (opensolr access restriction).

## `basic_auth_opensolr` — `BasicAuthOpensolrSolrConnector` (recommended)

Extends `OpensolrSolrConnector` and mixes in Search API Solr's `BasicAuthTrait`. Adds Basic Auth to the
Standard behavior. Its form hides the auth username/password and **prefills** them from the opensolr
account (`getApiCredentials()` for the initial values; on validate it overrides them with the selected
core's `auth_username` / `auth_password` from `getCoreInfo()`). `viewSettings()` adds "Index Consumed
Disk" and "Index Consumed Monthly Traffic Bandwidth" rows from the core data, with an Upgrade link when a
quota is exceeded. This is the connector the Autoconfigure flow wires up.

## Selecting a connector

Choose the connector when adding/editing a Search API server (Solr backend → *Solr Connector*). Prefer
**"Opensolr with Basic Auth (recommended)"**. Programmatically, the server's `backend_config`
`connector` is `basic_auth_opensolr` (or `opensolr`) and `connector_config.opensolr.index` holds the
chosen core name (`getOpensolrCoreName()`).
