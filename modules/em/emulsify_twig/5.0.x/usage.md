<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Emulsify Twig adds two Twig functions to Drupal — `bem()` for building BEM class names and `add_attributes()` for merging extra attributes into a template — so components written for the Emulsify design system render identically in Drupal and in Pattern Lab.

---

The module is two Twig extension classes registered as services and nothing else: no routes, no permissions, no configuration, no schema, no plugins, no dependencies beyond core. `Drupal\emulsify_twig\BemTwigExtension` registers `bem(base_class, modifiers = [], blockname = '', extra = [])`, which builds `block`, `block--modifier`, `blockname__element` and `blockname__element--modifier` class strings, appends any non-BEM "extra" classes, folds in the classes already present on the template's `attributes` object, and returns a `Drupal\Core\Template\Attribute` — while **removing** those attributes from the Twig context so they do not trickle down into `include`d templates. It also accepts a single object/array argument with `block`, `element`, `modifiers` and `extra` keys instead of positional parameters. `Drupal\emulsify_twig\AddAttributesTwigExtension` registers `add_attributes(additional_attributes = [])`, which merges an arbitrary attribute map (arrays, strings, numbers, booleans, or the `Attribute` returned by `bem()`) with the template's own `attributes`, again clearing them from the context afterwards. Both functions are declared with `needs_context: TRUE` and `is_safe: ['html']`, so they must be called from a Twig template rather than from PHP. Note the project README: this 5.0.x release is the last supported version (Drupal 10/11 only) and development continues in the separate Emulsify Tools module.

---

- Print BEM classes on a component root: `<h1 {{ bem('title') }}>` → `class="title"`.
- Add modifiers: `bem('title', ['small', 'red'])` → `title title--small title--red`.
- Namespace an element under a block: `bem('title', [], 'card')` → `card__title`.
- Combine element + modifiers: `bem('title', ['small'], 'card')` → `card__title card__title--small`.
- Append non-BEM utility or JS hook classes: `bem('title', '', '', ['js-click'])`.
- Pass a config object instead of positional args: `bem({block: 'title', element: 'card', modifiers: ['big']})`.
- Keep Drupal's own `attributes` (id, data-*, contextual links) while adding BEM classes.
- Stop parent `attributes` from leaking into `{% include %}`d child templates.
- Merge extra attributes into a wrapper: `<div {{ add_attributes({class: ['foo'], 'data-x': 'y'}) }}>`.
- Feed `bem()` output straight into `add_attributes({class: bem('foo', ['bar'], 'block')})`.
- Share the same component Twig files between Pattern Lab/Storybook and Drupal templates.
- Build a design-system theme where every component template owns its class naming.
- Add a state modifier conditionally: `bem('button', [isActive ? 'active'])`.
- Give field templates predictable component classes without preprocess code.
- Attach `data-` attributes to a paragraph wrapper from the template layer.
- Set an `aria-*` attribute alongside merged classes in one call.
- Migrate a legacy theme to BEM naming template by template.
- Render list items with per-item modifiers from a loop variable.
- Keep markup consistent between an Emulsify starter kit and a custom subtheme.
- Avoid `{{ attributes.addClass(...) }}` chains in favour of a single `bem()` call.
- Drop the module in as a dependency of an Emulsify-based theme with zero configuration.
- Plan a migration path to Emulsify Tools, the module's stated successor.

