# Dependent Country, State and City — manual setup guide

**Dependent Country, State and City** (`dependent_country_state`) gives your site a
managed dataset of countries, states, cities and pincodes, together with the JSON
endpoints you need to build cascading location selects — pick a country and the
state list narrows, pick a state and the city list narrows, and so on. The data
lives in its own custom database tables (not in Drupal's entity system), which the
module creates and seeds with defaults the moment you enable it.

Out of the box the module ships a full set of countries and all Indian states.
Cities and pincodes start empty so you can add exactly what your site needs. You
manage every level — countries, states, cities and pincodes — through admin CRUD
forms, and there are bulk-import forms for loading states, cities and pincodes in
one go. When you uninstall the module, its four custom tables are dropped again.

The other half of the module is a small read-only JSON API. Each level has an
endpoint (for example `/admin/city-state-city/api/get-country`,
`.../get-state/{id}`, `.../get-city/{id}`, `.../get-areapincode/{id}`) that returns
the matching records, optionally filtered by an `id` or a name query argument.
These are the endpoints your front-end JavaScript calls to populate dependent
dropdowns as the user makes selections. Every endpoint is gated by its own
dedicated permission, so nothing is exposed anonymously unless you grant it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (which creates and seeds its data tables).

There is **no settings form** for this module, so there is no separate
Configuration page. You work with it entirely through its data-management forms
and permissions, described below.

## Where it lives in the admin menu

Once enabled, the data-management screens sit under **Configuration → Country,
state and city**, where you'll find separate lists for countries, states, cities
and pincodes, each with add/edit/delete and bulk-import options. All of these
require the **`dependent country state administrator`** permission (a restricted
permission — grant it only to trusted roles).

## How to use it

1. **Enable the module.** The install step creates the `dependent_country`,
   `dependent_state`, `dependent_city` and `dependent_pincode` tables and seeds
   the default countries and Indian states.
2. **Fill in your data.** Under **Configuration → Country, state and city**, add
   the cities and pincodes you need (cities and pincodes ship empty), and adjust
   countries/states as required. Use the bulk-import forms to load large lists at
   once.
3. **Grant the API permissions.** Each endpoint has its own restricted
   permission — `country api access`, `state api access`, `city api access` and
   `areapincode api access`. Grant only the ones your integration actually calls,
   and only to the roles or service accounts that need them.
4. **Call the endpoints from your form JavaScript.** As the user chooses a
   country, call the state endpoint for that country's id; as they choose a state,
   call the city endpoint, and so on. Each endpoint accepts an optional filter —
   `id`, `country_name`, `state_name`, `city_name` or `pincode_area` — and returns
   only rows with `status = 1`. Filter values are applied through Drupal's
   database API with placeholders, so they are safe from SQL injection.

> **A note on the endpoint paths:** although the API URLs live under
> `/admin/...`, access is controlled entirely by the dedicated `* api access`
> permissions above — so be deliberate about which roles you grant them to.
