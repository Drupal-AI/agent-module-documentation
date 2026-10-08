<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Open Y Theme Override (openy_theme_override) — agent index

Submodule of **openy_socrates**. Lets a **module override a theme's templates**.
Version **1.1.0**. Core `^10 || ^11`.

**A deliberate inversion of a core convention — name it as one.** Drupal puts the active theme last
and therefore highest; a theme can override a module's template and not the reverse. A distribution
has the opposite need: it ships functionality *and* its presentation, and a sub-theme should not
re-implement every template.

**Most of the value here is documenting that.** A site builder debugging "why is my theme's
template being ignored" on an Open Y site will not find it in the usual place, because the registry
order is not what they expect. If templates are not resolving as Drupal's documentation says, and
the site is Open Y, look here first.