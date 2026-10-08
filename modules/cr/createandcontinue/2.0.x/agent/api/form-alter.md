<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Create and Continue — form alter & submit (source reference)

The whole module is one procedural file, `createandcontinue.module` (~45 lines). No classes, no
services, no config, no routes, no permissions, no hooks besides the one form alter.

## Install / enable

`ddev drush en createandcontinue -y`. Nothing to configure — the README states plainly there is no
settings form; enabling the module is the whole setup. Disable with
`ddev drush pmu createandcontinue -y`.

## `createandcontinue_form_node_form_alter(array &$form, FormStateInterface $form_state)`

An implementation of `hook_form_BASE_FORM_ID_alter()` for the node form (Drupal maps the function
name `createandcontinue_form_node_form_alter` to the base form id `node_form`, so it fires for the
add form AND the edit form of every content type).

- It reads the resolved request path via `\Drupal::service('path.current')->getPath()`.
- **Guard:** it only acts when that path contains the substring `/node/add/`
  (`strpos($current_path, '/node/add/') !== FALSE`). So despite the `.info.yml`/README wording
  ("node edit form"), the button is added on **add forms only**, never on the edit form of an
  existing node.
- When the guard passes it stores the path into form state
  (`$form_state->setValue('createandcontinue', $current_path)` — set but never read back), then
  **clones** the existing `$form['actions']['submit']` render array into a new action
  `$form['actions']['createandcontinue']`, relabels it `t('Save and add another')`, and **appends**
  `'createandcontinue_submit'` to that button's `#submit` array.

Because the new button is a copy of core's submit action, it inherits core's `#submit` handlers
(entity build + save) and runs them first; the module's own callback is appended last and only
overrides the final redirect. The original "Save" button is untouched and keeps core's default
redirect (to the newly created node).

## `createandcontinue_submit(array &$form, FormStateInterface $form_state)`

The appended submit callback. It reads `$form_state->getTriggeringElement()` and only acts when the
clicked element's `#id` equals `edit-createandcontinue` (i.e. the user pressed "Save and add
another", not the plain "Save"). When so, it sets the redirect back to the same add form:

    $current_path = \Drupal::service('path.current')->getPath();
    $form_state->setRedirectUrl(Url::fromUserInput($current_path));

The redirect target is the **resolved internal request path** from `path.current` (e.g.
`/node/add/article`) — it is not taken from any query string, POST value, or `destination`
parameter, so it always lands back on the same content-type add form. `Url::fromUserInput()`
requires the leading `/` that an internal path always has.

## Behavioural notes for agents

- Nodes only. Taxonomy terms, media, users, and custom entities get no equivalent button.
- The button appears on the add form of every content type for any user who can already reach that
  add form; access is governed entirely by core node-add access, which the module does not alter.
- The created node is not shown after "Save and add another" — the status message is the only
  feedback that the save succeeded.
