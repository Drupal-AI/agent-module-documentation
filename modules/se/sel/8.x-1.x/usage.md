<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple External Links (sel) opens external links in a new window, adding target handling to outbound links.

---

Opening external links in a new tab is a common wish. SEL adds that to outbound links. As with any target-attribute feature, the tabnabbing note applies: a link with target=_blank lets the opened page access window.opener unless rel=noopener is set — modern browsers apply noopener implicitly for target=_blank (since ~2021), so this is largely mitigated, but if you support older browsers, ensure noopener is added. It marks/handles external links; confirm it applies to the links you intend.

---

- Open external links in a new window.
- Add target to outbound links.
- Handle external links.
- Mark links leaving the site.
- Rely on implicit noopener.
- Add noopener for old browsers.
- Confirm which links get target.
- Improve external-link UX.
- Open outbound links in a tab.
- Apply to external links.
- Enable when needed.
- Keep disabled otherwise.
- Restrict administration.
- Confirm on your site.
- Test before production.
- Review configuration.
- Pair with related modules.
- Verify theme fit.
- Match your use case.
- Confirm compatibility.
- Use deliberately.
- Review after upgrades.