<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CSV value formats per field type

`contentimport_import_node()` maps each CSV cell to a node field value based on the field's
**type** (from the content type's field definitions). The column header must be the field's
machine name.

| Field type(s) | Expected CSV cell format |
|---|---|
| `title` (mandatory) | The node title (plain text). |
| `langcode` (mandatory) | Language code, e.g. `en`; blank ⇒ `en`. |
| `nodeid` (Update mode only) | Existing node id to update. |
| `author` | Username; sets the node author (falls back to current user). |
| `text`, `text_long` | Stored as `{ value, format: full_html }`. |
| `text_with_summary` | Stored as full HTML with an auto summary (first 100 chars, tags stripped). |
| `image` | File name; file must already be in `public://<content_type>/images/`. |
| `entity_reference` → taxonomy_term | `Vocabulary: term1, term2` (missing vocab/terms are auto-created). If the field targets a **single** vocabulary, omit the vocab name and just list `term1, term2`. For multiple target vocabularies use `vocabulary:term`. |
| `entity_reference` → user | Comma-separated emails (or names); missing users are auto-created. |
| `entity_reference` → node | Colon-separated node titles, e.g. `Title A:Title B`. |
| `datetime` | `m/d/Y` (date only) or a value with time (`m/d/Y H:i:s`) — parsed via `strtotime()` and stored as `Y-m-d` or `Y-m-d\TH:i:s`. |
| `timestamp` | A raw timestamp value. |
| `boolean` | `On`/`on`/`Yes`/`yes` ⇒ 1; anything else (`Off`/`No`) ⇒ 0. |
| `list_string` | Comma-separated option keys. |
| `geolocation` | `lat,long`; multiple values separated by `;` (e.g. `la,lo;la2,lo2`). |
| `geofield` | `lat,long` (converted to WKT via `geofield.wkt_generator`); multiple separated by `;`. |

Notes:
- Unlisted/other field types fall through to a default: the raw cell value is assigned as-is.
- Create mode (`1`) makes a new node per row when `title` is non-empty; Update mode (`2`) loads
  the node by `nodeid` and sets each mapped field.
- Auto-creation side effects: importing taxonomy/user references can create vocabularies, terms,
  and user accounts that did not previously exist.
