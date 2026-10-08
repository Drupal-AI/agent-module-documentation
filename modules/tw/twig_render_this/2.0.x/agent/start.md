# Twig Render This — agent index

One Twig filter, `|renderThis`, to render an entity / field item / field item list from a Twig
template using a view mode. No config, no permissions, no dependencies (core Twig only).

- **The `renderThis` filter — signature, accepted inputs, view-mode arg, behavior** →
  [api/filter.md](api/filter.md)

Key facts:
- Extension service: `twig_render_this.twig_extension`
  (`\Drupal\twig_render_this\TwigExtension\RenderThis`).
- Signature: `content|renderThis(view_mode = 'default')`.
- Entity → `entityTypeManager->getViewBuilder(...)->view(entity, view_mode)`;
  field item / list (or any object with `view()`) → `content->view(view_mode)`;
  otherwise returns the text "Twig Render This: Unsupported content."
