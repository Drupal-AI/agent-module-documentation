<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, config, filter, CKEditor plugin & permissions

## Enable & wire up

`drush en ckeditor_taxonomy_glossary` (pulls core `taxonomy`, `ckeditor5`, `filter`). Enabling
creates the **`glossary`** vocabulary via `config/optional/taxonomy.vocabulary.glossary.yml`.
Then, per text format at `/admin/config/content/formats`: enable the **Glossary link filter**
and drag the **Glossary Link** button onto the CKEditor 5 toolbar. The button's allowed element
is `<a class="glossary-link" data-glossary-id>` (declared in `.ckeditor5.yml`); the editor
receives `autocompleteUrl: '/glossary/autocomplete/'` from
`Plugin/CKEditor5Plugin/GlossaryLink::getDynamicPluginConfig()`.

## Config object `ckeditor_taxonomy_glossary.settings`

Defaults in `config/install/ckeditor_taxonomy_glossary.settings.yml`; edited by
`Form/GlossarySettingsForm` at `/admin/config/content/ckeditor-taxonomy-glossary`
(permission `administer glossary terms`).

| Key | Default | Form widget | Meaning |
|-----|---------|-------------|---------|
| `show_on_hover` | `true` | checkbox | Show tooltip on hover |
| `show_on_click` | `true` | checkbox | Show tooltip on click |
| `delay` | `200` | number 0–1000 step 50 | Hover delay (ms) |
| `show_close_button` | `false` | checkbox | Render a × close button in tooltip |
| `preload_descriptions` | `true` | checkbox | Inline all definitions with the page vs. fetch on demand |
| `cache_duration` | `"3600"` | select (0/300/3600/86400/604800) | Max-age applied to JSON responses; `"0"` = no-cache |
| `link_style` | `"highlight"` (form default `dotted`) | select (dotted/solid/dashed/highlight) | Link underline/highlight style |
| `max_width` | (unset; form default 320) | number 200–600 | Tooltip max width (px) |

Note: the shipped install default for `link_style` is `highlight`, while the form's fallback
`#default_value` is `dotted` — the install value wins on a fresh install. `max_width` is not in
the install file and defaults to 320 via the form / filter `?? 320`.

## Filter `ckeditor_taxonomy_glossary_link`

`Plugin/Filter/GlossaryLinkFilter` (TYPE_TRANSFORM_REVERSIBLE). `process()`:
1. Returns early unless the text contains `glossary-link` or `data-glossary-id`.
2. Extracts tids with `preg_match_all('/data-glossary-id="(\d+)"/', …)`.
3. Attaches library `ckeditor_taxonomy_glossary/glossary_tooltip` and a
   `drupalSettings.ckeditorTaxonomyGlossary` block (linkStyle, maxWidth, showOnHover,
   showOnClick, delay, showCloseButton, cacheDuration).
4. If `preload_descriptions`, loads each term, filters to bundle `glossary`, resolves the
   current-language translation, and inlines `{name, description(->processed)}` under
   `…terms[tid]`, adding each term as a cacheable dependency.
5. Adds cache dependency on the config and cache tag `taxonomy_term_list:glossary`.

## CKEditor 5 plugin

`.ckeditor5.yml` → `ckeditor_taxonomy_glossary_glossarylink`: plugin `glossaryLink.GlossaryLink`,
library `ckeditor_taxonomy_glossary/ckeditor5` (built JS `js/build/glossaryLink.js` + admin/
autocomplete/modal CSS, deps include `core/ckeditor5`, jQuery UI autocomplete, `core/announce`).
PHP class `Plugin/CKEditor5Plugin/GlossaryLink` extends `CKEditor5PluginDefault` — no
configurable per-format settings; it only injects the dynamic `autocompleteUrl`.

## Permissions (`.permissions.yml`)

- **`administer glossary terms`** (`restrict access: true`) — the settings form.
- **`link to glossary terms`** — use the CKEditor button to link text. Surfaced to JS via
  `hook_page_attachments` on node add/edit routes.
- **`create glossary terms via editor`** (`restrict access: true`) — the create-term / term-form
  routes (see [../api/endpoints.md](../api/endpoints.md)). `hook_page_attachments` also emits a
  CSRF token (`drupalSettings.csrfToken`) for the POST create-term call, the language list, and
  the current user's glossary permissions, on node add/edit routes.

## Hooks & libraries

`Hook/CkeditorTaxonomyGlossaryHooks` (OOP `#[Hook]`, with `.module` LegacyHook shims):
`hook_help` (help page text) and `hook_page_attachments` (attaches `admin.glossarylink` CSS on
text-format config routes; `modal_utilities` + drupalSettings on node add/edit). Libraries in
`.libraries.yml`: `glossary_tooltip` (front-end), `ckeditor5`, `modal_utilities`,
`admin.glossarylink`. No install/update hooks, no Drush, no submodules.
