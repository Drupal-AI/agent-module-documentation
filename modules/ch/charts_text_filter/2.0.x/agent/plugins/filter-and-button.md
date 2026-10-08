<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Filter, CKEditor 5 button and dialog form

Three cooperating plugins turn a visually-configured chart into inline markup and back into a
rendered chart. Source: `src/Plugin/Filter/ChartsTextFilter.php`,
`src/Plugin/CKEditor5Plugin/ChartButton.php`, `src/Form/ChartConfigForm.php`,
`charts_text_filter.routing.yml`, `charts_text_filter.libraries.yml`.

## Install / enable

1. Install and enable **Charts** (`^5.1`) and configure a default library at
   `/admin/config/content/charts`, then enable **Charts Text Filter** (pulls in core `ckeditor5`,
   `editor`, `filter`).
2. At `/admin/config/content/formats`, edit a CKEditor 5 text format:
   - Drag the **Chart** button (toolbar item `insertChart`) into the active toolbar.
   - Enable the **"Charts text filter"** filter (`filter_charts_text_filter`).
   - The button is *conditioned* on that filter (`conditions: ['filter' => 'filter_charts_text_filter']`
     in `ChartButton`), so CKEditor 5 hides it until the filter is on.
3. The plugin auto-allows the `<chart>` and `<chart data-chart-config>` elements for the format
   (declared `elements` in `ChartButton`), so no manual "Allowed HTML tags" edit is needed.

## Filter: `ChartsTextFilter` (id `filter_charts_text_filter`)

- Attribute `#[Filter(... type: TYPE_TRANSFORM_IRREVERSIBLE)]`; extends `FilterBase`, implements
  `ContainerFactoryPluginInterface`; constructor-injects `renderer`.
- `process($text, $langcode): FilterProcessResult`:
  - Fast path: returns the text unchanged if it does not contain the substring `<chart`.
  - `Html::load($text)` → `\DOMXPath` → `//chart[@data-chart-config]`. Iterates the node list **in
    reverse** (replacing a node invalidates later positions).
  - For each element: `ChartConfig::decode($element->getAttribute('data-chart-config'))`. If the
    decoded config lacks any of `type`, `library`, `display`, the element is **left in place**
    (no broken chart emitted).
  - Builds `[$id => Chart::buildElement($config, $id)]` with `$id = Html::getUniqueId('chart-')`,
    renders it inside a fresh `RenderContext` via `renderer->executeInRenderContext()`, then
    `$result = $result->merge(BubbleableMetadata::createFromRenderArray($build))` so the charting
    library's JS/CSS attachments and cache metadata survive when the filtered text is cached.
  - Skips insertion when the rendered markup is empty; otherwise `replaceElement()` swaps the
    `<chart>` node for the rendered markup.
  - `setProcessedText(Html::serialize($dom))` returns the final HTML.
- `replaceElement()` parses the rendered markup in a **separate `\DOMDocument`** with
  `LIBXML_HTML_NOIMPLIED | LIBXML_HTML_NODEFDTD | LIBXML_NONET` (no implied `<html>/<body>`, no
  network), imports the nodes into a fragment and replaces the original element (handles multi-root
  markup, e.g. Charts debug mode).
- `tips()` returns a short human string.

## CKEditor 5 plugin: `ChartButton` (id `charts_text_filter_button`)

- `#[CKEditor5Plugin]` with `ckeditor5.plugins = ['charts_text_filter.Chart']`, Drupal label
  *Chart*, `library: 'charts_text_filter/charts_button'`, `admin_library: 'charts_text_filter/admin'`,
  allowed `elements` `<chart>` and `<chart data-chart-config>`, toolbar item `insertChart`.
- `getDynamicPluginConfig()` injects `chartsTextFilter.dialogTitle` and, when the editor has an id,
  `chartsTextFilter.dialogUrl` = generated URL of route `charts_text_filter.dialog` for that editor.
  During format creation the editor has no id yet, so no URL is supplied (nothing to embed into).

## Dialog route & form: `ChartConfigForm` (`@internal`)

- Route **`charts_text_filter.dialog`** → `/charts-text-filter/dialog/{editor}`, `_form` =
  `ChartConfigForm`, `_admin_route: TRUE`, `{editor}` upcast to an `entity:editor`. Access:
  `_entity_access: 'editor.use'` — only users permitted to use that editor's text format can open the
  dialog (via `\Drupal\editor\EditorAccessControlHandler`; see
  `tests/src/Functional/ChartDialogAccessTest.php`).
- `buildForm()`: reads `editor_object` from `$form_state->getUserInput()` (posted by the CKEditor 5
  plugin), decodes `chart_config` and stashes it + `dialog_id` in form state (so AJAX rebuilds keep
  them; caches the form on POST). Renders `#type => 'charts_settings'` (`#used_in => 'basic_form'`,
  `#series => TRUE`) with `#default_value` from `buildDefaultValue()`. Attaches `charts/charts` and
  `core/drupal.dialog.ajax`.
- Actions are AJAX-only. `submitFormAjax()`: if `$form_state->hasAnyErrors()`, `ReplaceCommand`s the
  wrapper (`#charts-text-filter-config-form`) to show validation errors; otherwise
  `ChartConfig::clean($form_state->getValue('chart_settings'))` → `InsertChartCommand($config,
  $dialog_id)` + `CloseModalDialogCommand()`. `cancelFormAjax()` just closes the dialog. There is no
  non-JS fallback and `submitForm()` is a no-op — the form only exists inside CKEditor 5.
- `buildDefaultValue()`: base is `charts.settings` → `charts_default_settings`; for a new chart it is
  used as-is, for an edited chart `ChartConfig::mergeDefaults($site_defaults, $existing_config)` so
  new settings added since embedding still get a default.

## Libraries (`charts_text_filter.libraries.yml`)

- `charts_button`: `js/build/charts_text_filter.js` (CKEditor 5 build) + `css/charts-placeholder.css`;
  depends on `core/drupal.ajax`, `ckeditor5/internal.drupal.ckeditor5`, and `charts_command`.
- `charts_command`: `js/charts-ajax-command.js` (registers the `chartsTextFilterInsertChart` AJAX
  command); depends on `core/drupal.dialog.ajax`.
- `admin`: `css/admin.css`.
