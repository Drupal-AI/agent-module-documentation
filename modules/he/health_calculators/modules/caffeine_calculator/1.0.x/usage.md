<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Caffeine Calculator is a public form that estimates a visitor's caffeine intake from a selected drink, amount, age range, weight and medical conditions.
---
The module exposes a front-end form at `/body-calculators/caffeine-calculator` (permission `access content`) built by `CaffeineCalculatorForm`. The visitor selects a drink (an AJAX callback shows its caffeine-per-100ml), enters a drink amount, age range, medical condition and weight (kg/lb), and the AJAX submit computes both a recommended daily caffeine limit and the caffeine in their drink, rendered inline. The drink list and an intro help text are admin-configurable via the settings form at `/admin/config/tools/caffeine-calculator` (permission `Administer Caffeine Calculator`), which stores a `drink_name|caffeine_amount` list into `caffeine_calculator.settings`.

The calculator is purely computational: it reads config and form input, does arithmetic, and displays a result — it stores no submission and touches no other content. The public route is intentionally open (`access content`); the admin settings route is permission-gated. The configured `help_text` is rendered through `#markup` (admin-only input, auto-filtered by Drupal). No external calls, secrets or mutation of site data.

Setup: enable the module, then on the settings form adjust the drinks list and help text; the front-end form errors out until at least one drink is configured (a default list ships with install).
---
- Give visitors a caffeine-intake calculator page.
- Select a drink and see its caffeine content per 100 ml.
- Enter a custom drink amount in millilitres.
- Compute the recommended daily caffeine limit by age range.
- Adjust the limit for pregnancy or cardiovascular conditions.
- Enter weight in kilograms or pounds (auto-converted).
- Show the caffeine amount in the visitor's chosen drink.
- Edit the drinks-and-amounts list on the settings form.
- Provide intro help text above the calculator.
- Restrict settings changes with `Administer Caffeine Calculator`.
- Keep the calculator public via `access content`.
- Ship a default drinks list on install (espresso, latte, teas, …).
- Style the calculator with the bundled CSS/JS library.
- Add a wellness tool to a health or lifestyle site.
- Use for educational demonstrations of caffeine limits.
- Reset/replace the drink list per site.
- Localise the calculator (Arabic translation shipped).
- Display results inline via AJAX without page reload.
