# Search API AZ Glossary — manual setup guide

**Search API AZ Glossary** (`search_api_glossary`) adds an A–Z "glossary" facet
to a Search API index — the familiar `A B C … Z` alphabet bar that lets visitors
jump to everything whose title (or username, or any other text) starts with a
given letter. It works by deriving a hidden "first letter" value from a field you
choose, then rendering that value as a Facets widget.

Under the hood there are two moving parts. A **Search API processor** (called
"Glossary processor") looks at each source field you mark as a glossary field and
exposes a computed field named `glossaryaz_<field>` whose value is the uppercased
first letter — or a group label — of the source value. Letters are grouped into
three buckets you can rename: alphabetic characters map to the `alpha` label
(default "A-Z"), digits to `numeric` (default "0-9"), and everything else to
`special` (default "#"). On the display side, the module ships a **Facets widget**
("Glossary AZ") plus three helper facet processors that can show every letter even
when some have no results, pad in any missing letters, and keep the bar in strict
A–Z order.

The module has **no settings form of its own** — you configure it entirely by
enabling the processor on your index and building a facet on the resulting
`glossaryaz_*` field. It works with any Search API backend (the database server,
Solr, Elasticsearch) and plugs into Views, Search API Pages and Facets. It depends
on the **Search API** and **Facets** modules.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, pull
   in Search API and Facets, and enable everything.

## How to use it

There is no configuration page — the glossary is assembled from Search API and
Facets screens you already know. The end-to-end flow is:

1. **Enable the Glossary processor on your index.** Edit your Search API index
   (**Configuration → Search and metadata → Search API**), open the
   **Processors** tab, tick **Glossary processor**, and save. In the processor's
   settings choose which source field(s) should become glossary fields (for
   example a node **Title** or a **Name (username)** field).
2. **Index your content.** Each glossary-enabled field now has a companion
   computed field named `glossaryaz_<field>` holding the first-letter/group value.
   Run indexing so those values are populated.
3. **Build the facet.** Add a new facet (**Configuration → Search and metadata →
   Facets**) on the `glossaryaz_<field>` field, and pick the **Glossary AZ**
   widget. Place the facet block in a region, or use it on your Views/Search API
   Pages search display.
4. **(Optional) tidy the bar.** Turn on the facet's helper processors to show the
   full A–Z even when letters are empty, pad in missing letters, and sort the
   items strictly A–Z.

To rename the group labels — say, to translate "A-Z" or change "#" — edit the
`group_prefix` values in the `search_api_glossary.settings` config object (via a
config override or `drush cset`); there is no UI for it. Developers can also reuse
the `search_api_glossary.helper` service (`GlossaryHelper::glossaryGetter()`) to
compute a first-letter/group value in custom code, and normalise accented first
letters (À→A) with the `hook_search_api_glossary_source_alter()` hook.

## Where it lives in the admin menu

The module adds no menu item of its own. You work with it on the **Search API**
index screens (Processors tab) and the **Facets** screens, both under
**Configuration → Search and metadata**.
