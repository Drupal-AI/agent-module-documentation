# JSON Field — manual setup guide

**JSON Field** (`json_field`) adds field types for storing arbitrary **JSON
documents** on any content entity — nodes, media, users, taxonomy terms, custom
blocks and so on. It is the field you reach for when you need to keep a chunk of
structured data verbatim — a third‑party API payload, a webhook body, GeoJSON
geometry, a form‑builder schema, LLM output — without modelling every property as a
separate Drupal field.

It provides three field types so you can pick the right storage for your database:
**JSON (text)** (`json`, a plain text/varchar column that stays portable across any
database), **JSON (raw)** (`json_native`, a native `json` column on MySQL/PostgreSQL
so the database can run JSON‑path queries), and **JSONB / JSON (raw)**
(`json_native_binary`, an indexable `jsonb` column on PostgreSQL). All three share a
textarea widget, a validation constraint that rejects malformed JSON on save, and two
formatters: a plain‑text one that can render the document as a collapsible tree using
the jQuery JSONView library, and a *pretty* one that renders it as nested HTML lists.

JSON Field also integrates with the rest of the stack: it adds a Views field that
emits **decoded** JSON in a REST Export feed (instead of an escaped string), a
serializer normalizer for the native type, and it plays nicely with Feeds, Diff and
JSON:API Extras. The nicer editing UI (a real JSON editor rather than a textarea)
lives in the bundled **JSON Field Widget** submodule.

The module has **no settings form, no admin page, no permissions and no Drush
commands** — everything is configured per field, in the normal Drupal field UI. It
requires PHP's JSON extension (always present) and Drupal 10.3 or 11.

This guide is written for a **human** adding a JSON field to a content type. If you
want the terse, token‑cheap reference for an AI coding agent — the storage columns,
the `size` setting, the constraint, render elements, services and integrations — read
the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and optionally enable the JSON editor submodule.

## Where it lives in the admin menu

JSON Field has no configuration page of its own. You use it in the standard field
UI: **Structure → Content types → (a type) → Manage fields → Add field**, and then
the field's **Manage form display** (widget) and **Manage display** (formatter).

## How to use it

1. Enable the module (see [Installation](installation/index.md)). If you want a
   proper JSON editor for editors, also enable the **JSON Field Widget** submodule.
2. Go to **Structure → Content types → [your type] → Manage fields** and click
   **Add field**. Under the **JSON data** category pick one of:
   - **JSON (text)** — safest and most portable; a good default.
   - **JSON (raw)** — a native JSON column (MySQL/PostgreSQL) if you want the database
     to query inside the document.
   - **JSONB / JSON (raw)** — an indexable `jsonb` column on PostgreSQL.
3. In the field's **storage settings** you can cap the column with the **size**
   option (255 varchar / 16 KB / 4 MB / 1 GB) to control table growth for the text
   type.
4. On **Manage form display**, the field uses the JSON textarea widget (or the richer
   editor from the submodule). The *valid JSON* constraint rejects a malformed
   document when the entity is saved.
5. On **Manage display**, choose a formatter: **Plain text** (optionally rendered as
   a collapsible JSONView tree — a checkbox lets you turn the JS library off per
   display) or **pretty** (nested HTML lists, no JavaScript required).

To surface the decoded JSON in a REST Export view, add the module's "(data)" field
in Views; to return raw JSON from JSON:API, pair the field with JSON:API Extras'
"JSON Field" enhancer. Those integrations, the exact storage columns and the
database‑version requirements are documented in the [`agent/`](../agent/start.md)
reference.
