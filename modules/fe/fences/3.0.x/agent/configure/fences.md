<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Fences field wrapper markup

Fences has two layers of configuration: a tiny **global settings form** and the real work,
**per-field settings** stored on each field's formatter.

## Per-field settings (the main thing)

Configured on **Structure → Content types → *type* → Manage display** (the display config,
not the form display). Click the **gear** on a field row and open the collapsible **Fences**
section. Requires the `edit fences formatter settings` permission (see
[../../permissions](#permissions) below); without it the section is hidden.

### The eight settings keys

Stored on the field's `entity_view_display` component under
`content.<field>.third_party_settings.fences` (config schema
`field.formatter.third_party.fences`). Each *tag* key is an HTML tag name from the Fences tag
registry, or the special value `none` to emit **no** wrapper. Each *classes* key is a
space-separated class string (empty by default).

| Key | Wraps | Default |
|---|---|---|
| `fences_field_tag` | the whole field | `div` |
| `fences_field_classes` | classes on the field wrapper | `''` |
| `fences_field_items_wrapper_tag` | a wrapper around all items | `none` |
| `fences_field_items_wrapper_classes` | classes on the items wrapper | `''` |
| `fences_field_item_tag` | each individual item | `div` |
| `fences_field_item_classes` | classes on each item | `''` |
| `fences_label_tag` | the field label | `div` |
| `fences_label_classes` | classes on the label | `''` |

Defaults live in `Drupal\fences\FencesConstants::DEFAULT_THIRD_PARTY_SETTINGS`. Note the
items-wrapper tag defaults to `none` (no wrapper) while the others default to `div`. Setting
any *tag* to `none` drops that element from the output entirely; a *classes* field is ignored
(and hidden in the UI) when its tag is `none`.

The formatter settings **summary** on Manage display shows any key whose value differs from
the default (e.g. "Field tag: section", "Label tag: h3").

### Read / write with drush (config)

Fences settings are plain config on the display entity, so you script them directly. Example:
give `node.article.default`'s **body** field a `<section>` wrapper and an `<h3>` label:

```bash
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd->getComponent("body");
  $c["third_party_settings"]["fences"] = [
    "fences_field_tag" => "section",
    "fences_field_classes" => "",
    "fences_field_items_wrapper_tag" => "none",
    "fences_field_items_wrapper_classes" => "",
    "fences_field_item_tag" => "div",
    "fences_field_item_classes" => "",
    "fences_label_tag" => "h3",
    "fences_label_classes" => "",
  ];
  $vd->setComponent("body", $c)->save();
'
drush cr
```

Read it back:

```bash
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  print_r($vd->getComponent("body")["third_party_settings"]["fences"] ?? "none");
'
```

Or inspect the exported config directly:

```bash
drush config:get core.entity_view_display.node.article.default content.body
```

To remove Fences from a field, `unset($c["third_party_settings"]["fences"])` and re-save the
component (the field falls back to core's default `div` markup).

## Global settings form

Route `fences.settings` at `/admin/config/user-interface/fences/settings`
(there is also a parent menu page `fences.overview` at `/admin/config/user-interface/fences`).
Config object `fences.settings` has one key:

- `fences_field_template_override_all_themes` (boolean, default `false`) — when `false`,
  Fences only replaces the field template if core provided it; when `true`, Fences forces its
  `field.html.twig` even over a theme that ships its own. Set it with:

```bash
drush config:set fences.settings fences_field_template_override_all_themes true -y
drush cr
```

## Permissions

- `edit fences formatter settings` — required to see/edit the per-field Fences section on
  Manage display.
- `administer fences settings` — required for the global settings form.

## Presets

The optional **fences_presets** submodule adds reusable named tag bundles you can apply to a
field in one click — see [../../../modules/fences_presets/3.0.x/agent/start.md](../../../modules/fences_presets/3.0.x/agent/start.md).
