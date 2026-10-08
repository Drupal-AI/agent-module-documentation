<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Body Inject renders a selected Drupal block inside a node's body field, placed at a paragraph or character position when the body matches an optional length condition.

---

Body Inject lets a site administrator define reusable "profiles" (config entities of type
`body_inject_profile`) that each pick one **block** (any UI-placeable block plugin or custom block),
a target **node type**, an optional **condition** on the body's paragraph and/or character count, and
a **placement** (offset from the middle, after N paragraphs, or after N characters). On every full
view of a matching node, `hook_entity_view_alter()` renders that block and splices its markup into the
already-rendered body HTML. It is aimed at inserting in-article ad units, announcements, promotions,
or boilerplate globally without editing each node. Profiles are managed at
`/admin/config/content/body_inject` behind the `administer body_inject profiles` permission. The
project's composer metadata requires `drupal/token_block`, and only nodes rendered in the `full` view
mode (including the Layout Builder body block) are affected.

---

- Insert an in-article advertising block (AdSense-style `<ins>` snippet) roughly in the middle of long articles.
- Place an ad unit after exactly N paragraphs of a body field.
- Place a block after roughly N characters of body text (snapped to the nearest paragraph boundary).
- Offset the mid-article insertion up or down by a set number of paragraphs.
- Add a promotional call-to-action block into every node of a given content type.
- Inject a site-wide announcement or notice into article bodies without editing each node.
- Append related-content or "read next" blocks inside long-form content.
- Restrict injection to bodies with *more than* a paragraph count (skip short posts).
- Restrict injection to bodies with *less than* / *exactly* a character count.
- Combine paragraph and character conditions with AND / OR logic.
- Always inject (leave both condition fields blank) into a chosen node type.
- Run different profiles for different node types simultaneously.
- Inject a custom block created just for advertising markup (dedicated text format recommended).
- Inject a plugin-provided block (system, views, or contrib block) into article bodies.
- List, add, edit, and delete injection profiles from a single admin collection page.
- Give each profile a human-readable label and description for the admin listing.
- Insert boilerplate legal/disclaimer content mid-body across a content type.
- Add multiple injections into the same node by defining several profiles for one node type.
- Target only the canonical node page render (the `full` view mode), leaving teasers/search results untouched.
- Support bodies rendered through Layout Builder's node body block.
