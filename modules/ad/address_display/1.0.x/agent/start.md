# Address display — agent index

Provides one field formatter, **`address_display_formatter`** ("Address Display"), for `address`
fields. It lets you choose which address components display, their order, and a per-component
"glue" separator. No settings form, no configure route, no permissions, no Drush, no plugin type.
Depends on the `address` module.

- **Select the formatter on Manage display, its settings keys, and where they are stored** →
  [configure/formatter.md](configure/formatter.md)

Key fact: settings live on the `entity_view_display` config
(`core.entity_view_display.<entity>.<bundle>.<mode>`) at
`content.<field>.type: address_display_formatter` with
`content.<field>.settings.address_display.<component>.{display,glue,weight}`. The formatter
extends `address`'s `AddressPlainFormatter` and only applies to fields of type `address`.
