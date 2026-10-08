<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Canvas External JS lets Canvas place components implemented as external JavaScript, rather than as SDC or code inside the site.

---

Canvas builds pages from component sources — SDC, field displays, blocks. This adds another: a component whose implementation is JavaScript hosted outside Drupal. That suits a design system maintained as a front-end package, a widget shared with non-Drupal properties, or a component a separate team ships on its own release cycle.

The trade is the one every external-code integration makes. Loading a component from outside the site means the site renders code it does not version, review or control, and whoever controls that JavaScript controls what runs in the page — including anything the visitor's session can reach. That is a supply-chain decision rather than a technical one, and it deserves the same treatment a third-party script tag would get: a known origin, a change process, and ideally subresource integrity.

Worth pairing with a Content Security Policy that names the origins allowed, since an external component source is exactly what a CSP is for.

**Documented from source: `canvas` could not be kept enabled on this install.** Its
`SingleDirectoryComponentDiscovery` runs `ComponentMetadataRequirementsChecker` over **every** SDC
component on the site, and where a component's prop example maps to a field-type property expression
that does not resolve, `assert($property !== NULL)` fails. With `zend.assertions` on — the default
in DDEV and most development images — that is an uncaught `AssertionError` during container build,
so site and Drush both stop.

That was first characterised in wave 85 against `flowdrop_ui_components` and `lms`; it recurred here
against an entirely different module set, which confirms it is a property of Canvas meeting **any**
third-party SDC components rather than of one wave's particular modules. Production PHP compiles
assertions out, so it is a development-environment failure — but that is where the work happens.

---

- Place an externally hosted JS component.
- Use a design system shipped as a front-end package.
- Share a widget with non-Drupal properties.
- Let a separate team ship on its own cadence.
- Treat external components as a supply-chain decision.
- Pin the origin a component loads from.
- Apply subresource integrity.
- Name allowed origins in a CSP.
- Review changes to external component code.
- Understand what the component can reach in the page.
- Check zend.assertions before installing canvas locally.
- Diagnose the canvas SDC assertion fatal.
- Plan a component source strategy.
- Compare with SDC-based components.
- Document the module's behaviour for the team.
- Review it during a site audit.
- Verify its assumptions after an upgrade.
