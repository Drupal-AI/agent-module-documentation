<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Textarea Limit puts a live "N of M characters remaining" counter on selected long-text
textarea widgets, so an editor filling a summary or teaser can see when they have run over the
length a design allows.

---

Length constraints on body-style fields are usually a design requirement rather than a data
one: a teaser must fit a card, a meta description must fit a search result, a strapline must
not wrap onto three lines. Drupal's field settings offer no maximum on textareas, so the rule
ends up as a note in a style guide nobody reads while typing. This module makes it visible.
You opt a widget in on the entity's Manage form display page — it targets the `string_textarea`
and `text_textarea` widgets — and pick either a fixed per-widget character limit or a shared
global limit set at `/admin/config/content/textarea-limit` (config `textarea_limit.settings`,
behind the `administer textarea_limit` permission). At render time the module attaches a small
jQuery counter (the external `jquery.limit` plugin) and a "characters remaining" suffix under
the field. One thing to be explicit about when recommending it: this is an editorial aid, not
validation. The counter is JavaScript and there is no server-side length check, field
constraint, or `maxlength` — anything that submits without running the script (a programmatic
save, a migration/import, a REST or JSON:API write) is unaffected. Where the limit must
actually hold, pair it with a server-side constraint on the field. It depends only on core with
a range of `^9 || ^10 || ^11`. Compare `maxlength`, which covers similar ground; do not run
both on the same widget.

---

- Show editors a live character countdown while they type into a textarea.
- Limit a teaser or summary field to a card's length.
- Keep meta-description text within search-result length.
- Stop straplines wrapping onto three lines.
- Make a style guide's length rule visible at the point of writing.
- Apply a fixed character limit to one specific textarea widget.
- Share one global limit across many widgets at once.
- Constrain a caption or excerpt field.
- Guide authors of a social-sharing blurb to stay within limits.
- Reduce design breakage caused by over-long editorial text.
- Add a limit without writing code, from Manage form display.
- Change the site-wide limit in one settings form.
- Delegate limit tuning to an editorial lead via a dedicated permission.
- Show remaining characters as immediate feedback under the field.
- Support a fixed-height component design that assumes short copy.
- Cut down on editorial review comments about text length.
- Improve length consistency across a content type.
- Apply different limits to different widgets on the same form.
- Set a per-widget limit that overrides the global default.
- Override the counter markup by re-theming `textarea_limit_remaining`.
- Nudge authors toward concise summaries in a redesign.
- Mirror the counter script locally to avoid an external asset request.
