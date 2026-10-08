<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Term Condition adds a reusable **"Term"** Condition plugin that returns TRUE when the contextual node (or taxonomy term / node revision / preview on the current route) references one of a chosen set of taxonomy terms — most commonly used to control **block visibility**.

---

The module ships a single Condition plugin (`id: term`, `Drupal\term_condition\Plugin\Condition\Term`) built on core's `ConditionPluginBase`. Because it is a standard Condition plugin it appears anywhere Drupal collects conditions — the **Visibility** section of the block placement form is the primary use case, but any consumer of the condition plugin system (Context, asset_injector, etc.) can use it. Its configuration form is an `entity_autocomplete` (tagged, `#target_type: taxonomy_term`) that lets you pick one or more terms; on submit the module stores the selected terms as an array of **UUIDs** under the `term_uuids` config key (v2 switched from term IDs to UUIDs so exported config survives content re-imports). At evaluation time it reads the `node` context; if that is empty it falls back to the current route, trying the `taxonomy_term`, `node`, `node_revision` and `node_preview` parameters (loading a revision when the parameter is a string). It then walks the entity's `referencedEntities()` and returns TRUE as soon as a referenced taxonomy term's UUID matches one of the configured `term_uuids`. With no terms selected and the condition **not** negated it returns TRUE (i.e. it does not restrict), and the standard "Negate the condition" checkbox inverts the result. An `update_9201` hook migrates old tid-based configuration to the new UUID format.

---

- Show a promotional block only on nodes tagged with a specific taxonomy term (e.g. "Sale").
- Hide a block on articles that reference a "Sponsored" term by negating the condition.
- Restrict a "Related downloads" block to pages categorised under a particular product term.
- Display a department-specific sidebar only on content tagged with that department's term.
- Gate a call-to-action block so it appears only on nodes in a chosen content category.
- Combine several terms in one condition so a block shows on any of them (OR logic).
- Drive seasonal banners by term reference (show a "Holidays" block only on holiday-tagged content).
- Reuse the same term-based visibility rule across many blocks without custom code.
- Control visibility of menu or system blocks based on the viewed node's taxonomy.
- Show region-targeted content by tagging nodes with a "Region" term and matching a block to it.
- Export block visibility that references terms by UUID so it deploys cleanly across environments.
- Hide a generic block on nodes belonging to a "Legal" or "Archived" term.
- Surface a subscribe block only on blog posts filed under selected topic terms.
- Provide taxonomy-aware visibility to a Context reaction (any condition consumer).
- Show an author bio block only on content categorised under an "Editorial" term.
- Restrict advertising blocks away from content tagged "No ads" using negation.
- Target a language- or audience-specific term to vary block placement.
- Show a warning/notice block only on pages referencing a "Deprecated" term.
- Display a cross-sell block on product-review nodes tagged with the reviewed product's term.
- Use the term match on taxonomy term pages themselves (route fallback resolves the term).
- Show a block on a node's preview and revision routes as well as its canonical page.
- Migrate legacy tid-based term visibility to UUID-based config automatically on update.
- Build editorial rules where blocks follow taxonomy tagging rather than explicit paths.
- Keep block placement stable when nodes are re-created, because matching is by term UUID.
