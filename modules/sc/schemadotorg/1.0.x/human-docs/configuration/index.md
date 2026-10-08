# Configuration

Everything is under **Configuration → Schema.org** (`/admin/config/schemadotorg`)
and gated by the single **Administer Schema.org** (`administer schemadotorg`)
permission. This page explains the two building blocks (mappings and mapping
types), the global settings, and how to create a mapping.

## The two config entities

### Mappings

A **mapping** (`schemadotorg_mapping`) links one Drupal entity type + bundle to a
Schema.org type and records which field maps to which Schema.org property. For
example, a mapping might record that the *Person* content type represents the
Schema.org `Person` type, with `field_email → email`, `field_telephone → telephone`,
and so on. You manage mappings at **Configuration → Schema.org → Mappings**
(`/admin/config/schemadotorg/mappings`) — list, edit, and delete them there. (The
**add** form comes from the `schemadotorg_ui` submodule.)

### Mapping types

A **mapping type** (`schemadotorg_mapping_type`) is configured **per Drupal entity
type** (installed for *node* and *user*). It declares which Schema.org types are
recommended or default for that entity type, and the naming rules (label/id
prefixes) used when generating bundles and fields. The recommended types are grouped
into sets such as *quick start*, *common*, *web*, and *content*, which makes it easy
to bootstrap a starter content model. Manage these at **Configuration → Schema.org →
Types** (`/admin/config/schemadotorg/types`).

## Global settings

The settings live in `schemadotorg.settings`, edited across four tabbed forms under
**Configuration → Schema.org → Settings**:

- **General** — core behavior and the location of the bundled Schema.org data.
- **Types** — default Drupal types for Schema.org types (for example
  `WebPage → page`), recommended type sets, and subtyping behavior.
- **Properties** — how individual Schema.org properties behave, the default field
  type chosen for each, and the list of **ignored properties** that should never
  become fields.
- **Names** — the naming rules (custom words and abbreviations, e.g. `GTIN`,
  `RxCUI`) that keep generated machine names within Drupal's length limits.

You typically adjust these once, to match your project's conventions, before
creating mappings in bulk.

## Creating a mapping

### With the UI submodule

If you enabled `schemadotorg_ui`, use its **add mapping** form to pick a Drupal
entity type + bundle and a Schema.org type, review the properties that will become
fields, and create everything with one submit.

### With Drush (no UI needed)

The base module is designed for programmatic use. Create one or several types at
once:

```bash
drush schemadotorg:create-type node:Person node:Organization node:Event
```

The module creates each bundle if it does not exist and generates the fields for
the type's Schema.org properties, applying the type/property/naming settings above.

Related Drush commands include deleting a mapped type (optionally its fields or the
whole bundle) and keeping the bundled Schema.org data current — see the sibling
[`agent/`](../agent/drush/drush.md) docs for the full command list.

## For developers

The base module exposes services for introspecting the Schema.org vocabulary and
building mappings, plus alter hooks to customize which field type a property maps
to, adjust generated field definitions, change bundle values, and tweak mapping
defaults. See the sibling [`agent/`](../agent/api/services.md) docs.
