<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `autosubmit` exposed-form plugin

`Drupal\views_autosubmit\Plugin\views\exposed_form\Autosubmit` — a Views **exposed_form**
plugin (`@ViewsExposedForm(id = "autosubmit")`) extending core `ExposedFormPluginBase`. It
does **not** define a new plugin *type*; it is one instance of the existing exposed_form type.

## Enable it on a view (UI)

1. Edit the view at `/admin/structure/views/view/<id>`.
2. Open the **Advanced** column → **Exposed form** → **Exposed form style**.
3. Change from *Basic* to **Autosubmit**, click **Apply**.
4. Set the options (below), **Apply**, then **Save**.
5. Usually also enable **Use AJAX** (Advanced → Other → Use AJAX: Yes) so results refresh in
   place instead of full page reloads.

## Options

| Option | Type | Default | Effect |
|---|---|---|---|
| `autosubmit_hide` | boolean | `TRUE` | Hide the submit button when JS is enabled (adds `js-hide`). |
| `timeout` | integer (ms, 0–10000) | `500` | Debounce delay after the user stops typing in a text input before the form auto-submits. |

## Where it is stored

In the view's display config:

```yaml
# views.view.<id>  ->  display.<display_id>.display_options
exposed_form:
  type: autosubmit
  options:
    autosubmit_hide: true
    timeout: 500
```

## Set it in code

```php
use Drupal\views\Entity\View;
$view = View::load('my_view');
$display = $view->get('display');
$display['default']['display_options']['exposed_form'] = [
  'type' => 'autosubmit',
  'options' => ['autosubmit_hide' => TRUE, 'timeout' => 800],
];
$view->set('display', $display);
$view->save();
```

## What it does at render (`exposedFormAlter()`)

- Adds class `views-auto-submit-full-form` to the exposed form.
- Adds `views-use-ajax` and `views-auto-submit-click` to the submit button.
- Attaches library `views_autosubmit/autosubmit` (jQuery, `core/once`, `core/drupal`;
  JS in `js/views_autosubmit.js`).
- Publishes `drupalSettings.views_autosubmit.timeout`.
- Adds `js-hide` to the submit button when `autosubmit_hide` is TRUE.

Config schema: `views.exposed_form.autosubmit` (in `config/schema/views_autosubmit.schema.yml`).
