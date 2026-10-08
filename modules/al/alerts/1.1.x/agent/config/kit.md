<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alerts Kit — imported configuration

Alerts Kit ships no PHP entities or plugins; installing the module imports configuration and seeds taxonomy terms. There is no settings form (`configure` is null) and no `*.permissions.yml` / `*.services.yml`.

## Install / enable
```
composer require drupal/alerts
drush en alerts -y            # imports the config below + seeds 3 severity terms
drush en alerts_olivero -y    # optional: Olivero banner styling + dismissal JS
```
`config/install/*` (the content type + vocabulary) is always imported; `config/optional/*` (fields, form/view displays, the view) is imported when its dependencies are met. Uninstalling does not remove the created content type, vocabulary, or view — to reinstall cleanly you must first delete the `alert` bundle, `alert_severity` vocabulary, and `alerts` view (per README).

## Content type `alert`
`config/install/node.type.alert.yml` — machine name `alert`, `new_revision: true`, `preview_mode: 1`, submitted info hidden. Fields (`config/optional`):
- **`body`** — `field.field.node.alert.body.yml`, type `text_with_summary`, not required, translatable.
- **`field_severity`** — `field.field.node.alert.field_severity.yml`, `entity_reference` to taxonomy terms, **required**, cardinality 1, `handler_settings.target_bundles: alert_severity`, terms sorted by name asc, `auto_create: false`. Storage `field.storage.node.field_severity.yml` (`target_type: taxonomy_term`).

Default view display (`core.entity_view_display.node.alert.default.yml`) shows `field_severity` (inline label, `entity_reference_label`, not linked), `body` (label hidden), and node `links`. A `teaser` view mode is also imported.

## Vocabulary `alert_severity`
`config/install/taxonomy.vocabulary.alert_severity.yml` (`vid: alert_severity`). Its `field_color` field (`field.field.taxonomy_term.alert_severity.field_color.yml`, storage `field.storage.taxonomy_term.field_color.yml`) is a `color_field` value used as the banner background.

`alerts_install($is_syncing)` (`alerts.install`) creates three terms via `Term::create()` with weights 0/1/2:

| Name | field_color |
| --- | --- |
| Emergency | #C70000 |
| Warning | #E06C00 |
| Notice | #018403 |

Add or edit terms to change the available severities and their colors.

## View `alerts`
`config/optional/views.view.alerts.yml`, base table `node_field_data`. Filters: published (`status = 1`) nodes of type `alert`. Sort: `created` DESC. Access: `perm` → `access content`. Displays:
- **`default`** — list; header renders the `add_content_by_bundle` "Add Alert" button (bundle `alert`).
- **`page_1`** — path `/alerts`.
- **`block_1`** — "some" pager, **5 items**, fields-row (not entity teaser). Placed by `alerts_olivero` into the Olivero `header` region (`block.block.views_block__alerts_block_1.yml`). See `../theming/banners.md` for the row rewrite that builds the banner markup.

## Dependencies
Module deps (`alerts.info.yml`): `link`, `taxonomy`, `views`, `add_content_by_bundle`, `color_field`. `add_content_by_bundle` supplies the in-view add link; `color_field` supplies the severity color widget/storage; `link` is declared for extending alert content.
