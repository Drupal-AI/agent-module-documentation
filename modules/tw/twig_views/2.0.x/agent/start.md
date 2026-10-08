# Twig Views — agent index

One Twig function to render a Views display (plus its title) from any template. No admin UI
(`configure` null), no permissions, no config, no Drush. Depends on core `views`.

- **The `render_view()` function — signature, arguments, output shape, errors** →
  [theming/render-view.md](theming/render-view.md)

Key facts:
- Service `twig_views.twig.render_view` (`Drupal\twig_views\Twig\RenderView`), a `twig.extension`.
- Function: `render_view(view_id, display_id, ...contextual_args)`; marked `is_safe: html`.
- Prepends the view title in an `<h2>` above the rendered view output.
