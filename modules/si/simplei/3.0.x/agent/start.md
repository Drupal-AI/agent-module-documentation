# Simple Environment Indicator (simplei) — agent index

Shows a small colored environment label in the Toolbar or core Navigation top bar. Configured
**only** via `$settings` in `settings.php` — no config API, forms, permissions, Drush, or routes
(`configure` = null).

- **The settings keys and the indicator string formats** →
  [configure/settings.md](configure/settings.md)
- **The `IndicatorParser` service + how it renders (TopBarItem plugin / toolbar)** →
  [api/parser.md](api/parser.md)

Key facts:
- Setting `$settings['simple_environment_indicator']` (string) drives everything; empty/unset = no
  indicator. `$settings['simple_environment_anonymous']` (TRUE or a CSS string) also shows it to
  anonymous users.
- Service `Drupal\simplei\IndicatorParser` → `parse(string $indicator): [fg, bg, environment]`.
- `@<env>` predefined colors match the **first two letters**: `pr`/`li` → FireBrick (or `#8b0000`
  with `#access`), `st`/`te` → GoldenRod (`#59590d`), `de` → blue, else DodgerBlue (`#4a0080`).
- Rendering: TopBarItem plugin `simplei_environment_indicator` (core `navigation`) or
  `hook_page_attachments()` → `simplei/simplei` library (classic `toolbar`).
