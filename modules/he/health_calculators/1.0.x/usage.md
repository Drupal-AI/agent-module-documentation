<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Body Health Calculators is an umbrella package whose submodules add front-end health-metric calculators (this release ships the Caffeine Calculator).
---
The top-level `health_calculators` module carries no functionality of its own — its `.module` file is empty and it exposes no routes, permissions, services or config. It exists as a parent/package (`BodyHealthCalculators`) that groups one or more calculator submodules and acts as their dependency. The actual behaviour lives in the bundled submodule.

In this version the only submodule is **Caffeine Calculator** (`caffeine_calculator`), a public calculator form that estimates caffeine intake. Enable the submodule you want; enabling it pulls in this parent automatically.

Setup: enable `health_calculators` plus the desired calculator submodule (e.g. `caffeine_calculator`).
---
- Install the health-calculators package as a base for calculator submodules.
- Enable the Caffeine Calculator submodule for a public caffeine-intake tool.
- Group related health tools under one project/package.
- Satisfy the dependency required by `caffeine_calculator`.
- Provide a namespace for future health-metric calculators.
- Keep calculator submodules versioned together.
- Offer visitors self-service health assessment tools.
- Add wellness widgets to a health or lifestyle site.
- Bundle calculators for an educational health resource.
- Enable only the specific calculators a site needs.
- Use as the umbrella when adding more calculators later.
- Document available calculators for editors.
- Serve as the parent module for nested calculator submodules.
- Provide a consistent package label in the module list.
- Combine with theming to style the calculator front end.
