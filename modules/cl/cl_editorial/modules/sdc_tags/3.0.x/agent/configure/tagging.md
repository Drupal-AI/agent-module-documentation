<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure tagging rules

`configure` is null (no info.yml key), but there **is** an admin UI. Tagging rules for each tag are
stored in the `sdc_tags.settings` config object.

## Config shape

```yaml
# sdc_tags.settings
component_tags:
  <tag_id>:
    tag_id: <tag_id>
    statuses: [stable, experimental]   # which lifecycle statuses are allowed
    allowed: []                        # explicit allow-list of component plugin ids (empty = all)
    forbidden: []                      # exclude these component plugin ids
```

Default (`config/install/sdc_tags.settings.yml`) ships `component_tags: []` (i.e. `{}` — no rules).
Schema: `config/schema/sdc_tags.schema.yml` (`sdc_tags.settings`, a `config_object`).

Semantics (see `ComponentTaggingController::summaryFromConfig()` /
`NoThemeComponentManager::getFilteredComponents()`):
- A component must have one of the listed `statuses`.
- If `allowed` is non-empty, only those components (of an allowed status) match.
- Otherwise all components (of an allowed status) match **except** those in `forbidden`.

## Admin UI

- **List:** `/admin/config/user-interface/sdc/component-tagging` (`ComponentTaggingController`,
  menu link "Single Directory Components: Tagging"). Shows every declared tag, its current rule
  summary, and the components that currently match, previewed with the `cl_editorial:component-card`
  SDC.
- **Edit a tag's rules:** `/admin/config/user-interface/sdc/component-tagging/auto/{tag}`
  (`AutoTaggingForm`). Pick allowed statuses, then refine with forbidden/allowed component
  checkboxes (the `ComponentFiltersFormTrait` sub-form). Saving writes
  `sdc_tags.settings` → `component_tags.<tag_id>`.

Both routes require the `administer site configuration` permission. The `{tag}` must be a
registered `component_tag` plugin (see [plugins/component-tag.md](../plugins/component-tag.md)),
otherwise the form returns 404.

## Read a tag's resolved filters (code)

```php
// Raw stored rule for a tag (or [] if none): {tag_id, statuses, allowed, forbidden}.
$filters = sdc_tags_get_tag_filters('hero');

// Resolve to actual components:
$mgr = \Drupal::service(\Drupal\cl_editorial\NoThemeComponentManager::class);
$components = $mgr->getFilteredComponents(
  $filters['allowed'] ?? [],
  $filters['forbidden'] ?? [],
  $filters['statuses'] ?? ['stable', 'experimental']
);
```

## Read/write via drush

```bash
drush cget sdc_tags.settings component_tags
# write a rule for tag 'hero':
drush cset sdc_tags.settings component_tags.hero.tag_id hero -y
drush cset sdc_tags.settings component_tags.hero.statuses.0 stable -y
```

Or in PHP: `\Drupal::configFactory()->getEditable('sdc_tags.settings')->set('component_tags.hero',
['tag_id'=>'hero','statuses'=>['stable'],'allowed'=>['cl_editorial:component-card'],'forbidden'=>[]])->save();`
