# Entity Autocomplete Plus — manual setup guide

**Entity Autocomplete Plus** (`entity_autocomplete_plus`) makes Drupal's
entity-reference autocomplete suggestions easier to tell apart. When several
entities share the same label — three taxonomy terms all called "News", two users
both named "Sam", a handful of nodes with identical titles — the stock autocomplete
gives an editor no way to pick the right one. This module lets you append extra
**token-rendered** context after each suggestion's label, such as an author, a date,
a status, or a path, so the editor can choose confidently.

Under the hood it decorates Drupal's core entity autocomplete matcher, so the
suggestions themselves still come from the field's configured selection handler and
that handler's access checks are unchanged — the module only adds a descriptive
suffix to the labels it already returns. It works with both the
`entity_reference_autocomplete` widget and the **Inline Entity Form** widget, and it
affects only entity-reference fields.

There are two layers of configuration. A **global default** token string, set on the
module's settings page, applies everywhere unless overridden. And each field can set
its **own** token string on the reference/inline-entity-form widget's settings,
which takes precedence over the global default. Because the suffix is built from
**tokens**, the module has a hard dependency on the **Token** module, and a token
browser link is offered for the relevant entity type so you can find the right
tokens. It works on Drupal 9 and 10.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (alongside Token) and enable it.
2. [Configuration](configuration/index.md) — set the global default token string
   and override it per field on the widget settings.

## Where it lives in the admin menu

The global settings form is at **Configuration → Content authoring → Entity
Autocomplete Plus** (`/admin/config/content/entity_autocomplete_plus`). Per-field
overrides live on each entity-reference field's **Manage form display** widget
settings.
