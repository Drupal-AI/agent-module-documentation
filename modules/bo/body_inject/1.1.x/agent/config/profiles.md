<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Body Inject profiles — configuration & injection mechanism

## Install & enable

```bash
composer require drupal/body_inject   # pulls drupal/token_block ^1|^2
drush en body_inject -y
```

The `info.yml` declares no `dependencies:`, so Drupal does not enforce a module dependency at enable
time; `token_block` is only a Composer requirement. Configure at
**`/admin/config/content/body_inject`** (menu: *Configuration → Content → Body Inject*).

## Permission & routes

`body_inject.permissions.yml` defines a single permission, **`administer body_inject profiles`**
(not marked `restrict access: TRUE`). Every route in `body_inject.routing.yml` requires it, and it is
the entity's `admin_permission`:

| Route id | Path | Purpose |
|---|---|---|
| `entity.body_inject_profile.collection` | `/admin/config/content/body_inject` | List builder (`ProfileListBuilder`) |
| `entity.body_inject_profile.add_form` | `/admin/config/content/body_inject/add` | Add (`Form\Profile\AddForm`) |
| `entity.body_inject_profile.edit_form` | `/admin/config/content/body_inject/manage/{body_inject_profile}` | Edit (`Form\Profile\EditForm`); title via `BodyInjectController::profileTitle()` |
| `entity.body_inject_profile.delete_form` | `.../manage/{body_inject_profile}/delete` | Core `EntityDeleteForm` |

## The config entity

`Drupal\body_inject\Entity\Profile` (`@ConfigEntityType id = "body_inject_profile"`, config prefix
`body_inject_profile`). Exported keys (`config_export`) and schema
(`config/schema/body_inject.schema.yml`, all string mappings):

| Key | Meaning |
|---|---|
| `id`, `label`, `description` | Machine name, label, admin-listing description. |
| `block_reference` | The **block plugin id** to inject (schema declares a `target_id` mapping, but the form stores the plain plugin id string). |
| `node_type` | Target content-type machine name (from `node_type_get_names()`). |
| `paragraph_operator` / `paragraph_number` | Condition on `<p>`-count: operator `<`/`=`/`>` and a number. |
| `char_operator` / `char_number` | Condition on stripped-text character count. |
| `and_or` | `and` / `or` — how the paragraph and character conditions combine. |
| `paragraph_offset` | Placement: offset (±) from the middle paragraph. |
| `paragraph_position` | Placement: insert after paragraph N. |
| `char_position` | Placement: insert after ~N characters (snapped to nearest paragraph). |

The add/edit form is `Form\Profile\FormBase` (extends `EntityForm`, injects
`plugin.manager.block`). Block options come from
`blockManager->getFilteredDefinitions('block_ui', [], [])`, sorted and filtered to drop
`_block_ui_hidden` definitions — i.e. the same set placeable through the block UI, custom blocks
included. The form's help text stresses: **fill in only ONE of the three placement fields**; leaving
both condition fields blank means "always try to insert." `save()` trims the label and redirects to
the collection.

## How injection happens (`body_inject.module`)

`body_inject_entity_view_alter(&$build, $entity, $display)` runs for **every** entity view:

1. `body_inject_profiles()` loads all profiles and buckets them by `node_type`. If the current
   entity's bundle has no profile → return.
2. Only acts when `$display->getOriginalMode() === 'full'` (the full view mode). View mode is not yet
   configurable (`@TODO` in source).
3. Finds the body text by reference: `$build['body'][0]['#text']`, or by digging into
   `$build['_layout_builder'][0]` for a `node…body` block plugin. If no body is found it logs a
   `body_inject` warning and returns.
4. For each matching profile, `body_inject_adv_process_condition($body_text, $inject_data)` decides
   whether to inject; passing profiles go to `body_inject_adv_node()`, which mutates the body text in
   place.

### Condition evaluation

`body_inject_adv_process_condition()`:
- Returns `TRUE` immediately if both `paragraph_number` and `char_number` are empty (always inject).
- Paragraph count = `count(explode("<p>", $body))`; character count =
  `strlen(trim(strip_tags($body)))`.
- Compares via `body_inject_operator_check($operator, $uservalue, $compare_to)` for operators
  `<`, `=`, `>`, combined per `and_or`.
- **Caveats (functional bugs, not injected-content issues):** the `=` branch of
  `body_inject_operator_check()` uses assignment `if ($compare_to = $uservalue)` (always truthy for a
  non-zero user value), and the AND/OR blocks re-run the single-field checks so the effective logic is
  looser than the labels imply. Treat conditions as approximate.

### Rendering & placement

`body_inject_adv_node($actions, $body)` explodes the body on `"<p>"`, then per action:

- `$bid = block_reference`. It tries `entityTypeManager()->getStorage('block_content')->load($bid)`;
  since `$bid` is a **block plugin id** (e.g. `block_content:<uuid>` or `system_powered_by_block`),
  not a numeric block_content id, that load returns nothing, so the code falls to
  `block_manager->createInstance($bid, [])->build()` and
  `renderer->renderPlain($render)`. **The block is rendered through Drupal's normal block/field
  pipeline** (text formats applied), then wrapped in `<div class='body-inject body-inject-$bid'>…</div>`.
- Placement uses `array_splice` on the paragraph array:
  - `paragraph_position` → insert after that paragraph index (+1).
  - `char_position` → walk paragraphs accumulating stripped-char counts, insert after the first
    paragraph that reaches the target.
  - `paragraph_offset` → insert near the middle (`round((count-1)/2)`) plus the offset.
- The array is re-imploded on `"<p>"` and written back to `$body_text`, replacing the rendered body.

Because injection only edits the already-rendered body string of the `full` view, teasers, search
results and other view modes are unaffected, and blocks that need render context may render empty.

## Config export example

```yaml
# body_inject.body_inject_profile.article_midad.yml
langcode: en
status: true
id: article_midad
label: 'Article mid-body ad'
description: 'AdSense unit in the middle of articles'
block_reference:
  target_id: 'block_content:1a2b3c4d-....'
node_type: article
paragraph_operator: '>'
paragraph_number: '4'
and_or: and
char_operator: ''
char_number: ''
paragraph_offset: '0'
paragraph_position: ''
char_position: ''
```

## Operating notes

- To output raw ad markup (e.g. AdSense `<ins>`), the README advises giving the **custom block a
  dedicated text format with all filters disabled**, since normal formats mangle such snippets — the
  module itself applies whatever format the block uses.
- `ProfileListBuilder` shows label, description, node type and the resolved block label (or
  "invalid block/deleted block" when the plugin no longer exists).
- Deleting the referenced block leaves the profile pointing at a missing plugin; injection then simply
  produces no block markup.
