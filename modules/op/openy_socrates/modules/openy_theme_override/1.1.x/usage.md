<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Open Y Theme Override lets a module override a theme's templates, inverting Drupal's usual precedence.

---

Drupal's template resolution puts the active theme last and therefore highest: a theme can override any module's template, and a module cannot override a theme's. That is the right default — a site's theme should have the final say on presentation.

A distribution has the opposite problem. Open Y ships functionality *and* the presentation that goes with it, and a sub-theme built on the distribution's base theme should not have to re-implement every template the distribution provides. This module gives distribution modules a way to supply templates that take precedence where they need to.

**That is a deliberate inversion of a core convention, and it is worth naming as one.** The consequence is that a site builder debugging "why is my theme's template being ignored" on an Open Y site will not find the answer in the usual place — the theme registry order is not what they expect, because a module has been given precedence.

Documenting that is most of the value here. If templates are not resolving the way Drupal's documentation says they should, and the site is Open Y, this is the module to look at first.

---

- Let a distribution module supply templates.
- Override a theme template from a module.
- Avoid re-implementing distribution templates in a sub-theme.
- Ship functionality with its presentation.
- Debug a template that is being ignored.
- Understand inverted template precedence.
- Check the theme registry on an Open Y site.
- Explain unexpected template resolution.
- Plan a sub-theme on an Open Y base.
- Audit which templates a module overrides.
- Decide where presentation should live.
- Recognise a deliberate convention inversion.
- Trace template resolution order.
- Document this component's conventions for the team.
- Review it during a component audit.
- Verify its behaviour after a theme change.
