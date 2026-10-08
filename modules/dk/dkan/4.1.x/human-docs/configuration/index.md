# Configuration

DKAN doesn't concentrate everything in one settings screen. Configuration means
three things: creating and managing **datasets**, tuning the **datastore**, and
deciding who can reach the **API**. This page walks through each.

## The dataset workflow

A DKAN portal is a catalog of **datasets**, each carrying structured JSON metadata
and one or more downloadable resources (a CSV, for example).

1. Create a dataset through the admin UI (provided by **dkan_metastore_admin**).
   DKAN generates the metadata form from a JSON schema using the JSON Form Widget,
   so you fill in fields like title, description, publisher, license, keywords and
   the distribution (resource) files.
2. Attach the resource file(s) to the dataset's distribution. If the **datastore**
   submodule is enabled, a tabular resource can be imported into a queryable table.
3. Publish the dataset. Once published, its metadata is served through the
   metadata API and, if imported, its data is queryable through the datastore API.

Because the forms are schema‑driven, the exact fields you see depend on the schema
your site uses. The default DKAN schema follows the DCAT‑style open‑data metadata
conventions.

## Datastore settings

The datastore turns an uploaded CSV into a database table you can query over HTTP.
Its settings live at **`/admin/dkan/datastore`**. The setting you're most likely
to touch is the **rows limit** — the maximum number of rows a single datastore
query can return, which defaults to **500**. Raise it if your datasets are larger
and you need more rows per request, but be mindful that setting it too high can
cause timeouts or memory pressure.

To import a resource into the datastore, enable the **dkan_datastore** submodule
(it is not enabled automatically), then trigger the import for the dataset's
resource — from the admin UI or via the datastore API.

## Harvesting external catalogs

If you enabled **dkan_harvest**, you can register *harvest plans* that point at
other data portals and pull their catalogs into your site on a schedule, keeping
your portal in sync with external sources. Harvest operations are driven through
the harvest API and gated by harvest permissions (see below).

## The API and its permission model

This is the part to configure deliberately. DKAN exposes both a metadata API and a
datastore query API, and it gates them with **granular, per‑purpose permissions**
rather than one blanket administrator grant. Assign each API client (human or
automated) exactly the verbs it needs, on the standard **People → Permissions**
page:

| Permission | Grants the ability to |
|------------|-----------------------|
| `datastore_api_import` | Import a resource into the datastore. |
| `datastore_api_drop` | Drop a datastore table. |
| `harvest_api_run` | Run a registered harvest plan. |
| `harvest_api_register` | Register a new harvest plan. |
| `post put delete datasets through the api` | The legacy blanket write permission for datasets via the API. |

Metadata writes additionally pass through DKAN's access manager, which defers to
Drupal's entity access‑control handler — so ordinary content permissions still
apply on top of the API permissions.

**Read access is public by default.** DKAN's read endpoints use core's `access
content` permission, which anonymous users hold in a standard install, so the
catalog and datastore are readable by anyone unless you change that. For an
open‑data portal that's usually the whole point — but treat it as a conscious
decision, especially if any datasets are drafts or otherwise not meant to be
public.

## A note on scale

Because DKAN is a large, infrastructural platform, changes here ripple across the
whole portal. Make configuration changes in a non‑production environment first,
export them to config, and deploy them like any other Drupal configuration.
