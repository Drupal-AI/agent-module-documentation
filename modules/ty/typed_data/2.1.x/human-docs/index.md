# Typed Data — manual setup guide

**Typed Data** (`typed_data`) is a developer toolkit that extends Drupal core's
Typed Data API with the pieces core leaves out: a *data fetcher* that navigates
property paths, a *placeholder resolver* that fills in `{{ … }}` tokens with
optional filters, and a set of pluggable *form widgets* for editing typed data
values. It is best known as a foundational dependency of the **Rules** module, but
any module can build on it.

There is nothing to configure and no user interface — this module is pure
programmatic infrastructure. Its `typed_data.data_fetcher` service walks a
property path such as `node.uid.entity.name.value` to fetch a nested value or its
data definition (and can autocomplete partial paths). Its
`typed_data.placeholder_resolver` service scans text for `{{ … }}` placeholders and
replaces each one with a fetched value, optionally passing it through a filter such
as `upper`, `trim`, `strip_tags`, `count`, `format_date`, or `entity_url`. It also
defines two new plugin types — **DataFilter** (`typed_data_filter`) for adding your
own placeholder transformations, and **TypedDataFormWidget**
(`typed_data_form_widget`) for rendering an edit form (text, textarea, select,
datetime, datetime range) for a given data type.

The module depends only on Drupal core (10.3 or 11) and provides a handful of
Drush commands for inspecting the data types, entities, contexts, filters, and
widgets available on your site. It ships no permissions and no configuration of its
own.

This guide is written for a **human** — but because Typed Data is a developer
library with no admin UI, the practical detail lives in the sibling
[`agent/`](../agent/start.md) docs, which cover the service APIs, plugin types, and
Drush commands. An AI coding agent should read those directly.

## Contents

1. [Installation](installation/index.md) — install and enable the module (usually
   it arrives automatically as a dependency of Rules).

## How to use it

Typed Data has no settings screen; you use it from code and, for debugging, from
Drush. Two services do most of the work:

- **Fetch a value by property path** — the `typed_data.data_fetcher` service
  resolves a path like `node.uid.entity.name.value` to the underlying value or its
  definition. This is what lets a site builder type a token-style path and have it
  resolve at runtime.
- **Resolve placeholders in text** — the `typed_data.placeholder_resolver` service
  turns a template such as `Hello {{ node.title.value | upper }}` into finished
  text, applying any filters you name after the `|`. It collects cacheability
  metadata as it goes and can resolve values per language.

To extend it, you define a **DataFilter** plugin (to add a new
`{{ value | your_filter }}` transformation) or a **TypedDataFormWidget** plugin (to
render an edit form for a custom data type). Both are discovered via PHP attributes
or annotations.

For quick inspection while developing, the module adds Drush commands that list
what is registered on your site:

```bash
drush typed-data:datatypes     # available data types
drush typed-data:entities      # available entities
drush typed-data:contexts      # registered contexts
drush typed-data:datafilters   # registered data filters
drush typed-data:formwidgets   # registered form widgets
```

See the [`agent/`](../agent/start.md) docs for the full service method signatures
and plugin examples.
