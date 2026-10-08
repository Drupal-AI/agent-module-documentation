<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form — the wrapper-element list (configure)

One `FormBase` is the entire configurable surface. It edits the core Views config value that
populates the **HTML element** dropdowns in a Views field's *Style settings*.

- Route: `views_html_tags.settings` → `/admin/config/user-interface/views-html-tags`
  (`views_html_tags.routing.yml`), gated by permission `administer views html tags`.
- Form class: `Drupal\views_html_tags\Form\ViewsHtmlTagsSettings`
  (`src/Form/ViewsHtmlTagsSettings.php`), form id `views_html_tags_settings`.
- Menu link: `views_html_tags.settings` under `system.admin_config_ui`
  (Configuration → User interface → "Views HTML tags").

## The one field

`buildForm()` renders a single required `textarea` named `views_html_tags`:

- `#default_value` comes from `views_html_tags_get_default()` (`views_html_tags.module`), which reads
  core `views.settings:field_rewrite_elements` and `implode(",", …)` of its **keys** — i.e. the
  current element list as a comma-separated string.
- Description tells the admin to enter tags separated by commas, e.g. `div,span,p,h1`.

## Validation (`validateForm`)

```php
if (!preg_match('/^[a-zA-Z0-9,]+$/', $form['views_html_tags']['#value'])) {
  $form_state->setErrorByName('views_html_tags', 'Special characters are not allowed in HTML tags.');
}
```

The **entire** submitted string must be letters, digits, and commas only — no angle brackets,
quotes, `=`, spaces, or newlines. So every stored tag name is a bare alphanumeric token; attributes
or markup cannot be entered here.

## Save (`submitForm`)

```php
$views_html_tags = trim($form_state->getValue(['views_html_tags']));
$tags = explode(',', $views_html_tags);
$vals = [];
foreach ($tags as $val) {
  $val   = trim($val, " ");
  $value = strtolower($val);   // config key
  $label = strtoupper($val);   // display label
  if ($value) {
    $vals[$value] = $label;
  }
}
$config = $this->configFactory()->getEditable('views.settings');
$config->set('field_rewrite_elements', $vals);
$config->save();
```

- The list is written to **core** `views.settings:field_rewrite_elements` as a `key => LABEL` map
  (lowercase key, uppercase label). This **replaces** the whole list — anything omitted from the
  textarea is removed from the dropdowns.
- A `messenger()->addStatus()` confirmation is shown.

## Where the list surfaces

`views.settings:field_rewrite_elements` is core Views' shared source for the "HTML element" `<select>`
in a field's *Customize field HTML* and *Customize field and label wrapper HTML* options (Views UI →
edit any field → **Style settings**). Editing it here changes those options for **every** view
site-wide, not per-view.

## Install/uninstall behavior (`views_html_tags.install`)

- `hook_install`: snapshots the current `field_rewrite_elements` into
  `views_html_tags.settings:views_html_tags_default`; if `views_html_tags.settings:views_html_tags_temp`
  is non-empty, applies it to `views.settings:field_rewrite_elements`.
- Uninstall cleanup is defined as `views_html_tags_modules_uninstall()` — note the non-standard hook
  name — so custom-list changes are **not** reverted automatically on uninstall.

## Programmatic equivalent

You don't need the form to change the list — set the core config directly:

```php
\Drupal::configFactory()->getEditable('views.settings')
  ->set('field_rewrite_elements', ['div' => 'DIV', 'article' => 'ARTICLE', 'time' => 'TIME'])
  ->save();
```

Or via drush: `ddev drush cset views.settings field_rewrite_elements.article ARTICLE -y`.
