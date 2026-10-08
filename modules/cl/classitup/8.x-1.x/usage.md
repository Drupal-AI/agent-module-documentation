<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Class It Up provides CSS classes based on information Drupal knows about the content and its context.

---

Class It Up adds CSS classes to rendered markup, derived from metadata Drupal already
has — the block's region, plugin id and provider, custom-block and node bundles, and
the route name on webform/view pages. This gives themers stable, machine-safe styling
hooks without writing preprocess functions or maintaining templates that differ only
in the classes they add. It follows Drupal's CSS naming guidelines and is in the Theme
package.

There is nothing to configure: the module has no settings form, no permissions, no
routes and no config. Enable it and the classes are added automatically. All class
values are machine-safe (content-derived values pass through `Html::getClass()`), and
the module plays no access-control role — it only emits classes for you to style. It is
designed to be depended on by themes that want these hooks. For adding custom classes
to fields specifically, the maintainers recommend the separate Field Formatter Class
module.

---

- Add CSS classes based on Drupal metadata (region, plugin id, provider, bundles, route).
- Add `block`, plugin-id, provider and `block--<region>` classes to blocks.
- Add `block--block-content--<bundle>` to custom content blocks.
- Add `page--content-item` and `page--content-item--<bundle>` on full node pages.
- Add `page--<route-parts>` classes on webform and view pages.
- Provide class-based styling hooks without custom preprocessing.
- Use machine-safe class values.
- Have no settings, permissions, routes or config.
- Have no access-control role.
- Be usable as a theme dependency.
