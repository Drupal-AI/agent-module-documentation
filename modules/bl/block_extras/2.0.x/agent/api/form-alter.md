<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# block_form alteration (block_extras.module)

The module's only functional code is `block_extras_form_alter(&$form, $form_state, $form_id)` in `block_extras.module`. Everything below happens on the core block placement/configure form.

## Install / enable
`drush en block_extras -y`. No configuration, no permission grant, no route. The feature appears automatically on the block form. Core's Block Content (`block_content`) module must be present for the edit-link/preview branch to do anything (the module references `Drupal\block_content\Entity\BlockContent`), but it is not declared as a dependency in `block_extras.info.yml`.

## Trigger condition
The alter guards on `isset($form['id']['#default_value'])` and `$form_id === 'block_form'`. `$form['id']['#default_value']` is the block config entity id (e.g. `bartik_myblock`).

## How it resolves the content block
1. Loads the block config: `\Drupal::configFactory()->get('block.block.' . $block_default_value)`.
2. Reads `settings` and the block plugin id (`$data['id']`), then `explode(':', $block_plugin_id)`.
3. Only content blocks match: their plugin id is `block_content:{uuid}`, so `$block_plugin_id_split[1]` is the block_content UUID. Plugin-defined blocks (no `:` uuid part) fall through and nothing is added.
4. Looks up the numeric entity id via a parameterized query:
   `SELECT id FROM {block_content} WHERE uuid=:block_uuid` (placeholder bound — not string-concatenated).
5. If a row is found, `$block_id = $block_query[0]->id`.

## What it adds to the form
Under `$form['block_extras']` (a `#type => fieldset`, title "Block Extras"):
- `block_edit_link` — a `#markup` anchor:
  `'<a href="/admin/content/block/' . $block_id . '?destination=' . $current_path . '">Edit this block content</a>'`
  where `$current_path = \Drupal::service('path.current')->getPath()` (the current admin path, e.g. `/admin/structure/block/manage/{block}`). `#markup` is filtered through `Xss::filterAdmin()` by Drupal on render.
- `block_preview` — a nested `#type => fieldset` (title "Block preview") whose `preview` element is the block content rendered via
  `\Drupal::entityTypeManager()->getViewBuilder('block_content')->view(BlockContent::load($block_id))`.

## Access
No access logic is added. The fieldset, edit link, and preview inherit the core block form's access (the `administer blocks` permission). There is no new route, controller, or permission.

## hook_help
`block_extras_help()` returns a short About paragraph for `help.page.block_extras`. No other routes are handled.

## Not present in this version
No settings form (`configure` is null), no `*.permissions.yml`, no `*.routing.yml`, no `*.services.yml`, no `*.links.*.yml`, no `config/install`, no `config/schema`, no plugins, no Drush commands. README's "block attributes/classes/custom markup" style features are not in the 2.0.x code.
