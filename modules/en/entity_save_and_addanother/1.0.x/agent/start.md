<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Save And Add Another (entity_save_and_addanother) — agent index

Adds a **"Save and Add Another"** submit button to entity **add** forms. On save it redirects the
editor back to the same add path so they can keep creating items of that bundle without navigating
back to *Add content → <type>*. Everything lives in one procedural file,
`entity_save_and_addanother.module` — there is no config, no UI, no routes, no services.

Mechanism (per supported entity type): a `hook_form_FORM_ID_alter()` first confirms the current
path (`\Drupal::service('path.current')->getPath()`) is the *add* path (e.g. contains `/node/add/`),
then clones the existing `$form['actions']['submit']` element into a new action
`$form['actions']['entity_save_and_addanother_<type>']`, relabels its `#value` to
`t('Save and Add Another')`, removes the `destination` query arg
(`\Drupal::request()->query->remove('destination')`) so its own redirect wins, and appends a
`entity_save_and_addanother_<type>_submit_handler` submit callback. That handler checks the
triggering element's `#id` and, when the new button fired, calls
`$form_state->setRedirectUrl(Url::fromUserInput($current_path))` to return to the add form. The
button only appears on the *add* route (not edit) because each alter matches the current path.

- Depends on (info.yml): `drupal:node`, `drupal:taxonomy`, `drupal:menu_link_content`, `drupal:block`.
  Media and Commerce Product support is soft — the alters fire only if those forms/paths exist.
- Core: `^8 || ^9 || ^10 || ^11`. Package: `Other`. Installed version: `1.0.2`.
- No settings page (`configure` is `null`), no permissions, no Drush, no config schema, no plugin
  types, no libraries, no templates. Installing the module enables the feature site-wide.
- Access: reuses core's own submit button and the entity's create access; adds no new route,
  permission, or access check of its own.

## Key facts (real machine names)

- Supported add forms (hard-coded, all bundles, no per-bundle config):
  - `node_form` → path `/node/add/*`
  - `media_form` → path `/media/add/*`
  - `taxonomy_term_form` → path `/admin/structure/taxonomy/manage/<vid>/add`
  - `menu_link_content_form` → path `/admin/structure/menu/manage/<menu>/add`
  - `block_content_form` → path `/block/add*`
  - `commerce_product_form` → path `/product/add/*` (only when Commerce is present)
- Hooks implemented: `entity_save_and_addanother_form_node_form_alter`,
  `…_form_media_form_alter`, `…_form_taxonomy_term_form_alter`,
  `…_form_menu_link_content_form_alter`, `…_form_block_content_form_alter`,
  `…_form_commerce_product_form_alter`.
- Submit handlers: `entity_save_and_addanother_node_submit_handler`, `…_media_submit_handler`,
  `…_term_submit_handler`, `…_menu_submit_handler`, `…_block_submit_handler`,
  `…_commerce_product_submit_handler`.
- New action element keys: `entity_save_and_addanother_{node,media,term,menu,block,commerce_product}`
  under `$form['actions']`.
- Triggering-element ids the handlers check: `edit-entity-save-and-addanother-node`,
  `edit-entity-save-and-addanother-media`, `edit-entity-save-and-addanother-term`,
  `edit-entity-save-and-addanother-menu`, `edit-entity-save-and-addanother-block`,
  `edit-actions-entity-save-and-addanother-commerce-product`.
- Redirect target: `Url::fromUserInput($current_path)` — the current internal add path (an entity
  add route only); the handler strips the `destination` query param before redirecting.

There are no further agent docs — the whole module is the single file above.
