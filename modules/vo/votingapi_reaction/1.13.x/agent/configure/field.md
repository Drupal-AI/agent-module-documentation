<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Voting API Reaction

There is **no global settings page** (`configure` null). You configure three things: the field (per
bundle), the formatter (per view display), and the reactions themselves (Voting API vote types).

## 1. Add the field

On a bundle's **Manage fields**, add a field of type **Reaction** (`votingapi_reaction`). Cardinality is
forced to 1 (the storage form hides the cardinality control). Widget & formatter are
`votingapi_reaction_default`.

### Field settings (`defaultFieldSettings`, schema `field.field_settings.votingapi_reaction`)

| Setting | Default | Meaning |
|---|---|---|
| `anonymous_detection` | `[1, 2]` (cookie + IP) | How anonymous voters are recognised. `1` = By cookies (`BY_COOKIES`), `2` = By IP (`BY_IP`). |
| `anonymous_rollover` | `-1` (Voting API default) | Window before an anonymous user may react again. `-1` (`VOTINGAPI_ROLLOVER`) defers to `votingapi.settings:anonymous_window`; `-2` (`NEVER_ROLLOVER`) = never; or a seconds value. |
| `reactions` | all six defaults | Which reactions are available and their `show`/`weight`. |

### Per-entity field value: `status` (schema `field.value.votingapi_reaction`)

Each entity's field stores a `status` integer controlling reactions on that item:
`0` = **Hidden** (`HIDDEN`), `1` = **Closed** (`CLOSED`, shown read-only), `2` = **Open** (`OPEN`).
Set on the entity edit form (like core comment status).

## 2. Formatter settings (`defaultSettings`, schema `field.formatter.settings.votingapi_reaction_default`)

| Setting | Default | Meaning |
|---|---|---|
| `show_summary` | `TRUE` | Show the "N reactions" summary line. |
| `show_icon` | `TRUE` | Render each reaction's icon. |
| `show_label` | `TRUE` | Render the reaction label. |
| `show_count` | `TRUE` | Render per-reaction count. |
| `sort_reactions` | `'none'` | `none` = by configured weight; `asc`/`desc` = by vote count. |
| `reactions` | — | Per-formatter reaction visibility overrides. |

## 3. Define reactions (Voting API vote types)

Reactions are **`vote_type` entities**. Go to Voting API's vote-types admin and add/edit a type; this
module (`hook_form_alter` in `votingapi_reaction.module`) adds:

- **Use as a Reaction** (`reaction`, bool) — only reaction-flagged vote types appear as reactions.
- **Icon type** (`icon_type`): `uploaded_image` (a `managed_file`, extensions svg/png/webp, stored to
  `public://votingapi_reaction` as a permanent file id in `uploaded_image`), `remote_image` (a URL in
  `remote_image`), or `html_element` (`i`/`span`/`div` in `html_element`).
- **Icon class** (`icon_class`) — CSS class added to the img/element (use with an icon font).

Stored as vote-type third-party settings (`votingapi.vote_type.*.third_party.votingapi_reaction`). Six
defaults ship as SVGs in `svg/` (`reaction_like`, `reaction_love`, `reaction_laughing`,
`reaction_angry`, `reaction_sad`, `reaction_surprised`); their images can't be removed (only replaced).
Deleting a reaction vote type also deletes its uploaded icon file (`hook_entity_delete`).

## How a reaction is cast

The formatter renders `VotingApiReactionForm` (AJAX radios). Selecting a reaction creates a `vote`
entity for the current user (or switches/removes it if the same one is chosen), remembers it (session
for anonymous), and calls `VotingApiReactionManager::recalculateResults()`. All of this is subject to
the per-field permissions — see [../permissions/permissions.md](../permissions/permissions.md).

## Programmatic access

Service `votingapi_reaction.manager` (`VotingApiReactionManager`) exposes `lastReaction()`,
`getResults()`, `allReactions()`, `getReactions()`, `recalculateResults()`, and the icon-URL helper
`getUploadedImage()`. Reactions are ordinary Voting API votes, so Voting API result functions/queries
work as usual.
