<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Caffeine Calculator (caffeine_calculator) — agent index

**Public form estimating caffeine intake from drink, amount, age, weight and medical condition; drinks list is admin-configurable.**

- **Version:** 1.0.x
- **Core:** `^9 || ^10`
- **Parent:** `health_calculators`
- **Routes:** `caffeine_calculator.form` → `/body-calculators/caffeine-calculator` (perm: `access content`); `caffeine_calculator.settings_form` → `/admin/config/tools/caffeine-calculator` (perm: `Administer Caffeine Calculator`)
- **Config:** `caffeine_calculator.settings` (`drinks[]`, `help_text`).
- **Forms:** `CaffeineCalculatorForm` (front end), `SettingsForm` (admin).

**Security:** front-end calculator is intentionally public (`access content`), computes-only, stores nothing, no external calls. Admin drinks/help settings are permission-gated; `help_text` renders via `#markup` (admin-only, filtered). See [configure/caffeine-calculator.md](configure/caffeine-calculator.md).
