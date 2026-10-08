# Configure Citation Select

All admin routes are under `/admin/config/citation-select` and require **`administer site configuration`**.
There are three things to set up: the block, the field mapping, and the CSL styles.

## 1. Place the block

Place **"Citation Select Block"** (`citation_select_block`, category "Citation Select") on node pages
(Structure → Block layout), typically restricted to the content types you cite via block visibility. It
renders `SelectCitationForm`; the node is resolved from the URL
(`[current-page:url:unaliased:args:value:1]`).

## 2. Settings form (`citation_select.settings` route)

Path `/admin/config/citation-select`, form `SettingsForm`. Config `citation_select.settings`:

| Key | Type | Meaning |
|---|---|---|
| `default_style` | string | Default CSL style id (ships `apa`). |
| `show_on_load` | bool | If TRUE the default style's citation renders immediately; else the user must pick a style first. |
| `csl_map` | map (ignore schema) | Node field → array of CSL fields (see CSL Mapping). Install default: `{title: [title], 'current url': [URL]}`. |
| `reference_type_field_map` | map | Maps a node's raw type value (lowercased) → a valid CSL type (e.g. `book`); falls back to `document`. |
| `typed_relation_map` | map | Typed-relation machine name → CSL name role. Install default maps `relators:aut→author`, `relators:ctb→contributor`, `relators:edt→editor`, `relators:pbl→publisher`. |

## 3. CSL Mapping form

Route `citation_select.csl_map` → `/admin/config/citation-select/csl_map`, form `CslMapForm`. Map each node
field to one or more of the ~80 supported CSL fields (types/names/dates listed in the form). Two pseudo-fields
are always available: `title` (node title) and `current url` (absolute node URL). For author/editor CSL
fields backed by a Typed Relation field, also add the field to the `typed_relation_map`.

## 4. CSL styles (config entities)

CSL styles are `citation_select_csl_style` ConfigEntities (`admin_permission: administer site configuration`),
managed at *CSL Styles* (`entity.citation_select_csl_style.collection`,
`/admin/config/citation-select/csl_style`):

- **Add** (`CslStyleForm`, `…/add`) — paste CSL XML into the "CSL text" textarea. Validated with a light
  `Csl` wrapper (`simplexml_load_string`), uniqueness by CSL id, and parent-style presence for dependent
  styles.
- **Add from file** (`CslStyleFileForm`, `…/add-file`) — upload a `.csl`/`.xml` file; its contents become the
  CSL text after validation.
- **Edit / Delete** — standard entity forms; you cannot disable the current `default_style`.
- Ships enabled styles: APA, MLA (current + 8th edition), Chicago author-date, American Medical Association
  (in `config/install`).

Only **enabled** styles appear in the block's style selector (`CitationStyler::getEnabledStyles()`).

## Rendering pipeline (what happens on style change)

1. `SelectCitationForm` AJAX callback rebuilds the bibliography region.
2. `CitationProcessorService::getCitationArray($nid, $langcode)` maps node fields → CSL-JSON using the
   `csl_map` and the right `CitationFieldFormatter` plugin per field type; resolves `type` via
   `reference_type_field_map` (default `document`).
3. The array is recursively `Xss::filter`ed.
4. `CitationStyler::render()` renders it with `seboettg/citeproc-php` using the selected style's CSL XML and
   the current language.
