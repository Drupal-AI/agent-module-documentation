<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field CSS (field_css) — agent index

Provides a Field API field type (`css`) that accepts a block of CSS and renders it into the
entity's display as a `<style>` element. CSS is round-tripped through the `sabberworm/php-css-parser`
library, which can optionally prefix every selector so the rules are scoped to the entity
(`.scoped-css--<entity-type>-<id>`) or to a fixed class. Add the field to any bundle; the `css`
widget and `css` formatter are wired automatically.

- Dependencies: core `field`; Composer lib `sabberworm/php-css-parser:^8.0`. Optional: the
  `codemirror_editor` contrib module (syntax-highlighting editor) — a `suggest`, not required.
- Configure route: none (no settings page — `configure` is null). Behavior is set per-bundle on
  the field's widget and formatter under *Manage form display* / *Manage display*.
- Provides: one permission, config schema, and field-plugin implementations (field type + widget +
  formatter). No Drush, no new plugin types, no submodules.

- **Add/operate the CSS field — type, widget, formatter settings, config schema, render path** →
  [fields/css.md](fields/css.md)
- **The permission that gates who may edit CSS fields** → [permissions/access-css-fields.md](permissions/access-css-fields.md)

Key facts:
- Field type id `css` (`\Drupal\field_css\Plugin\Field\FieldType\CssItem`), default_widget `css`,
  default_formatter `css`. Storage column `value` (`text`, size `big`); property `value` (string).
- Widget id `css` (`CssWidget`): textarea; `#codemirror` props added when `codemirror_editor` exists.
  Settings `toolbar` (bool), `buttons` (sequence). Rejects any selector containing `:root`.
- Formatter id `css` (`CssFormatter`): settings `location` (`head`|`body`, default `head`),
  `prefix` (`none`|`entity-item`|`fixed-value`, default `none`), `fixed_prefix_value` (string).
- Permission: `access css fields` (`restrict access: true`). Enforced by
  `hook_entity_field_access()` for the `edit` operation on `css`-type fields.
- Config schema: `field.value.css`, `field.widget.settings.css`, `field.formatter.settings.css`.
- Service `field_css_block_component_render_array_subscriber` (`BlockComponentRenderArray`) re-adds
  the scoping class to Layout Builder components. Reusable trait `Drupal\field_css\Traits\CssTrait`.
