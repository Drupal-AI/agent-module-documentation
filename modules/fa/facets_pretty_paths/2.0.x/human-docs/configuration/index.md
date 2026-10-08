# Configuration

Facets Pretty Paths has no settings page of its own. You configure it in two
places inside the Facets admin area: on the **facet source** (to turn pretty paths
on) and on **each facet** (to choose how its values are encoded into the URL).

## Step 1 — Switch a facet source to pretty paths

A facet source picks one URL processor; the default is the query-string
processor. To use clean paths instead:

1. Log in as a user who can administer Facets.
2. Go to **Configuration → Search and metadata → Facets**
   (`/admin/config/search/facets`).
3. Open **Facet sources** and edit the source your facets belong to.
4. Set **URL Processor** to **Pretty paths** and save.
5. **Rebuild the cache** (`drush cr`). This is important: switching the processor
   registers a new catch-all route that lets the pretty-path segments resolve
   back to your search page, and that route only appears after a rebuild.

From now on, facets on that source produce URLs like `/brand/drupal/color/blue`
instead of `?f[0]=brand:drupal&f[1]=color:blue`. Non-facet parameters (keyword
search, sort, and so on) are preserved alongside the pretty path.

## Step 2 — Choose a coder for each facet

Once a source uses pretty paths, each facet's edit form gains a **Pretty paths
coder** option (it only appears when the source's processor is Pretty paths). The
coder decides how a raw facet value becomes a URL segment. The bundled choices
are:

- **Default coder** — uses the raw facet id as the segment. Best when the value
  is already a clean slug.
- **URL-encoded coder** — safely URL-encodes values that contain reserved or
  special characters.
- **Taxonomy term coder** — encodes a term as `term-name-ID`, e.g.
  `/color/blue-2`. Readable and unambiguous.
- **Taxonomy term name coder** — encodes a term as just `term-name`, e.g.
  `/color/blue`, when you don't want the ID in the URL.
- **Node title coder** — encodes a node reference as `node-title-ID`, e.g.
  `/author/jane-doe-7`.
- **List item coder** — encodes a list_string / list_integer value as
  `label-value`, e.g. `/size/large-3`.

Pick the coder per facet, save, and rebuild the cache if needed. When no coder is
chosen, the Default coder is used.

Term- and node-based coders localise their segments using the current-context
translation of the term or node title, and support hierarchical (parent/child)
taxonomy facets in the path.

## Facets rendered as Views exposed filters

If you expose facets as **Views exposed filters** (via the facets exposed-filters
submodule), you choose the coder on the filter's own configuration form instead of
the facet edit form. Selecting **None** there falls back to the default Views
query-string behaviour for that filter.

## Developers: custom coders

The coder mechanism is a plugin type (`@FacetsPrettyPathsCoder`). If none of the
bundled coders fit a bespoke facet, you can add your own coder plugin that
implements `encode()` / `decode()` — see the sibling
[`agent/`](../agent/plugins/coder.md) docs for the plugin details.
