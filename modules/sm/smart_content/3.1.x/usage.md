<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Smart Content is an API and toolset for real-time, client-side personalization. Site builders define Segments as groups of Conditions (browser, device, cookie, UTM, time, etc.), collect them into a Segment Set, and attach a Reaction to each segment inside a Decision. At page load the module renders a placeholder plus JS settings; a browser agent evaluates the conditions client-side, picks the first matching segment, and fetches that segment's Reaction over an AJAX endpoint keyed by a per-instance UUID token, so the host page stays cacheable.

Use it as the foundation for on-site personalization and lightweight A/B/segment targeting. Everything is pluggable (condition, condition-type, condition-group, reaction, decision, decision-storage, segment-set-storage), and it is extended by sibling projects (block and browser ship in-package; datalayer, A/B, UTM, Demandbase, 6sense, and others are separate).

---

Enable Smart Content plus the bundled `smart_content_block` (Decision Block + Block reaction) and usually `smart_content_browser` (browser/device conditions). Reusable global Segment Sets are managed at `/admin/structure/smart-content` behind permission `administer smart content`. Personalization is authored by placing a Decision Block (Block Layout or Layout Builder) and, per segment, configuring conditions and the block(s) to display; optionally mark one segment as the default.

At runtime a decision renders a placeholder carrying a UUID token stored via a decision-storage plugin (`config_entity` or `content_entity`); browser JS evaluates segments and GETs `/ajax/smart_content/{decision_storage}/{token}/{reaction}` (permission `access content`). `ReactionController` validates that token and reaction are UUIDs, rebuilds the decision from the token, and returns the winning reaction's AJAX response (a `ReplaceCommand` swapping the placeholder for the reaction's rendered blocks). Custom personalization is added by writing plugins and, for client evaluation, registering JS `Field`/`ConditionType` handlers. Conditions are evaluated in the browser and must not be used as server-side access control.

---

- Personalize content for anonymous and authenticated visitors.
- Define segments from reusable condition plugins (browser, device, cookie, UTM, time).
- Group conditions with AND/OR operators and per-condition negation.
- Evaluate decisions client-side so host pages stay cacheable.
- Swap block content as a reaction to a matching segment.
- Fetch reactions over an AJAX endpoint keyed by a per-instance UUID token.
- Store decisions via pluggable backends (config entity or revisionable content entity).
- Reuse a Global Segment Set across many Decision Block placements.
- Author personalization inline on a single Decision Block placement.
- Place Decision Blocks via Block Layout or Layout Builder.
- Mark a default segment shown when no segment matches.
- Extend with custom condition plugins (server + JS field collector).
- Provide condition-type widgets (textfield, number, select, boolean, key/value, array).
- Extend with custom reaction plugins that return AJAX responses.
- Add custom decision, decision-storage, or segment-set-storage plugins.
- Alter the client settings payload via the `attach_decision_settings` event.
- Combine multiple Decision Blocks on one page.
- Broadcast a `smart_content_decision` browser event when a segment wins.
- Use browser localStorage (bin `_scs`) for cookie/UTM-style condition data.
- Feed personalization signals to analytics via the datalayer sibling module.
- Build A/B/multivariate tests on top of segments with the A/B sibling module.
- Gate all administration behind the `administer smart content` permission.
- Pass context params to context-aware reactions via `_sc_context_*` query keys.
- Keep decisions in sync across config import via the added import step.
