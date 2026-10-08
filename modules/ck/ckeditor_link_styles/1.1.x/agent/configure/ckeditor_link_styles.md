<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure link styles

There is **no global configuration page** (`configure` is `null`). Link styles are set
**per text format** on the CKEditor 5 editor. The format must already have the **Link**
button (`link`) on its toolbar — the styles UI is gated by the core `ckeditor5_link` plugin.

## In the admin UI

1. Go to **Admin → Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and edit a CKEditor 5 format (e.g. *Full HTML*).
2. Make sure the **Link** button is in the active toolbar.
3. Open the **Link styles** vertical tab and enter **one style per line**:
   `a.classA.classB|Label`
   - `a.btn|Button`
   - `a.btn.large-button|Large Button` (compound classes are dot-separated)
4. **Save**. The classes should also exist in your theme's CSS so styled links render.

Only `a` (anchor) selectors with **one or more classes** are valid. A line missing the
class or the `|Label` is rejected with a "Line N does not contain a valid value" error.

## Where it is stored

On the `editor.editor.<format>` config entity, under
`settings.plugins.ckeditor_link_styles_linkStyles.styles` — a **sequence** of
`{label, element}` mappings. The line `a.btn|Button` is normalized and stored as the
CKEditor 5 element string `<a class="btn">`:

```yaml
settings:
  plugins:
    ckeditor_link_styles_linkStyles:
      styles:
        - label: Button
          element: '<a class="btn">'
        - label: 'Large Button'
          element: '<a class="btn large-button">'
```

Read it with:

```bash
drush config:get editor.editor.full_html settings.plugins.ckeditor_link_styles_linkStyles
```

## Set it programmatically (drush)

The stored value is the `element` form (`<a class="...">`), **not** the `a.btn|Label` line
form (that syntax is only for the textarea). Set it directly:

```bash
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("editor.editor.full_html");
  $c->set("settings.plugins.ckeditor_link_styles_linkStyles.styles", [
    ["label" => "Button", "element" => "<a class=\"btn\">"],
    ["label" => "Large Button", "element" => "<a class=\"btn large-button\">"],
  ]);
  $c->save();
'
drush cr
```

To remove all link styles from a format, unset the plugin key:

```bash
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("editor.editor.full_html");
  $p = $c->get("settings.plugins") ?: [];
  unset($p["ckeditor_link_styles_linkStyles"]);
  $c->set("settings.plugins", $p)->save();
'
```

## Notes

- No permission is defined by this module; editing formats needs core's
  *administer filters*.
- `<a class>` is added to the format's allowed HTML automatically (the plugin's element
  subset) when at least one style is configured — you do not hand-edit the allowed-tags
  filter.
- Coexists with Linkit and Editor Advanced Link, which also extend the Link plugin.
