Display Mode Switcher swaps an entity's display (view) mode at render time based on weight-ordered rules and condition plugins, with no template overrides or custom code.

---

Display Mode Switcher lets you show different field layouts to different audiences purely through configuration. You create `display_mode_switcher_rule` config entities, each naming a target entity type (and optionally a bundle), a source display mode that triggers evaluation, a target display mode to switch to, a weight, and zero or more condition plugins. When any entity is rendered, `hook_entity_view_mode_alter()` calls the resolver service, which loads the enabled rules matching the entity type, bundle, and source display mode, sorts them by ascending weight, and evaluates each rule's conditions (logical AND). The first rule whose conditions all pass wins and its target display mode replaces the source mode; if none match, the original mode is kept. The module ships a custom condition plugin manager that exposes the entire standard Drupal condition library (user role, node type, language, request path, current theme, and any contrib-provided condition) automatically, and also discovers module-specific plugins in `Plugin/DisplayModeSwitcherCondition/`. Cache tags, contexts, and max-age from every evaluated condition — including non-matching rules — are merged into the render array via `hook_entity_view()`, so Drupal's render cache stays correct when contexts change. A single permission, `administer display mode switcher`, gates rule management; rules are exportable configuration entities.

---

- Build a paywall: anonymous visitors see a `teaser`/`locked` mode while a subscriber role sees the `full` mode.
- Show a stripped-down `full` display to anonymous users but the complete layout to authenticated users.
- Hide premium fields from non-subscribers by switching to a display mode that omits those fields.
- Switch the display mode of a specific bundle (e.g. `article`) while leaving other bundles untouched.
- Apply a switch to all bundles of an entity type by leaving the rule's bundle empty ("match any bundle").
- Build a priority hierarchy: a high-priority subscriber rule (low weight) that keeps `full`, with a catch-all paywall rule (higher weight, no conditions) that switches everyone else.
- Use a rule with no conditions as an always-matching fallback at a high weight.
- Vary the display mode by the current user's roles using the standard `user_role` condition.
- Switch display mode based on the node bundle using the core `node_type` condition.
- Switch display mode by the current interface or content language via the `language` condition.
- Switch display mode based on the requested URL path with the `request_path` condition.
- Switch display mode depending on the active theme using the `current_theme` condition.
- Combine several conditions on one rule so the switch only fires when all of them hold true.
- Negate a condition (e.g. switch to a locked mode for everyone except the Administrator role).
- Add a project-specific condition plugin (e.g. "node has a paywall flag field set") by extending `DisplayModeSwitcherConditionPluginBase` and reading `$this->entity` directly — no Context API wiring.
- Reorder rule priority visually with the draggable rule list on the admin collection page.
- Enable or disable a rule without deleting it via the rule's Enabled checkbox.
- Export all switcher rules to YAML with `drush config:export` and deploy them across environments.
- Version-control display-mode switching logic as configuration alongside the rest of the site config.
- Keep render caching intact for role-, language-, or path-dependent switching without manual cache-tag bookkeeping.
- Target a specific entity-type + bundle + source-mode combination so only the intended renders are affected.
- Reuse any condition plugin shipped by a contrib module automatically, with no extra wiring.
