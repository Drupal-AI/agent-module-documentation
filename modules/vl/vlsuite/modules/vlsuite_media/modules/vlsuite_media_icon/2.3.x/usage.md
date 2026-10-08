<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VLSuite Media Icon defines the icon media type components draw on.

---

Treating icons as media rather than as a font or as pasted markup gives them the same management as everything else: a library to pick from, one entity per icon, and a replacement that propagates.

It complements rather than replaces `vlsuite_icon_font` — a font suits a fixed UI vocabulary, media suits icons that are content, such as a partner logo set or a set of category markers that editors manage.

The accessibility question is the same as for any icon and depends on the role: an icon that conveys information needs an accessible name, an icon that decorates text does not and should be hidden. Where icons are media, that name usually comes from the media entity, which makes it worth setting properly once rather than per placement.

---

- Manage icons as media entities.
- Pick an icon from the media library.
- Replace an icon everywhere at once.
- Manage a set of category markers.
- Manage partner logos as icons.
- Complement the icon font with media icons.
- Set an accessible name on an icon entity.
- Hide a decorative icon from screen readers.
- Let editors manage the icon set.
- Audit which icons are in use.
- Translate icon labels.
- Distinguish UI icons from content icons.
- Use icons in components consistently.
- Retire an unused icon.
- Standardise icon storage.
