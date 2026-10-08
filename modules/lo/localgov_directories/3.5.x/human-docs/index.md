# LocalGov Directories — manual setup guide

**LocalGov Directories** (`localgov_directories`) builds searchable,
facet-filtered directories for [LocalGov Drupal](https://localgovdrupal.org/)
sites — think a council's A–Z of services, a directory of community venues on a
map, or a list of local organisations that visitors can filter and search. It is
part of the LocalGov Drupal distribution but works on any Drupal 10.2+/11 site
that has its dependencies.

The module is built from three pieces that work together. A **channel** is a
special `localgov_directory` node that defines which kinds of entries it accepts
and which filters (facets) are available on it. **Entries** are ordinary nodes —
the submodules ship ready-made entry types (page, venue, organisation, promo
page), but you can turn any content type into a directory entry. **Facets** are
the categories visitors filter by (for example a "Size" facet with values
"Large" and "Small"); crucially, editors create and manage facet values in the
admin UI without needing a developer, which is why those values are treated as
content rather than exported configuration.

Everything is served through a Search API index and the Facets module, both of
which the module wires up for you: it ships a channel view with a plain list, a
proximity ("near me") search, and a Leaflet map, plus a channel search block and
the facet blocks for the sidebar. Because of that, it has a fairly large set of
dependencies — see [Installation](installation/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   dependencies with Composer, and enable a search backend plus at least one
   entry type.
2. [Configuration](configuration/index.md) — create facet types and values,
   build a channel, add entries, index them, and place the blocks.

## Where it lives in the admin menu

- **Facet types** (site-builder config) are managed at
  **Configuration → Directory Facets types**
  (`entity.localgov_directories_facets_type.collection`).
- **Facet values** (editorial content) live at **Content → Directories → Facets**
  (`/admin/content/directories/facets`).
- **Channels** and **entries** are created like any other content under
  **Content → Add content**.
- **Blocks** (channel search, facets, proximity search) are placed at
  **Structure → Block layout**.

## How to use it

The high-level workflow, covered step by step in
[Configuration](configuration/index.md):

1. Create one or more **facet types** and their **values**.
2. Create a **channel** node and choose which entry types and facet types it
   allows.
3. Create **entries** and assign them to the channel, picking their facet values.
4. Build the **Search API index** so entries appear.
5. Place the **facet** and **search** blocks in the channel's sidebar.
