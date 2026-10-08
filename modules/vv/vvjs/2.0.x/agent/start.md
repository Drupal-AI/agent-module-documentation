# VVJS (Views Vanilla JavaScript Slideshow) — agent index

Accessible, dependency-free slideshow **Views display format**. A View's rows become slides; the
`views_vvjs` style plugin renders a `<vvjs-slideshow>` custom element. Requires `views`, `filter`, and
the `vvj_core` foundation module (v2 auto-enables it via `vvjs_update_10001`). No config page
(`configure` null — help at `/admin/help/vvjs`), no permission, no Drush. Provides a config schema for the
style options.

- **The Views style plugin and every format option (with schema constraints/defaults)** →
  [configure/format.md](configure/format.md)
- **The `Drupal.vvjs.*` JS API and `[vvjs:field]` Views tokens** → [api/js.md](api/js.md)

Key facts:
- Plugin id `views_vvjs` (`src/Plugin/views/style/Slideshow.php`, extends `vvj_core`'s
  `VvjStylePluginBase`); theme hook `views_view_vvjs`; custom element tag `vvjs-slideshow`.
- Options schema: `views.style.views_vvjs` (`config/schema/vvjs.schema.yml`), ~30 keys.
- Libraries in `vvjs.libraries.yml` (`vvjs`, `vvjs-style`, `vvjs-hero`, `vvjs-transitions`,
  `vvjs-opacity`, `vvjs-admin`, plus 5+5 breakpoint variants) depend on `vvj_core/*` libraries.
- Hooks are OOP `#[Hook]` classes under `src/Hook/` (help, theme, preprocess, token); tokens resolve via
  the nullable `@?vvj_core.token_resolver` service.
- Optional sample View `views.view.vvjs_example` installs from `config/optional/` when no id conflict.
- Raw markup / theming responsibility: hero overlay and token output render field/HTML content; standard
  Views/Twig autoescaping applies — treat `:plain` token output and any custom rewrites accordingly.
