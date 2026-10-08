# Configuration

DCAT's configuration has two parts: the admin area where you tune the catalog and
enforce field defaults, and the permissions that decide who can create, view, and
export catalog records. There are no free-text settings to memorise — most of your
time will be spent granting permissions and (optionally) creating your first
records.

## Open the DCAT admin area

1. Log in as a user with the **Access DCAT admin pages** permission.
2. Go to **Structure → DCAT**, or navigate directly to `/admin/structure/dcat`.

From the admin area you'll find:

- **Overview** (`/admin/structure/dcat`) — the landing page for DCAT administration.
- **Settings** (`/admin/structure/dcat/settings`) — module-wide settings. If the
  **DCAT Export** submodule is enabled, its export settings live here too (at
  `/admin/structure/dcat/settings/dcat_export`, behind the *Administer DCAT export*
  permission).
- **Types** (`/admin/structure/dcat/types`) — per-entity-type settings for Dataset,
  Distribution, Agent, and vCard.
- **Field defaults** (`/admin/structure/dcat/field-defaults`) — define enforced
  default (and locked) field values that apply across your catalog. Requires the
  *Administer DCAT field defaults* permission.

## Set permissions

DCAT's access model is permission-based and granular, per entity type (Dataset,
Distribution, Agent, vCard). At **People → Permissions**
(`/admin/people/permissions`), grant the appropriate roles:

- **Add / Edit / Delete `<type>` entities** — create and manage records of each
  type.
- **Administer `<type>` entities** — full access to that type (a restricted,
  trusted-role permission; it grants access regardless of published state).
- **View published `<type>` entities** — see published records.
- **View unpublished `<type>` entities** — see unpublished records (reserve this for
  trusted roles).
- **Access `<type>` overview** — see the admin list of that type.
- **Access DCAT admin pages** — reach the `/admin/structure/dcat` area.
- **Administer DCAT field defaults** — manage the field-default rules.
- **Access DCAT export feed** / **Administer DCAT export** (DCAT Export submodule) —
  view the `/dcat` RDF feed, and manage its settings.

The access-control handler grants full access on *administer `<type>` entities`;
otherwise it checks the published-state-appropriate view permission.

## Build your catalog

Once permissions are set, the typical workflow is:

1. Create **Agent** records (publishing organisations) and **vCard** contact points
   from the Content area.
2. Create **Dataset** records, attaching one or more **Distributions** (files,
   services, or URLs) and referencing the Agent and vCard.
3. Tag datasets with the `dataset_keyword` and `dataset_theme` vocabularies.
4. Optionally enforce consistency across records using **Field defaults**.

## Publish the RDF feed (optional)

If you enabled **DCAT Export**, your entities are serialised to an RDF feed at
`/dcat`. Grant the *Access DCAT export feed* permission to whoever (or whatever
system) needs to read it, and adjust the export settings under the DCAT settings
area. Other modules can enrich the exported graph via events, which is exactly how
the DCAT-AP and DCAT-BE profiles extend the output.
