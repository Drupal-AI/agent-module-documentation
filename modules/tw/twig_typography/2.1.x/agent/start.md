<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Twig Typography (twig_typography) — agent index

Registers a single Twig **filter** `typography` that runs text (or a render array) through the
`mundschenk-at/php-typography` library: smart quotes, en/em dashes, ellipses, hyphenation, widow
prevention, unit gluing, and CSS-hook spans. Applied in templates, so stored content is unchanged.
No settings page, no permissions, no drush, no plugins, no config entity — the only surface is the
filter and its defaults file.

- Core: `^10 || ^11`. Composer: `mundschenk-at/php-typography ^6.0.0`. Package `Other`.
- `configure`: none (defaults come from a per-theme YAML file, not admin UI).
- Submodule: `twig_typography_test` (test-only helper: theme + demo route `/twig-typography-test`).

Solution docs:
- **Apply the filter in a template, pass inline overrides, and set per-theme defaults** → [theme/typography-filter.md](theme/typography-filter.md)

Key facts (real machine names):
- Service: `twig_typography.twig_extension` — class `Drupal\twig_typography\TwigExtension\Typography`, tagged `twig.extension`, constructor arg `@renderer`.
- Twig extension name: `typography.twig_extension`.
- Filter: `typography` (the only filter; no Twig functions defined).
- Entry method: `Typography::applyTypography($string, array $arguments = [], $use_defaults = TRUE)`.
- Library classes used: `PHP_Typography\PHP_Typography`, `PHP_Typography\Settings`.
- Argument keys are literal `PHP_Typography\Settings` method names (e.g. `set_dewidow`, `set_classes_to_ignore`, `set_tags_to_ignore`, `set_style_hanging_punctuation`).
- Per-theme defaults file: `typography_defaults.yml` in the **active theme root** (example shipped as `typography_defaults.example.yml`).
