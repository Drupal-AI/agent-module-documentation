<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Formatter (vff) adds a Views style plugin that renders an entire Views result set through a Twig template chosen from Field Formatter Template's configured directory.

---

vff is the Views submodule of FFT (`fft`), which it depends on along with core Views. Where FFT lets you pick a Twig template for a single field's formatter, vff lets you pick one for a whole View: choose the *View Formatter Template* style on a display, select a template (any file in FFT's template directory whose name starts with `views` and that carries a `{# Template Name: … #}` header), and the View's rows are handed to that template as `data`. The style can pass either the **raw** rendered Views fields (an array per row keyed by field id) or the **styled** row render arrays, expose the current interface/content langcodes, optionally strip the default `views-view` wrapper markup with a "clean template", build a nested parent/child **tree** from two chosen id fields (handy for taxonomy hierarchies), and render even when the View returns no rows.

The style plugin is `ViewFormatterTemplate` (`Drupal\vff\Plugin\views\style\ViewFormatterTemplate`, id `views_formatter_template`); preprocessing lives in `vff.theme.inc` and the output is emitted by `templates/views-formatter-template.html.twig` (`{{ template_rendered | raw }}`). Templates are authored and selected by site builders, exactly as with FFT.

---

- Render a whole Views result set with a custom Twig layout instead of a built-in Views style.
- Build a grid, masonry, or card layout over View rows.
- Output the raw rendered Views fields per row and lay them out by hand in Twig.
- Output styled row render arrays to a template.
- Build a taxonomy or menu hierarchy tree from flat rows using tree id / parent-id fields.
- Strip the default `views-view` wrapper markup with the clean-template option.
- Show a placeholder template when a View has no results.
- Reuse a single Views template across several displays.
- Reference module/theme/template asset paths through FFT's `{module-…}`/`{theme}`/`{fft}` tokens.
- Produce language-aware markup using the `langcode`, `langcode_content`, and `langcode_interface` variables.
- Keep View templates in version control alongside FFT field templates in the same directory.
- Prototype a bespoke listing quickly without writing a custom Views style plugin.
- Combine with FFT field templates so both fields and the surrounding list are template-driven.
- Feed a JS widget (carousel, map, calendar) by rendering rows into the markup it expects.
- Emit structured data (JSON-LD, microdata) around a View's rows.
