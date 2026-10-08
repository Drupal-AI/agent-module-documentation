<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rocketship Theme Generator (rocketship_theme_generator) — agent index

**Developer scaffolding tool that generates component-based subthemes for Dropsolid Rocketship.**

- **Version:** 4.0.x
- **Core:** ^9.5 || ^10
- **Depends:** responsive_image, components, unified_twig_ext
- **Package:** Rocketship

**Surface:** one helper `rocketship_theme_generator_generate_theme_extention()` → `src/ThemeExtentionGenerator.php`, bundled `templates/` and `scripts/`. No routes, permissions, services, config.

**Security:** developer/build-time tool that writes theme files to disk; no runtime request surface. Intended for local development, not production.
