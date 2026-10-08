<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Voting API Reaction adds a Field-API field that lets users react to any entity (like Facebook/Disqus reactions), backed by the Voting API module, with per-field reaction sets, per-entity open/closed state, configurable anonymous handling, and customisable reaction icons.

---

The module defines a `votingapi_reaction` **field type** with a matching widget
(`votingapi_reaction_default`) and formatter (`votingapi_reaction_default`); attach the field to any
bundle to enable reactions there. Reactions themselves are **Voting API vote types**: the module
extends the vote-type add/edit form (`hook_form_alter`) with a "Use as a Reaction" toggle and icon
settings (uploaded image via managed_file, remote image URL, or an HTML element + CSS class), stored as
vote-type third-party settings; it ships six default reactions (angry, laughing, like, love, sad,
surprised) as SVGs. When a reaction is cast, the formatter renders an AJAX radio form
(`src/Form/VotingApiReactionForm.php`, a `ContentEntityForm` over the `vote` entity) that creates,
switches, or removes the current user's vote and recalculates Voting API results. Access is enforced by
**dynamic per-field permissions** (`view` / `create` / `modify` / `control status`, one set per
entity-type:bundle:field). Field settings control which reactions are available, their weight/visibility,
and anonymous-user handling (detect by cookie and/or IP, plus a rollover window that can defer to Voting
API's `anonymous_window`). Formatter settings toggle the summary, icon, label and count and choose sort
order (by weight or by count). Each entity also carries a per-item **status** (Hidden / Closed / Open)
so reactions can be turned off on individual entities. Cardinality is forced to 1. A `VotingApiReactionManager`
service centralises loading the last reaction, computing results, rendering reaction items, and
session-based anonymous tracking; output is themed via the `votingapi_reaction_item` template.

---

- Add Facebook-style reactions (like/love/laugh/…) to nodes, comments, or any entity.
- Let users pick one reaction per entity and switch or remove it via AJAX.
- Show a reaction summary count ("12 reactions") above the reaction buttons.
- Restrict which reactions are available on a given field (e.g. only like + love).
- Reorder reactions by weight, or auto-sort them by popularity (count).
- Create custom reactions as Voting API vote types with your own icons.
- Upload an SVG/PNG/WebP icon for a reaction, or point at a remote image URL.
- Use an HTML element + icon-font class (Font Awesome, etc.) as a reaction icon.
- Allow anonymous users to react, tracked by cookie and/or IP address.
- Set a rollover window so anonymous reactions expire (or defer to Voting API settings).
- Open, close, or hide reactions on a specific entity via the field value's status.
- Grant view/add/modify reaction permissions per field to specific roles.
- Display reaction counts per reaction type on an entity.
- Hide the icon, label, or count independently via formatter settings.
- Build a "was this helpful?" style widget on documentation pages.
- Add emoji reactions to forum posts or comments.
- Aggregate sentiment on content using Voting API result functions.
- Theme the reaction markup by overriding `votingapi-reaction-item.html.twig`.
- Anonymise anonymous voters' IPs for GDPR compliance (Voting API feature).
- Reuse the six shipped default reactions or replace them entirely.
- Let editors moderate reactions by controlling per-entity reaction status.
- Provide lightweight engagement metrics without a full commenting system.
