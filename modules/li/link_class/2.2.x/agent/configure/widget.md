<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the "Link with class" widget

`link_class` ships a single field widget and nothing else — no admin page (`configure` is
`null`), no permissions, no Drush, no services. You configure it per Link field on
**Structure → Content types → *type* → Manage form display**.

## Enable it

1. Add or reuse a **Link** field on an entity bundle.
2. On **Manage form display**, set that field's widget to **Link with class**
   (plugin id `link_class_field_widget`). It only applies to `link` field types.
3. Click the gear to open widget settings and choose a mode (below).

## Modes (`link_class_mode`)

The widget adds a "Method for adding class" radio with three options. Default is `manual`.

| `link_class_mode` | Editor sees | Extra setting used |
|---|---|---|
| `manual` | a free-text **Link classes** textfield per link (type any classes, space-separated) | — |
| `select_class` | a **Select a style** dropdown (with a "- None -" option) | `link_class_select` |
| `force_class` | nothing — the class is applied automatically to every link | `link_class_force` |

## Settings keys

Stored on the field's `entity_form_display` component under
`field.widget.settings.link_class_field_widget`:

- `link_class_mode` — one of `manual` | `select_class` | `force_class` (default `manual`).
- `link_class_force` — the class string applied to every link in **force** mode
  (e.g. `btn btn-default`). Used only when mode is `force_class`.
- `link_class_select` — the option list for **select** mode, one `key|label` per line
  (e.g. `btn btn-default|Default button`). The key is the class(es) put on the link (multiple
  classes separated by a space); the label is shown in the editor dropdown. If a line has no
  `|label`, the key is used as the label. Used only when mode is `select_class`.

The widget also inherits core LinkWidget settings (`placeholder_url`, `placeholder_title`).

## Where the class goes / rendering

Whatever mode is used, the chosen class is written into the link value's
`options.attributes.class`. Core's link field formatter renders `options.attributes` onto the
`<a>` tag, so the class appears in output with **no special formatter** required.

## Configure it with drush (config)

Set the widget on a form display programmatically (example: force mode on
`node.article.default`, field `field_cta`):

```bash
drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_cta", [
    "type" => "link_class_field_widget",
    "settings" => ["link_class_mode" => "force_class", "link_class_force" => "btn btn-cta"],
  ])->save();
'
drush cr
```

Read the current widget/setting back:

```bash
drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  print_r($fd->getComponent("field_cta"));
'
```

For select mode, pass `"link_class_mode" => "select_class"` and
`"link_class_select" => "btn btn-default|Default\nbtn btn-primary|Primary"`.
