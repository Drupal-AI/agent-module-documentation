<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Twitter Username provides a dedicated field type for storing a Twitter/X username on any fieldable entity (for example a user-profile field).

---

The field type `twitter_username` stores a single `value` in a `varchar(15)` column (Twitter's 15-character limit). Its default widget `twitter_username_textfield` is a 60-size textfield with an `@` field prefix and a 15-character maxlength. Two formatters are supplied: **Default** renders `@username` as plain text via `processed_text` with the `plain_text` format, and **Link** renders `@username` as a link to `https://x.com/@username`, with a settings option to append a link type (`with_replies`, `media`, or `likes`). The README notes the module only checks syntax/length, not that the account actually exists, and creates no permissions.

Typical setup: add a field of type "Twitter username" to a content type or the user entity, choose the widget, then pick the Default or Link formatter on the display. Output is escaped through core's field render pipeline (plain-text processing and `Url::fromUri`), so stored usernames are shown safely.

---

- Add a Twitter/X username field to a content type
- Add a Twitter username field to user profiles
- Store a handle capped at Twitter's 15-character limit
- Show a username as plain `@handle` text
- Render a username as a link to the person's X profile
- Link to the profile's Replies tab (`with_replies`)
- Link to the profile's Media tab
- Link to the profile's Likes tab
- Present the field with an `@` prefix in the edit form
- Collect a social handle on a registration/profile form
- Display an author's Twitter link on article teasers
- Add a handle field to an organization/contact content type
- Keep social handles as structured field data (not free text)
- Reuse the field across multiple bundles
- Export the field's display settings in configuration
- Validate handle length via the widget maxlength
- Output handles safely via plain-text processing
- Build a "team members" listing linking each member's X profile
- Switch a field between plain-text and link display modes
