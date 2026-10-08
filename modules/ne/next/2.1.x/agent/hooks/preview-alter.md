<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Next.js — hook_next_site_preview_alter

Declared in `next.api.php`. The single hook the module invites you to implement. It alters the
renderable produced by a `site_previewer` plugin's `render()` after the preview is assembled (e.g. to
add controls or metadata above the iframe).

```php
/**
 * Implements hook_next_site_preview_alter().
 *
 * @param array &$preview   The preview renderable from the site_previewer.
 * @param array $context    [
 *   'plugin'         => SitePreviewerInterface, // the previewer plugin
 *   'entity'         => EntityInterface,        // entity being previewed
 *   'sites'          => NextSiteInterface[],    // sites for this entity
 *   'original_build' => array,                  // un-altered build
 * ]
 */
function my_module_next_site_preview_alter(array &$preview, array $context) {
  // Show the entity title above the preview.
  $preview['title'] = [
    '#markup' => $context['entity']->label(),
    '#weight' => -100,
  ];
}
```

## Core's own use of it

`next.module` implements this hook (`next_next_site_preview_alter`): when `content_moderation` is
enabled and the previewer is `iframe`, it injects the moderation control form
(`content_moderation_control`) at the top of the preview so editors can change moderation state
without leaving the preview.

There are also plugin-info alter hooks for the four plugin types (see
[../plugins/plugin-types.md](../plugins/plugin-types.md)): `hook_next_site_resolver_info_alter`,
`hook_next_site_previewer_info_alter`, `hook_next_preview_url_generator_info_alter`,
`hook_next_revalidator_info_alter`.
