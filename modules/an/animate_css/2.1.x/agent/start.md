<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Animate CSS — agent index

Integrates the **animate.css** v4 library. On every page it attaches one asset library
(`animate_css/animate`) whose CSS lives at `/libraries/animate.css/animate.css`. You trigger
animations by adding classes to markup — **no** settings form, configure route, permissions,
plugins or config. `configure: null`.

- **How it attaches the library, class names to use, library install path, requirements check** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- Attached globally via `hook_page_attachments()` → `$attachments['#attached']['library'][] = 'animate_css/animate'`.
- v4 usage: `class="animate__animated animate__<effect>"` (e.g. `animate__bounce`, `animate__fadeInUp`);
  utilities `animate__delay-2s`, `animate__slow`, `animate__infinite`.
- External library dependency: Composer package `drupal-shimmy/animate.css` 4.1.1 → `web/libraries/animate.css/animate.css`.
- `hook_requirements()` flags an error on the status report if that file is missing.
