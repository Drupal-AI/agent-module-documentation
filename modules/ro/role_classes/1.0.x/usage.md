<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Role Classes adds one configurable CSS class to the `<body>` tag, chosen from the current user's highest-weight role, so a theme can style by role using pure CSS.

---

The uses are ordinary presentation ones: giving editors a visual cue that they are logged in with elevated rights, hiding a marketing banner from staff, adjusting spacing where an administrative toolbar is present, or styling a members' area differently. You map a CSS class to each role on the settings form at `/admin/config/system/role-classes`; at render time the module takes the current user's roles, sorts them by weight descending, and emits the class for the single highest-weight role only — never one class per role, whatever a stale reading of the project page might imply. The class is passed through `Html::cleanCssIdentifier()` (and the form additionally validates it against a CSS-identifier regex), so a hand-edited config value cannot break the class attribute. Doing this without a module means a preprocess function per site, which is small and gets rewritten every time. Version **1.0.7** on `^10.2 || ^11 || ^12`; the permission that gates the form is core's `administer site configuration`. **The thing to say plainly is what a role class is not: it is not a way to hide anything.** A class on the body tag is a styling hook, and CSS that hides an element hides it visually while the element remains in the HTML, readable in view-source, present to a screen reader unless also removed from the accessibility tree, and available to anything that scrapes the page. Using it to keep content from a role is not a weak control — it is no control, because the content was sent. Anything that must not be seen needs entity or field access; anything that must not be reachable needs a permission. Two further points that follow from the mechanism rather than from misuse. **A body class varies by role, so the page must vary its cache by role**: the module does not itself add the `user.roles` cache context, so on a page whose cache metadata does not already carry it the first authenticated visitor's class can be cached by Dynamic Page Cache and served to another authenticated user of a different role — which for a class-driven layout means the wrong presentation. And **the class names are published**: every visitor can read the role class the site uses for them, which is unremarkable on most sites and worth a moment only where the role names themselves say something, such as `role--pending-investigation`.

---

- Style the site differently for editors.
- Hide a marketing banner from staff.
- Adjust spacing when the toolbar is present.
- Style a members' area distinctly.
- Give logged-in editors a visual cue.
- Theme by role without writing a preprocess function.
- Adjust layout for administrators.
- Style a subscriber-only section.
- Show a role-specific colour accent.
- Adjust a header for authenticated users.
- Support a role-aware design system.
- Style a training or staging environment for a testers role.
- Adjust typography for one privileged role.
- Show an editorial affordance keyed to the highest-weight role.
- Support a multi-audience theme from one codebase.
- Style a partner-portal role distinctly.
- Adjust a footer for a given role.
- Provide a single, predictable CSS hook per user tier.
- Distinguish an administrator's view during content review.
- Map a class only to the roles that need one, leaving the rest blank.
