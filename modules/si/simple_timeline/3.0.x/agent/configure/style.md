<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — the Simple Timeline views style

Style plugin **`simple_timeline`** (class `SimpleTimeline`). In a view, set **Format →
Simple Timeline**. It uses a row plugin (`Fields` or `Rendered entity`), supports per-row
classes, and does **not** support grouping. There is no global config — options live in the
view display.

## Style options (`defineOptions()` defaults)

| Option | Default | Allowed values |
|---|---|---|
| `position_items` | `alternate` | `alternate` (left/right around the line), `left`, `right` |
| `position_marker` | `marker-center` | `marker-top`, `marker-center`, `marker-bottom` |
| `wrapper_class` | `wrapper-list` | any CSS class string (regex-validated) |
| `class` | `item-list` | any CSS class string (regex-validated) |

Schema: `config/schema/simple_timeline.views.schema.yml` (`views.style.simple_timeline`,
`FullyValidatable`, `Choice` constraints on the two position options).

## Where it is stored

```
views.view.<view_id>
  display:
    <display_id>:
      display_options:
        style:
          type: simple_timeline
          options:
            position_items: left
            position_marker: marker-top
            wrapper_class: wrapper-list
            class: item-list
```

## Set it via drush / code

```bash
# Switch an existing view's default display to the timeline style with left items:
drush php:eval '
  $v = \Drupal\views\Entity\View::load("my_view");
  $d = &$v->getDisplay("default");
  $d["display_options"]["style"] = [
    "type" => "simple_timeline",
    "options" => [
      "position_items" => "left",
      "position_marker" => "marker-top",
      "wrapper_class" => "wrapper-list",
      "class" => "item-list",
    ],
  ];
  $v->save();
'
```

(In the UI: Views → your view → Format → choose **Simple Timeline**, then **Settings** to set
item position and marker position.)
