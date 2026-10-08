<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Voting API Reaction — agent index

A Field-API field (`votingapi_reaction`) that lets users react to any entity, backed by the Voting API
module. Reactions = Voting API **vote types** flagged "Use as a Reaction" with an icon. Depends on
`votingapi` + core `file`. No configure route (config is per field/formatter/vote-type). Config schema
yes; permissions yes (dynamic); no Drush; no new plugin type.

- **Create the field, field & formatter settings, per-entity status, and defining reactions (vote types + icons)** →
  [configure/field.md](configure/field.md)
- **The dynamic per-field permissions and how the AJAX reaction form checks them** →
  [permissions/permissions.md](permissions/permissions.md)
- **The `votingapi_reaction_item` theme hook / template variables** →
  [theming/template.md](theming/template.md)

Key facts:
- Field type `votingapi_reaction`; default widget & formatter both `votingapi_reaction_default`.
  Cardinality forced to 1 (`hook_form_FORM_ID_alter` on `field_storage_config_edit_form`).
- Reactions are `vote_type` entities with third-party settings under `votingapi_reaction`
  (`reaction`, `icon_type` = uploaded_image|remote_image|html_element, `icon_class`, `uploaded_image`
  (file id), `remote_image` (URL), `html_element`). Six SVG defaults shipped in `svg/`.
- Casting a reaction = `src/Form/VotingApiReactionForm.php` (AJAX radios over the `vote` entity):
  creates / switches / deletes the user's vote, then recalculates Voting API results.
- Service `votingapi_reaction.manager` (`VotingApiReactionManager`): last-reaction lookup, results,
  rendering, and `$_SESSION`-based anonymous tracking.
- Anonymous handling in field settings: `anonymous_detection` (cookie=1 / IP=2) + `anonymous_rollover`.
- Per-entity `status`: Hidden (0) / Closed (1) / Open (2).
