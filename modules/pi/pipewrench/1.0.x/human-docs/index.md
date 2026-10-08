# Pipewrench — manual setup guide

**Pipewrench** (`pipewrench`) is a small utility module that fills a specific gap in
Drupal's editing experience: it lets **base fields** — the built-in fields defined in
code by an entity type, like a node's **Title** — carry a **description (help text)**
in the editing form. Drupal normally lets you add help text only to *configurable*
fields (the ones a site builder adds through Field UI); base fields have nowhere to
put it, which is why the node form's Title has no help text. Pipewrench supplies that
missing capability generically, so you no longer need a one-off form alter in a custom
module to add guidance like "keep under 60 characters for search results".

Its current features are deliberately narrow: adding help text to entity titles, and
adjusting the help text for Linkit's URI Description elements. The maintainers (Lullabot)
describe it honestly as a **shared internal utility** — opinionated and tailored to
their own conventions rather than a polished general-purpose module — but it is open
source and can be used, or serve as inspiration, elsewhere. Note the release is an
**alpha** (`1.0.0-alpha1`) and its security advisory coverage is marked **not
covered**, so weigh that before production use.

There is **no user-facing UI**: the module is aimed at developers and site
architects. It has no admin pages, no permissions, and no configuration form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** — Pipewrench has no settings form. Its behaviour
takes effect automatically once enabled.

## How to use it

Once enabled, Pipewrench extends the base field configuration UI so a description can
be set and shown on base fields such as Title. In practice that means the help text
you want on those fields becomes possible without writing a custom form alter. Because
the module is tailored to its maintainers' conventions, some behaviour may expect
particular content types, fields, or scaffolding to exist in your project; review its
code against your site if something does not appear as expected. It complements
`fieldhelptext` (which bulk-edits descriptions on *configurable* fields) — the two
address different halves of the same gap and can be used together.
