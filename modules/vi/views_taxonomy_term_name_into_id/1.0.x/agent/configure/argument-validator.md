<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Use the "Taxonomy term name as ID" argument validator

The module has no configuration of its own. You enable the validator on a **contextual filter**
inside a view.

## Via the Views UI

1. Edit a view with a **taxonomy term ID** contextual filter — usually **"Has taxonomy term ID"**
   (`taxonomy_index_tid`). Add it under *Advanced → Contextual filters* if needed.
2. Open the contextual filter; tick **Specify validation criteria**.
3. In **Validator**, choose **Taxonomy term name as ID**.
4. Optionally set:
   - **Filter to vocabulary** (`bundles`) — restrict the name lookup to one or more vocabularies.
     Strongly recommended if term names are not unique site-wide.
   - **Transform dashes in URL to spaces** (`transform`) — matches `new-york` to the term "new york".
   - Access checking (`access`, `operation`) — only resolve terms the user may view.
   - **Action to take if filter value does not validate** (e.g. *Hide view / Page not found*).
5. Save. The view path (e.g. a page display at `/blog/%`) now accepts a term **name** and the
   validator swaps it for the term **ID** before the query runs.

## Where it lives in view config

Config entity `views.view.<id>`, under the display's argument:

```yaml
display:
  default:
    display_options:
      arguments:
        tid:                       # the "Has taxonomy term ID" contextual filter
          plugin_id: taxonomy_index_tid
          specify_validation: true
          validate:
            type: taxonomy_term_name_into_id
            fail: 'not found'        # action when validation fails
          validate_options:
            operation: view
            bundles: {}              # e.g. { tags: tags } to restrict to a vocabulary
            access: false
            transform: false
```

## Scriptable (edit the view config)

```php
$view = \Drupal::entityTypeManager()->getStorage('view')->load('my_view');
$display = &$view->getDisplay('default');
$arg = &$display['display_options']['arguments']['tid'];
$arg['specify_validation'] = TRUE;
$arg['validate']['type'] = 'taxonomy_term_name_into_id';
$arg['validate_options']['bundles'] = ['tags' => 'tags'];   // optional vocabulary restriction
$view->save();
```

Read it back: `drush config:get views.view.my_view display.default.display_options.arguments.tid.validate`.

## Behavior (from `TermNameAsId::validateArgument()`)

- If `transform` is on, dashes in the argument are replaced with spaces before lookup.
- Terms are loaded by `name` (and `vid` when `bundles` is set); each candidate is access-checked
  via `validateEntity()`.
- The **first** valid match wins: `$this->argument->argument` is set to that term's ID and the
  validator returns TRUE. If no accessible term matches, it returns FALSE (the filter's fail
  action applies).
- Because only the first match is used, non-unique names across vocabularies are ambiguous —
  restrict with `bundles`.
