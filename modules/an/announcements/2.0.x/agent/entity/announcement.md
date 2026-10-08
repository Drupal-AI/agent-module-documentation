<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Announcement entity, fields & rendering

`src/Entity/Announcement.php` — `@ContentEntityType(id = "announcements_announcement")`, extends
`EditorialContentEntityBase` (revisionable + publishable). Tables: `announcements` (base),
`announcements_field_data`, `announcements_revision`, `announcements_field_revision`. `translatable = TRUE`,
`permission_granularity = "bundle"`, `bundle_entity_type = "announcements_type"`. Canonical path
`/announcements/{announcements_announcement}`; collection `/announcements`; add page `/announcements/add`.

Note: the annotation's `admin_permission = "administer announcement entities"` does not match any permission
declared in `announcements.permissions.yml` (which defines `administer announcements_announcement`), so that
admin bypass grants nothing — grant the real per-operation permissions instead.

## Base fields (`baseFieldDefinitions`)
- `title` — string, required, max 254, revisionable.
- `user_id` — entity_reference → `user` (author); `preCreate` defaults it to the current user; `preSave`
  falls back to anonymous (uid 0) when unset.
- `style` — entity_reference → `announcements_style`, **required**, `options_select` widget.
- `body` — `text_with_summary` (rendered through a text format).
- `region` — entity_reference → `announcements_region`, cardinality `-1` (multi), `options_buttons` widget.
- `status` — published flag (from `EntityPublishedTrait`), `boolean_checkbox` widget.
- `visibility` — `condition_field` type (from the condition_field module). `enabled_plugins` defaults to every
  condition plugin; `bundleFieldDefinitions()` narrows it per bundle to
  `AnnouncementType::getEnabledConditions()`.
- `created`, `changed`, `revision_translation_affected`.

## Accessor methods
`getTitle/setTitle`, `getCreatedTime/setCreatedTime`, owner get/set, `isDismissible()` (delegates to the
Type), and the visibility helpers `getVisibilityConditions()` (reads `conditions` from the field value),
`getVisibilityConditionPlugins()` (instantiates condition plugins via `plugin.manager.condition`),
`hasVisibilityConditions()`.

## Cache tags
`getCacheTags()` adds the referenced Style tags; `getCacheTagsToInvalidate()` adds referenced Region tags;
`invalidateTagsOnSave()` invalidates region tags on insert so region blocks refresh.

## Rendering path
1. `AnnouncementsRegionBlock::build()` (`src/Plugin/Block/AnnouncementsRegionBlock.php`) calls
   `AnnouncementStorage::loadActiveForRegion($region_id)`, which entity-queries `status = TRUE` + `region =`
   the block's region with `accessCheck(TRUE)`, then additionally filters by `$entity->access('view')`.
   Each result is rendered with the block's display mode and tagged with `#region`.
2. The block is derived once per Region entity by `Plugin/Derivative/AnnouncementRegions.php` (admin_label =
   base label + region label; stores `announcements_region` in the definition). Place these blocks via the
   normal Block layout UI.
3. Theme hook `announcements_announcement` (`announcements_theme()` in `.module`) uses
   `templates/announcements_announcement.html.twig` and `template_preprocess_announcements_announcement()`
   (`announcements.page.inc`): sets `dismissible`, adds `announcement-style--{id}` + the Style's
   `extra_classes` to the wrapper, sets `data-announcement-id`, and when dismissible attaches the
   `announcements/dismiss` library and a `.close` button.
4. `announcements_theme_suggestions_announcements_announcement()` supplies many suggestions
   (by view mode, bundle, style, id, region, and combinations).

## Dismissal (`js/dismiss.js`, `announcements.libraries.yml`)
Library `announcements/dismiss` (depends on `core/drupal`, `core/once`, `js_cookie/js-cookie`). Clicking
`.close` toggles the `announcement-dismissed` class and sets cookie
`announcement-{id}-dismissed`; on attach, if that cookie exists the announcement is hidden. Dismissal is
purely client-side (no server route/state).
