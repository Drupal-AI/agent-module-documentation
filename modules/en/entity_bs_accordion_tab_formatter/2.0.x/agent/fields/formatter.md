<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The formatter — EntityBSAccordionTabFormatter

File: `src/Plugin/Field/FieldFormatter/EntityBSAccordionTabFormatter.php`. Extends
`Drupal\Core\Field\FormatterBase` (uses `LoggerChannelTrait`).

```
@FieldFormatter(
  id = "entity_bs_accordion_tab_formatter",
  label = "Entity Bootstrap Accordion Tab formatter",
  field_types = { "entity_reference", "entity_reference_revisions" }
)
```

Because it targets `entity_reference_revisions` too, it appears on **Paragraphs** reference fields.

## Enable & select

1. Enable the module (`drush en entity_bs_accordion_tab_formatter`). No other module is required; the
   theme must provide Bootstrap CSS/JS, and BS3 tabs also need the Bootstrap Responsive Tabs library
   (see [config/settings.md](../config/settings.md)).
2. On the host entity's *Manage display* (`admin/structure/…/display`), set the reference field's
   Format to **"Entity Bootstrap Accordion Tab formatter"** and click the gear to configure it.

## Settings (`defaultSettings()` + `settingsForm()`)

`defaultSettings()` returns only three keys plus core defaults: `fields` (''), `style` (''),
`title_level` ('').

`settingsForm()` builds, from the reference field's `target_type` and its handler's `target_bundles`:

- **Per referenced bundle** (`fields[<bundle>]`, a fieldset):
  - `tab_title` — **required** `select` of the bundle's `FieldConfig` fields; supplies the panel
    **title** (header text).
  - `tab_body` — multi-value `select` of the bundle's fields; supplies the panel **body** (one or
    more fields).
  - `view_mode_override` — `select` of the target type's view modes (plus `_none` = "Use without view
    mode"); the view mode used to render/order the body. Defaults to `default`.
- **`style`** — `select` of the *host* entity+bundle's fields (from `form['#entity_type']` /
  `form['#bundle']`); the chosen host field's stored value decides the layout at render time.
- **`title_level`** — `select` (`_none` + host fields); the chosen host field's value is used as the
  accordion heading tag (BS5 accordion template), else `h2`.

`getEntityFields()` returns only fields that are `FieldConfig` instances. `settingsSummary()` returns
`[]` (no summary line).

## Render path (`viewElements()`)

The whole body runs inside a `try/catch`; any exception is logged to channel
`entity_bs_accordion_tab_formatter` and an empty array returned.

1. `bootstrap_version` (`$bs`) is read from config `entity_bs_accordion_tab_formatter.settings`.
2. From `$items->getParent()` (the host entity) it reads the **style** field value and builds a
   `component_id` (`style . host id`); if `title_level != '_none'` it reads that host field's value.
3. For each reference item, the target id is `target_id` (or a random 8-char name fallback). Loading:
   - if `target_revision_id` is set and storage has `loadRevision()`, load that revision;
   - otherwise `storage->loadByProperties(['id' => $id, ...])`, adding `'status' => 1` **unless** the
     current user has permission `view unpublished <target_type> entities`; falls back to
     `$item_value['entity']`.
4. If the site has a current language and the entity has that translation, the translation is used.
5. **Title**: `$content->get($tab_title)->getValue()[0]['value']` (raw scalar; the templates output it
   with Twig autoescaping).
6. **View mode**: `default`, unless `view_mode_selector` module is enabled and the bundle has a
   `view_mode_selector` field, in which case that field's value is used.
7. **Body**:
   - Multi-field (`tab_body` is an array): a `#type => container` (class `entity-bs-accordion-tab-body`).
     If `view_mode_override` is a real view mode, the module loads the `entity_view_display`
     `<type>.<bundle>.<view_mode>` and sorts the selected body fields by their component `weight`
     (skipping `hidden`-region fields), via `uasort`. Each field then renders as
     `#type => processed_text` when its value has a `format`, else `FieldItemList::view($view_mode)`.
   - Single-field: same processed_text-vs-`view()` rule on the one body field.
8. A big `switch ($style)` fills `li_attributes` / `header_attributes` / `body_attributes` (and, for
   BS5 tabs, responsive `h2_/button_/body_attributes_responsive`) with the correct Bootstrap 3/4/5
   toggle attributes; `accordion_closed` starts every panel collapsed, `accordion` opens the first.
9. Each panel is stored as `tabs[$id]` and the method returns a single
   `#theme => entity_bs_tab_formatter` or `entity_bs_accordion_formatter` element with
   `#attributes.id = component_id`. For `tab` + `bs3` it attaches the `bootstrap-responsive-tabs` and
   `tabs` libraries; for `tab` + `bs5`, the `tabs` library.

`getFieldOrderFromViewMode()` is a small helper returning a view mode's component keys in order (used
by the body-ordering logic).

## Config export example (formatter on a display)

```yaml
# part of core.entity_view_display.<type>.<bundle>.<mode>.yml
field_related:
  type: entity_bs_accordion_tab_formatter
  settings:
    fields:
      <ref_bundle>:
        tab_title: field_heading
        tab_body:
          field_body: field_body
        view_mode_override: teaser
    style: field_display_style   # host field whose value is accordion|accordion_closed|tab
    title_level: field_heading_level
```
