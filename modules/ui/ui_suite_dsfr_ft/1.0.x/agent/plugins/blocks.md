<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UI Suite DSFR Feature — blocks & SVG autocomplete

## Blocks (`src/Plugin/Block/`)
| Block class | Purpose |
|---|---|
| `DisplayButtonBlock` | Renders a DSFR button component |
| `DisplayModalBlock` | Renders a DSFR modal; icon chosen via SVG autocomplete (`BASE_DIR` constant is the SVG scan root) |
| `ConsentBannerBlock` | DSFR cookie/consent banner |
| `FooterTopBlock` | DSFR footer-top region content |

Place them through **Structure → Block layout**; configure content/icon in each block's settings form.

## SVG autocomplete
Route `ui_suite_dsfr_fr.display_svg.autocomplete` → `/admin/ui-suite-dsfr-fr/autocomplete/svg` (permission `administer site configuration`, JSON).

Controller `DisplaySvgAutocomplete::handleAutocomplete`:
- Reads `?q=`, runs it through `Xss::filter`.
- Recursively iterates `DisplayModalBlock::BASE_DIR`, keeps only `.svg` files, returns `{value, label}` pairs whose path contains the query.

The scanned directory is fixed in code — the request cannot redirect the scan elsewhere.

## Requirements gate
`ui_suite_dsfr_ft_requirements()` errors on the status report unless the `ui_suite_dsfr` theme is enabled and its version is newer than `1.0.0-rc3`.
