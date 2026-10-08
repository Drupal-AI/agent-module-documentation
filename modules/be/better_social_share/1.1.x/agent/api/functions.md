# Procedural API, alter hook & AJAX route

All in `better_social_share.module` unless noted. There is no service-based API; the render data is
built by procedural helpers.

## `better_social_share_create_data($url = NULL, $title = NULL, $config = NULL)`

Returns the render-variable array (`entity_url`, `entity_title`, `buttons_size`,
`social_share_platforms`, `more_button_type`, `button_image`, `more_button_placement`, `btn_bg_color`,
`btn_type`, `icon_color_type`, `btn_border_round`, `btn_show_label`, `enable_button_spacing`,
`buttons_label`, `icon_color`) to feed `#theme => 'better_social_share_standard'`.

- `$url` — share URL. If NULL/front page, resolved from `<front>` / `<current>`; if provided, passed
  through `UrlHelper::stripDangerousProtocols()`.
- `$title` — share title. **NULL** (the argument unset) ⇒ resolve the current page title via
  `title_resolver` (array titles are rendered in isolation with tags stripped); pass an **empty
  string** for no title. Falls back to the site name.
- `$config` — a config object to read look/behaviour keys from; NULL ⇒ `better_social_share.settings`.
  Pass a block's config object to render with per-block settings.
- Platforms: taken from `$config->get('social_share_platforms')`, merged against
  `better_social_share_platforms()`, filtered to `enabled == 1`, sorted by `weight`.

```php
$vars = better_social_share_create_data('https://example.com/page', 'My title');
$build = ['#theme' => 'better_social_share_standard'] + array_combine(
  array_map(fn($k) => "#$k", array_keys($vars)), array_values($vars)
);
$build['#attached']['library'][] = 'better_social_share/better_social_share.front';
```

## `better_social_share_create_entity_data(ContentEntityInterface $entity, $config = NULL)`

Convenience wrapper: derives `$url` from `$entity->toUrl('canonical', {absolute:true})` and `$title`
from `$entity->label()`, then calls `create_data()`. Walks a `paragraph` up to its first
non-paragraph parent first. Used by the entity pseudo-field and the Views field
([../fields/display.md](../fields/display.md)).

## `better_social_share_platforms()`

Returns the master ordered map `platform_id => t('Label')` of all ~100 platform keys (facebook,
twitter, linkedin, pinterest, teams, tumblr, reddit, whatsapp, snapchat, copy_link,
facebook_messenger, skype, sms, telegram, email, x, vk, line, mastodon, … nextdoor). Each key must
have a matching partial `templates/template-parts/<key>.html.twig` to render
([../hooks/theme.md](../hooks/theme.md)).

## `better_social_share_entity_type_has_bundles($entity_type_id)`

TRUE if the entity type defines a `bundle` key. Used by `hook_entity_view` to decide whether to check
for the display component.

## Alter hook — `hook_better_social_share_entity_types_alter(array &$entities)`

Invoked in two places (`BetterSocialShareSettingsForm::buildForm` and
`better_social_share_entity_extra_field_info`) over the array of `ContentEntityType` definitions that
may expose the share pseudo-field. Add/remove entity-type definitions to change which types can be
toggled/shown.

```php
// mymodule.module
function mymodule_better_social_share_entity_types_alter(array &$entities) {
  // $entities is keyed by entity type id => EntityTypeInterface; e.g. drop taxonomy terms:
  unset($entities['taxonomy_term']);
}
```

## AJAX popup route — `better_social_share.ajax`

Path `/better-social-share/get-popup`, controller
`Controller\SocialShareController::ajaxCallback`, `_access: 'TRUE'` (public by design). Renders the
`social_share_popup` theme hook (module close icon + the full `better_social_share_platforms()` list)
and returns `JsonResponse(['content' => <html>])`. `js/better_social_share.js` fetches it once per
page and appends it to `<body>`; the popup's per-platform links use literal `$share_link` / `$title`
placeholders that the JS replaces with `encodeURIComponent(url)` / `encodeURIComponent(title)` on
click. The response takes no request input and contains no per-user data.

> Note: `ajaxCallback()` passes the popup variables under a `#variables` key, which the
> `social_share_popup` theme hook does not map; the template therefore renders from the theme-hook
> defaults (module close icon + all platforms). Cosmetic, not a bug that affects output.

## Twig extension service

`better_social_share.twig_extension` (`TwigExtension\FileExistsExtension`) adds
`media_file_exists(filename)` and `get_media_file_path(filename)` — see
[../hooks/theme.md](../hooks/theme.md).
