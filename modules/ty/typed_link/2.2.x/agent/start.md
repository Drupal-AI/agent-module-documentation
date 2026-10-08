# Typed Link — agent index

A `typed_link` field type = core Link + a required "link type" chosen from an admin-defined
allowed-values list (like a List(text) field). Ships a widget and a formatter. No global config
page (`configure` null), no permissions, no Drush, no plugin managers. Depends on core `field`,
`link`, `options`. Provides a config schema for its settings.

- **Add/configure the field, allowed link types, widget, and formatter** →
  [configure/field.md](configure/field.md)

Key facts:
- Field type `typed_link` (`TypedLinkItem extends LinkItem`), extra column `link_type`
  varchar(255), indexed, is the field's `mainPropertyName`. Option handling delegated to a
  private core `ListStringItem`.
- Allowed values are set on **field storage settings** exactly like List(text): key|label pairs
  or an `allowed_values_function`. Constraints inherited from LinkItem (LinkType, LinkAccess,
  LinkExternalProtocols, LinkNotExistingInternal).
- Widget `typed_link` (extends `LinkWidget`): URI + title inputs + a `link_type` select; select
  is `#required` (client-side `#states`) when the URI is filled. Options run through
  `hook_options_list_alter` and are label-sanitised.
- Formatter `typed_link` (extends `LinkFormatter`): renders the link, appends the type label
  (or raw value if no longer allowed) as `#markup` limited to `FieldFilteredMarkup::allowedTags()`.
  Schema also defines a `typed_link_separate` formatter-settings group reusing core link settings.
