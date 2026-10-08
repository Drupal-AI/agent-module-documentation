<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Opt a bundle/view-mode into personalization — `acquia_perz.entity_config`

There is **no dedicated form** for this. The module alters every entity *Manage display* form
(`hook_form_entity_view_display_edit_form_alter` in `acquia_perz.module`) and adds an **"Acquia
Personalization"** details section. The choice is stored in config object
**`acquia_perz.entity_config`** under `view_modes.<entity_type>.<bundle>.<view_mode>`.

Only entity types implementing `Drupal\Core\Entity\EntityPublishedInterface` get the section
(e.g. node, taxonomy term, block_content). A date-only / non-publishable entity shows nothing.

## Structure

```yaml
view_modes:
  node:
    article:
      default:
        render_role: anonymous          # role used when rendering the entity for export
        preview_image: field_image      # optional: an image field on the bundle
        personalization_label: default  # optional: a string field to use as the label
        only_export_specific_entities: '' # optional: a boolean field gating per-entity export
```

Fields offered on the form:
- **Make @bundle available…** — the checkbox that creates/removes the `view_modes.…` entry.
- **Render role** (`render_role`) — a `user_role` id; defaults to `anonymous`.
- **Preview image** (`preview_image`) — select from the bundle's image fields (only shown if any exist).
- **Personalization Label** (`personalization_label`) — select from the bundle's `string` fields;
  empty value = `default`.
- **Only export specific entities** (`only_export_specific_entities`) — select a `boolean` field;
  `Disabled` (index 0) means always export.

## Read / write with drush

```bash
drush cget acquia_perz.entity_config
# Enable node.article.default for personalization, rendered as anonymous:
drush php:eval '$c=\Drupal::configFactory()->getEditable("acquia_perz.entity_config");
$vm=$c->get("view_modes")?:[]; $vm["node"]["article"]["default"]=["render_role"=>"anonymous"];
$c->set("view_modes",$vm)->save();'
```

The write path used by the UI is `PerzHelper::removeViewModeFromConfig()` (adds when the checkbox
is ticked, prunes the entity_type/bundle/view_mode branch when unticked). The config name constant
is `EntityHelper::ENTITY_CONFIG_NAME` (`acquia_perz.entity_config`). On uninstall the whole
`acquia_perz.entity_config` object is deleted.
