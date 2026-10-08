<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Twig capture (twig_capture) — agent index

**Twig extension that captures a `|render` result used in an `{% if %}` test so the same value isn't rendered again in the output.**

- **Version:** 1.0.x (release 1.0.3)
- **Core:** ^10 || ^11
- **Service:** `twig_capture.twig.translate_extension` (`TwigCaptureExtension`, tagged `twig.extension`), providing `TwigCaptureNodeVisitor` (+ `TwigCaptureCompiler`).
- **What it does:** rewrites `{% if foo|render %}` into `{% set foo_rendered = foo|render %}{% if foo_rendered %}` and later `{{ foo }}` into `{{ (foo_rendered is defined) ? foo_rendered : foo }}`, at compile time.
- **Config:** none — zero-configuration, automatic once enabled.
- **Security:** No routes, permissions, forms or config; a compile-time Twig transform only, no request handling or security-relevant surface. No solution docs — trivial single-purpose module.
