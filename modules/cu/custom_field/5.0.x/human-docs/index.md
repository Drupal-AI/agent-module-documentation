# Custom Field — manual setup guide

**Custom Field** (`custom_field`) gives you a single field type — called simply
*Custom* — that bundles several **subfields (columns)** into one field. Instead
of adding three separate fields for, say, a call-to-action's title, URL, and
style, you add one Custom Field with three columns. It is a lightweight, fast
alternative to Paragraphs or entity references when the data is a small, fixed
record.

The reason it is fast is that every column lives in the **same database table**
as the field itself (columns are stored as `field_x_<column>`), so there are no
joins and no extra configuration entities per subfield. Each column has its own
data **type** (string, integer, datetime, entity reference, image, link, color,
map, and more), its own **widget** on the edit form, and its own **formatter**
on display — so a single field can capture and render a whole mini-record. The
parent field is laid out with one of two widgets: `custom_flex` (a visual
CSS-flexbox arrangement) or `custom_stacked` (one column per row), and displayed
with formatters like a themed list, an inline string, an HTML table, a flipped
table, or a Twig template you write yourself.

There is **no global settings page**. Everything is configured per field through
Drupal's normal Field UI: you add the field, define its columns in the storage
settings, choose a widget per column on *Manage form display*, and choose a
formatter per column on *Manage display*. The module also ships Drush commands to
add or remove a column on a field that already holds data, Views integration,
tokens, and Feeds support. Nine optional submodules add integrations such as
GraphQL, JSON:API, Linkit, Media Library, Search API, Single Directory
Components, Entity Browser, AI, and Viewfield.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and pick any integration submodules you need.
2. [Configuration](configuration/index.md) — add a Custom Field, define its
   columns, and choose widgets and formatters for each one.

## Where it lives in the admin menu

Custom Field adds no admin page of its own. You work with it entirely from the
**Field UI** on whatever entity you are extending — for a content type that is
**Structure → Content types → (your type) → Manage fields / Manage form display
/ Manage display** (`/admin/structure/types/manage/<type>/fields`). It appears
in the field-type list under the **Field** category when you add a new field.
