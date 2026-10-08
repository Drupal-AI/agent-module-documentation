# ECA Commerce — agent index

Glue module that exposes Drupal Commerce to the [ECA](https://www.drupal.org/project/eca) engine.
No routes, permissions, Drush, or config UI (`configure` null); depends on `eca` + `commerce`.
Provides a config schema only for its action config and the derived condition config. All behaviour
is driven by ECA models (trusted site config) built in a modeller — the maintainers recommend BPMN.

Three plugin families it contributes (it defines no plugin *type* of its own — it plugs into ECA's
and core's action plugin types):

- **Events** — one derived ECA event plugin (`eca_commerce`) covering every Commerce event, plus the
  tokens each event exposes → [plugins/events.md](plugins/events.md)
- **Conditions** — derived ECA conditions wrapping every Commerce condition plugin
  (`eca_commerce_commerce:*`) → [plugins/conditions.md](plugins/conditions.md)
- **Actions** — `eca_commerce_change_price_in_cart` and `eca_commerce_add_adjustment` on order items
  → [plugins/actions.md](plugins/actions.md)

Key facts:
- Event ids are `eca_commerce::<id>` (deriver `CommerceEcaEventsDeriver`); groups load only when the
  matching Commerce submodule is enabled (guarded by `class_exists`).
- Condition ids are `eca_commerce_commerce:<commerce_condition_id>`; evaluated against an `entity`
  context; BPMN-incompatible widgets are rewritten (see conditions doc).
- Actions are core `#[Action]` plugins typed `commerce_order_item`; amounts/labels run ECA token
  replacement before use.
