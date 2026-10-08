# Content Model Documentation — manual setup guide

**Content Model Documentation** (`content_model_documentation`) turns a Drupal
site's architecture into documented, browsable content. Most architecture
documentation is a wiki page that was accurate once and drifted ever since. This
module keeps two halves together instead: a **generated** view of what the site
actually is — its bundles, fields, view modes, and relationships, read live from
the running site — and an **authored** record of *why* each part exists, captured
in a `cm_document` content entity (one per documented element). Introspection can
tell you a field exists; only a person can record what it was for or what a
migration decided, and that rationale is what this module preserves.

On the generated side it produces reports and listings: an enabled-modules report
with links to each project's page and help, node- and vocabulary-count reports, a
site-wide field search, a filterable fields listing, and **Mermaid diagrams** of
workflow states/transitions and of entity relationships. On the authored side, you
create Content Model Documents to attach notes (and diagrams) to content types,
fields, modules, and other elements. Documents can be exported to YAML with Drush
and imported via update hooks, so your documentation can ride along with code
changes.

Two things are worth knowing before you commit. First, permissions are granular:
separate permissions govern administering settings, viewing the reports, and
creating or administering the document entities, and the document routes use
proper per-entity access checks. Second, this is a **heavy dependency footprint for
a documentation tool** — six modules, four of them contrib: Better Exposed Filters,
Config Views, Mermaid Diagram Field, and Views Data Export, plus core Views and
Path Alias. Config Views is the load-bearing one; it's what exposes configuration
entities to Views so the model can be listed at all. The module is aimed at
agencies doing client handovers and teams maintaining a large model over years.
Core requirement is `^10 || ^11`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer along with its
   four contrib dependencies, and enable the module.
2. [Configuration](configuration/index.md) — choose which entity types are
   documentable and set the module used for YAML exports.

## Where it lives in the admin menu

- **Settings:** `/admin/config/system/content_model_documentation` — control which
  entity types can be documented and where exports are saved.
- **Content Model Documents:** `/admin/structure/cm_document` — the list of authored
  documents (itself an editable View).
- **Content Model Reports:** `/admin/reports/content-model/` — node/vocabulary
  counts, field search, the fields listing, and entity-relationship diagrams.
- **System Reports:** `/admin/reports/system` — the enabled-modules list and
  workflow state/transition diagrams.
- **Permissions:** `/admin/people/permissions/module/content_model_documentation`.
