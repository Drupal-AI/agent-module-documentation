# Commerce License Entity Field — manual setup guide

**Commerce License Entity Field** (`commerce_license_entity_field`) adds a
Commerce License type that, while the license is active, **sets a configured value
on a field of an entity the buyer owns**. The product decides *which field* and
*what value* to set; the purchasing customer decides *which of their entities* the
license applies to. It's the natural way to model an "upgrade" purchase — for
example, letting a user pay to have one of their own article nodes **promoted to
the front page** by flipping the node's `promoted` flag.

Concretely, a single **product variation** holds the configuration (the target
entity type and bundle, the field name to set, and the value to set). When a
customer buys the license, they choose which of their entities it targets — stored
on the license's `license_target_entity` dynamic entity reference field. While the
license is active the value is applied, and it follows the normal license lifecycle
(grant, expire, revoke). The module also guards data integrity: it removes the
delete action from the target entity's edit form and shows a status message, so a
buyer can't delete an entity while an active license controls one of its fields
(which would leave a subscription in an illogical state). It depends on **Commerce
License** (`commerce_license`) and **Dynamic Entity Reference**
(`dynamic_entity_reference`).

**Important — this module is incomplete.** Its own README declares it a work in
progress: the customer‑facing entity‑selection widget in the license cart form is
not finished, and the target entity/field configuration in the license type plugin
is only partially implemented. Treat it as a **starting point that needs custom
code**, not a turnkey solution. It defines no routes, permissions, or services of
its own and relies entirely on Commerce License's plumbing. This release is an
alpha (`8.x-2.0-alpha7`) and is marked *not covered* by Drupal's security advisory
policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.

There is **no dedicated settings page** for this module. What configuration exists
lives on the product variation's license, as described in "How to use it" below —
and note the caveats above about it being unfinished.

## Where it lives in the admin menu

The module adds no admin configuration page of its own. You configure it on a
Commerce **product variation** that has a license field, under **Commerce →
Products**, by choosing this module's license type and setting the target field and
value.

## How to use it

1. **Enable the module** and its dependencies (see
   [Installation](installation/index.md)). This assumes Commerce License is already
   working with license‑enabled product variations.
2. On a license product variation, **select the "Entity field" license type**
   (`entity_field`).
3. Configure **which entity type/bundle**, **which field**, and **what value** the
   license should set. (Because the plugin's configuration UI is only partially
   implemented, expect to complete or extend this in code for a real deployment.)
4. When a customer buys the license, they choose which of **their own entities**
   receives the field change. While the license is active, the value is applied;
   the entity cannot be deleted until the license ends.
5. Because the buyer‑facing selection widget is unfinished, plan to add a custom
   entity‑reference selection (limiting choices to entities the buyer owns) and to
   finish the config UI before relying on this in production. Pairs naturally with
   `commerce_license_role` where some upgrades are roles and some are field values.
