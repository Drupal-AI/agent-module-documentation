<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# layout_builder_operation_link — agent start

Adds one **Layout** operation link (key `layout`, title "Layout", weight 50) to the operations
dropbutton of any entity whose bundle has Layout Builder enabled **with overrides**, linking to
`layout_builder.overrides.<entity_type>.view`. Pure behavior via `hook_entity_operation()`:
**no config UI, no settings, no permissions, no schema, no Drush, no plugins** (`configure` is
`null`). Depends on core `layout_builder`. The only "setup" is enabling Layout Builder overrides
on a bundle; the link is access-gated so it shows only to users who can edit that entity's layout.

- Make the link appear (enable LB overrides on a bundle via UI or drush), where it shows, the
  route/title/weight, visibility conditions, translation handling, "no module settings" →
  [configure/layout_builder_operation_link.md](configure/layout_builder_operation_link.md)
- How the link is generated and how to alter, remove, reweight, or relabel it
  (`hook_entity_operation_alter`), the `preprocess_links` destination workaround, cache tags →
  [extend/layout_builder_operation_link.md](extend/layout_builder_operation_link.md)
