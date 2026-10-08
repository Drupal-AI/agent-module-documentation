# Configuration

Contacts is configured in three places: the **permissions** you grant to CRM roles,
the **dashboard** (tabs and blocks) you arrange, and a small **basic settings**
form. There is no single wizard — you set it up piece by piece.

## Grant the permissions

Under **People → Permissions**, decide which roles get each CRM capability:

- **`view contacts`** — see the dashboard and open any contact. Note this is
  **CRM‑wide**: a holder can view *every* contact, not just their own. That is by
  design for a back‑office CRM — do not treat it as a per‑record restriction.
- **`add contacts`** — use the "add individual" and "add organisation" forms.
- **`manage contacts dashboard`** — enter manage mode and rearrange dashboard tabs
  and blocks.
- **`administer contacts`** — full configuration; this one is marked *restrict
  access* (grant it only to trusted administrators).

The configuration routes reuse two core permissions — **Administer blocks** and
**Administer account settings** — so administrators who tune the dashboard layout or
the basic settings form need those as well.

## The dashboard

- **`/admin/contacts`** — the main dashboard. It redirects to whichever default view
  you configure (individuals, organisations, or all).
- **`/admin/contacts/{user}/{subpage}`** — a single contact's tabbed detail view.
- **`/admin/contacts/add/indiv`** and **`/admin/contacts/add/org`** — add a new
  individual or organisation contact.

Listing, filtering (facets), and duplicate detection all run off the
`contacts_index` Search API database index. If results look stale or missing after a
bulk change, re‑index with `drush search-api:index contacts_index`.

## Tabs and blocks (manage mode)

The dashboard's tabs are configurable **`contact_tab` config entities**, and each
tab's content is built from **layout blocks** (summary, duplicates, back‑link, and
more). With the **`manage contacts dashboard`** permission you can enter *manage
mode* and add or move blocks through an off‑canvas chooser; the arrangement is
stored per tab. This is how you tailor what each contact page shows without writing
code.

## Basic settings form

The **`contacts.basic_config`** form lives at **`/admin/config/contacts`** (it uses
the core **Administer account settings** permission). This is where the high‑level
Contacts options live — for example choosing the default dashboard landing view.

## Submodule configuration

Each enabled submodule brings its own configuration surface — for example
`contacts_user_dashboard` adds an **`access user dashboards`** permission for the
front‑end `/user/{user}/summary` page, and `contacts_log`, `contacts_group`,
`contacts_dbs`, and `contacts_mapping` add their own settings and permissions. Turn
on only the submodules you need (see [Installation](../installation/index.md)) and
configure each in turn.
