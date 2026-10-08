<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Minimal HTML provides a minimal WYSIWYG text format well suited for admin-configurable text areas.

---

Minimal HTML provides a minimal WYSIWYG text format — a lightweight, restricted rich-text format
suitable for admin-configurable text areas (settings, small content bits) where only basic formatting
(bold, links, lists) is needed rather than a full editor. It ships a `minimalhtmltitle` submodule and is
configured via the text-format admin. This gives admins a safe, limited formatting option for config text.

Use it for small formatted text where a full WYSIWYG is overkill. It is a content-editing/text-format
feature; because it is a *restricted* format (limited allowed tags), it is the safer choice for
admin/config text areas (less XSS surface than a permissive format). As with any text format, the allowed
tags determine the XSS surface — keep it minimal. It has no access-control role. Use the format on the
relevant text areas.

---

- Provide a minimal WYSIWYG format.
- Suit admin-configurable text areas.
- Allow only basic formatting.
- Ship a minimalhtmltitle submodule.
- Configure via text-format admin.
- Give a safe limited format.
- Reduce XSS surface with limited tags.
- Use for small formatted text.
- Have no access-control role.
- Keep the allowed tags minimal.
- Provide restricted rich text.
- Format config text safely.
- Use where full WYSIWYG is overkill.
- Allow bold/links/lists.
- Configure the format.
- Provide a lightweight editor.
- Format admin text areas.
- Limit formatting.
- Use a minimal format.
- Provide safe formatting.
