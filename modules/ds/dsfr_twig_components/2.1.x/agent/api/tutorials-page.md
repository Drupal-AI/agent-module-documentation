<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Demo / reference page: controller, route, filter form

The module ships one page: an admin-only demo that lists the operational DSFR component functions
with an AJAX keyword filter. There is **no settings/config form**.

## Route & menu

`dsfr_twig_components.routing.yml`:

```yaml
dsfr_twig_components.demo:
  path: '/dsfr/twig/{slug}'
  defaults:
    _controller: '\Drupal\dsfr_twig_components\Controller\TutorialsController::index'
    slug: ''
  requirements:
    _permission: 'access administration pages'
```

- `{slug}` selects which component's documentation section is shown; default `''`.
- Gated by core permission **`access administration pages`**.
- Menu link `dsfr_twig_components.demo` ("DSFR Twig") is placed under `dsfr_core.settings`
  (`.links.menu.yml`), so it appears with the DSFR Core settings.

## `TutorialsController::index($slug)`

`src/Controller/TutorialsController.php` (injects `form_builder`):

- Builds a `$sidemenu` (via `sideMenu()`) and a `$submenu` from `Resources::functionsReady()`
  (via `subMenu()`), plus a `$content` array of demo labels, DSFR doc URLs, sample snippets
  (using `PseudoComponents::chevrons()` / `Resources::colorLine()`), and the
  `functions` list.
- Returns a render array `#theme => '_tutorials'` with `#content`, `#sidemenu`, `#submenu`,
  `#slug`, and `#filter_functions` = the built `FilterFunctionsForm`.
- `$slug` is passed to the theme only as a selector; the `templates/-tutorials.html.twig` template
  uses it in `{% if key == slug %}` comparisons, not as echoed output.
- `hook_theme()` (`.module`) declares the `_tutorials` hook (template `templates/_tutorials`) with
  variables `content`, `sidemenu`, `submenu`, `slug`, `filter_functions`, `filter_dsfr`.

## `FilterFunctionsForm`

`src/Form/FilterFunctionsForm.php` (`FormBase`, id `filter_functions_form`):

- `buildForm()` adds one `textfield` `search` with an `#ajax` callback (`::ajaxFilterCallback`,
  event `keyup`, wrapper `ajax-result`). `submitForm()` is empty.
- `ajaxFilterCallback()` reads `$form_state->getValue('search')`, filters
  `Resources::functionsReady()` with `stripos($function['name'], $search)`, and builds an HTML
  list of the **matching function names** (from the fixed catalog), returned via an
  `AjaxResponse` `HtmlCommand` targeting `#ajax-result`. The search term itself is used only for
  matching, not reflected into the output.

## Libraries used by the page

`.libraries.yml`: `code` (depends on `code_css` + `code_ajax`) loads Prism CSS/JS from `dist/` and
a copy-to-clipboard script for code samples; `twig_components` loads component CSS. Assets are
bundled (built by Vite; see `vite.config.js`).
