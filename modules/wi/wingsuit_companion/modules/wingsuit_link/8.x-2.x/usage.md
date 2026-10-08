<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Wingsuit Link connects the UI Patterns Settings link widget to the Link Attributes module, so a link supplied to a component can carry classes, targets and rel values.

---

A component that takes a link almost always needs more than a URL and a label. A button component wants a variant class; an outbound link wants `rel="noopener"` when it opens in a new tab; a tracked link wants a data attribute. Without somewhere to put those, they get hard-coded into the component or hacked in from the theme.

This submodule gives the link setting on a pattern the full Link Attributes widget, so whoever configures the component chooses those values in the UI. The component template then renders them, and the design system stays declarative.

It is a small piece of ergonomics with a security-adjacent detail worth naming: `target="_blank"` without `rel="noopener"` gives the opened page a handle on yours. Making `rel` settable at the point where the link is configured is what lets that be set correctly rather than remembered.

---

- Add classes to a link in a component.
- Set a link target from the component settings.
- Add rel="noopener" to an outbound component link.
- Add a tracking attribute to a link.
- Give a button component a variant class.
- Avoid hard-coding link attributes in a template.
- Configure link behaviour in the UI.
- Keep the design system declarative.
- Reuse Link Attributes' widget in patterns.
- Standardise outbound link handling.
- Add rel="nofollow" where required.
- Support a design system's link variants.
- Audit link attributes across components.
- Fix a component that opens links unsafely.
- Let a site builder set link behaviour without code.