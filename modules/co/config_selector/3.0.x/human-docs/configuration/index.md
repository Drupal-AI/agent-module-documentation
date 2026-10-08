# Configuration

Configuration Selector is configured through **configuration YAML**, not an admin form. You mark
competing config entities with a shared *feature* name and a *priority*, and the module keeps the
highest-priority enabled variant active while disabling the others whenever modules are installed
or uninstalled.

## Opt a config entity into a feature

Add third-party settings and the module dependency to each competing config entity's YAML —
usually in your module's `config/optional/` directory so core only installs the variants whose
own dependencies are met:

```yaml
# e.g. views.view.my_listing.yml
langcode: en
status: true
dependencies:
  module:
    - config_selector      # REQUIRED, or the settings below are stripped on import
third_party_settings:
  config_selector:
    feature: my_listing_feature   # shared name across every competing variant
    priority: 10                  # integer; higher wins
    description: 'Basic listing'  # optional label
# ... the rest of the view/block config ...
```

Ship several YAML files that share the same `feature` but differ in `priority` — and typically in
their own `dependencies.module` (for example, one variant additionally depends on `search_api`).
Put them in `config/optional/` so a variant is only installed when its dependencies are present.

## How selection works

- **On install** — among the variants of a feature that are active after a module is installed,
  the one with the highest `priority` stays enabled and every other enabled variant of that
  feature is set to `status: false`.
- **On uninstall** — if uninstalling a module leaves *no* variant of a feature enabled, the
  highest-priority remaining variant is re-enabled.
- **Non-destructive** — losing variants are only *disabled*, never deleted, so any editor
  customizations survive and re-enabling a dependency can restore a tuned variant. Status
  messages name what was enabled or disabled.

The logic runs automatically from the module's install/uninstall hooks; you normally never call
anything yourself.

## Supported config entity types

- **Views** (`views.view.*`) and **Blocks** (`block.block.*`) work out of the box — schema for the
  third-party settings ships for both.
- Any other config entity type must (a) be **disable-able** (support a `status` flag — many types,
  such as fields and node types, are not and are unsupported) and (b) have a matching schema
  mapping added in your module:

```yaml
# my_module.schema.yml
my_entity_type.*.third_party.config_selector:
  type: config_selector_third_party
```

The `config_selector_third_party` schema type covers the `feature` (string), `priority`
(integer), and `description` (label) keys.

## The admin list

A `config_selector_feature` config entity type and an overview list exist at **Structure →
Configuration Selector** (`/admin/structure/config_selector`), gated by *Administer site
configuration*. The list lets you review which variant is active for each feature. The menu link
only appears once features exist. Note that the add / edit / delete forms behind this UI are
**stubbed / incomplete** — treat the module as developer-driven and create features by editing
YAML, not through the UI.

## No permissions, no Drush

The module defines no permissions of its own (the admin routes reuse core *Administer site
configuration*) and ships no Drush commands. For the underlying service and hook details, see the
sibling [`agent/configure/features.md`](../agent/configure/features.md) doc.
