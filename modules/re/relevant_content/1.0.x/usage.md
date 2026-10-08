<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Relevant Content

Relevant Content shows visitors other content similar to the page they are on, based on shared
taxonomy terms. Site builders create one or more **Relevant Content Preset** configuration
entities (each choosing which node types and vocabularies to consider and a maximum result
count); each preset produces a block derivative that can be placed on node pages.

At render time the block reads the current node's terms (optionally filtered to the preset's
vocabularies), then queries for published nodes of the allowed types that share those terms,
ranked by the number of matching terms (then by recency). A `TermAlter` event lets other
modules add or change the terms used for matching.

---

## Installation & configuration

- Requires core `node`, `taxonomy`, and `block`.
- Install with `drush en relevant_content`.
- Manage presets at *Configuration → Search → Relevant Content* (permission
  *administer relevant content*).
- For each preset choose enabled content types, enabled vocabularies, and max results.
- Place the preset's block (found under the *Relevant Content* category) on the desired node
  displays; it uses the node route context.
- Subscribe to `TermAlter::ALTER` (`relevnt_content.term_alter`) to customise matched terms.

---

## Use cases

- Show "related articles" based on shared tags on blog/news nodes.
- Recommend similar products or resources by shared taxonomy.
- Increase engagement and time-on-site with contextual suggestions.
- Configure different related-content rules per section via multiple presets.
- Restrict recommendations to specific content types.
- Restrict matching to a single vocabulary such as "Tags".
- Cap the number of suggestions shown per block.
- Rank suggestions by relevance (most shared terms first).
- Fall back gracefully when a node has no matching content.
- Alter matched terms programmatically via the TermAlter event.
- Surface evergreen content alongside recent matches.
- Build "you might also like" blocks without writing Views.
- Reuse one preset across many node types and pages.
- Keep block derivatives in sync as presets are saved/deleted.
- Exclude the current node automatically from its own suggestions.
- Provide editors a no-code related-content feature.
