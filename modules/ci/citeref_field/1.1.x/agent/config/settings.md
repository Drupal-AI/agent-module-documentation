<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings: external endpoint URLs

## Install & enable

```bash
composer require drupal/citeref_field
drush en citeref_field -y
```

No composer requirements and no declared contrib dependencies (uses core `field`). Then add a
"Citeref Field" field to a bundle (Structure → content type → Manage fields).

## Config object `citeref_field.settings`

Install defaults (`config/install/citeref_field.settings.yml`) — the base URLs each lookup type
uses:

| Key | Default |
|---|---|
| `doi_url` | `https://doi.org` |
| `handle_net_url` | `https://hdl.handle.net/api/handles` |
| `ark_url` | `https://n2t.net/ark:/` |
| `isbn_url` | `https://www.googleapis.com/books/v1/volumes` |
| `issn_url` | `https://portal.issn.org/resource/ISSN` |

There is **no `config/schema/`** in the module, so these keys are unschemaed.

## Settings form

`src/Form/CiterefFieldSettingsForm.php` (extends `ConfigFormBase`), route
`citeref_field.admin_settings` → **`/admin/config/content/citeref_field`** (menu link under
*Configuration → Content authoring*; `citeref_field.links.menu.yml`). Access: permission
**`administer citeref_field`** (`restrict access: true`).

One textfield per endpoint (`doi_url`, `handle_net_url`, `ark_url`, `isbn_url`, `issn_url`), each
with its own **"… API Status"** submit button (`check*ApiStatus()` handlers, `#limit_validation_errors: []`).
Each status handler fires a test GET against a known sample identifier (e.g. DOI
`10.1126/science.169.3946.635`, ISBN `978-3-16-148410-0`, ISSN `0028-0836`) using the injected
Guzzle `http_client`, reports up/down + status code + (collapsible) response body via the
messenger, and — on HTTP 200 — saves that URL into config. `validateForm()` requires every URL
to pass `UrlHelper::isValid(..., TRUE)`. The main **Save** (`submitForm()`) writes all five keys,
then `cache.menu->invalidateAll()` + `menu.link_manager->rebuild()`.

Injected services (`create()`): `config.factory`, `plugin.manager.menu.link`, `cache.menu`,
`http_client`, `messenger`.

## Autocomplete endpoint (CSL styles)

`src/Controller/CiterefFieldController.php::handleAutocomplete()`, route
`citeref_field.autocomplete` → **`/autocomplete/citeref_field`** (`_format: json`,
`_user_is_logged_in: TRUE`). Reads the `q` query param, runs `Xss::filter()` + lowercase/trim,
requires length > 2, then substring-matches (`stripos`) against the bundled
`csl_styles/csl_styles.txt` file and returns `[{value,label}]`. Used by the widget's
`citeref_style` field. No config; the style list is a static bundled file.

## Operate

Set the citeref field's widget on *Manage form display* and its formatter on *Manage display*.
Adjust the endpoint URLs here only if you need mirrors/alternate services; use the status buttons
to confirm reachability. External lookups require outbound HTTP from the web server.
