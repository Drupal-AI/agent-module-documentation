<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Outbound provides a link field formatter that forwards the user to an outbound page warning they are leaving the site.

---

Outbound provides a link-field formatter that routes clicks through an interstitial "outbound" page —
warning the user they are leaving your site before continuing to the external destination, common on
government/institutional sites for external-link disclaimers. It depends on core Link.

Use it to add leaving-site interstitials to external links. It is a content-display/formatter feature; the
destination URL comes from the link field (editor-set). Note: the interstitial redirects to the field's URL —
since the destination is authored by editors, it's editor-trusted, but if link fields can be set by
less-trusted users, treat the eventual redirect as you would any editor-supplied URL. It has no access-control
role. Select the outbound formatter on the link field.

---

- Route external links through an interstitial.
- Warn users they are leaving the site.
- Add external-link disclaimers.
- Depend on core Link.
- Show a 'leaving site' page.
- Continue to the external destination.
- Note the destination is the field's (editor-set) URL.
- Treat editor-supplied URLs appropriately.
- Have no access-control role.
- Select the outbound formatter.
- Handle outbound links.
- Add interstitials.
- Warn on external links.
- Configure the formatter.
- Show leaving-site warnings.
- Handle the interstitial.
- Add link warnings.
- Configure outbound.
- Handle external links.
- Route through interstitial.
