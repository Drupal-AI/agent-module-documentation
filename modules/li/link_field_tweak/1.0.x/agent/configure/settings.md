# Settings — site-wide and per-widget

## Site-wide config object `link_field_tweak.settings`

Form `LinkFieldTweakForm` at `/admin/config/content/link-field-tweak`
(route `link_field_tweak.settings`). Schema `link_field_tweak.settings` (config_object):

| Key | Type | Effect |
|---|---|---|
| `widget_field_order` | bool | Show Title input before URL input on ALL link widgets. When on, the per-widget order checkbox is hidden. |
| `add_another_link` | bool | Relabel the multi-value widget's "Add another item" button to "Add another link". |
| `uri_part_required` | bool | On ALL link widgets, mark the URL required (front-end `#states`) when the Title is filled. |

```bash
drush cset link_field_tweak.settings widget_field_order 1 -y
drush cget link_field_tweak.settings          # read current values
```

## Per-widget third-party settings (`entity_form_display`)

Added by `hook_field_widget_third_party_settings_form()` only for the core `link_default` widget.
Schema `field.widget.third_party.link_field_tweak`. Stored at
`core.entity_form_display.<entity>.<bundle>.<mode>` →
`content.<field>.third_party_settings.link_field_tweak.<key>`:

| Key | Type | Effect |
|---|---|---|
| `link_default_field_order` | bool | Title before URL for this widget (hidden if site-wide `widget_field_order` is on). |
| `uri_part_custom_help` | bool | Enable custom URL help text for this field. |
| `uri_part_custom_help_text` | label | The replacement URL help text (used when the toggle is on). |
| `title_part_custom_help` | bool | Enable custom Title help text (only if the field allows a title). |
| `title_part_custom_help_text` | label | The Title help text. |
| `uri_part_required` | bool | Mark URL required when Title filled, for this widget (hidden if site-wide is on). |
| `autocomplete_route_name_change` | bool | Extend entity-autocomplete match labels with id + bundle (uses `nodeextend` selection handler). |

Set on a form display component:

```bash
drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd->getComponent("field_my_link");           // must be a link_default widget
  $c["third_party_settings"]["link_field_tweak"]["link_default_field_order"] = TRUE;
  $c["third_party_settings"]["link_field_tweak"]["uri_part_custom_help"] = TRUE;
  $c["third_party_settings"]["link_field_tweak"]["uri_part_custom_help_text"] = "Enter the campaign URL";
  $fd->setComponent("field_my_link", $c)->save();
'
```

Read back: `$fd->getComponent("field_my_link")["third_party_settings"]["link_field_tweak"]`.
A per-widget summary is shown on Manage form display via
`hook_field_widget_settings_summary_alter()`.
