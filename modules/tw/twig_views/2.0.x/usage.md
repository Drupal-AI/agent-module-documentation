Twig Views adds a single Twig function, `render_view()`, that renders a Views display (with its title) directly from any Twig template by view ID and display ID.

---

The module registers one Twig extension (`Drupal\twig_views\Twig\RenderView`) that exposes the `render_view(view, display, ...args)` function to all templates. Given a view machine name and a display machine name it loads the view with `Views::getView()`, sets the display, passes any extra arguments as the view's contextual filter arguments, and renders the result. The rendered output is wrapped in a small render array that also emits the view's title inside an `<h2>` element above the view content. The function is marked `is_safe => ['html']`, so its return value is printed without extra escaping. It throws `\InvalidArgumentException` when the display argument is missing or the display ID is invalid. There is no admin UI, no settings, no permissions, no config schema, and no Drush commands — the whole module is this one helper. It requires core Views. Typical use is embedding a listing (e.g. a block or page display) inside a node, paragraph, region, or component template without creating a block placement.

---

- Render a Views display inside a node template (`node--article.html.twig`) without placing a block.
- Embed a "related content" view under the body field of a content type template.
- Print a promoted-items view in a custom region template of a theme.
- Render a view inside a paragraph or Layout Builder component template.
- Show a taxonomy-term listing view on a term page template.
- Pass a contextual filter argument to a view from Twig (e.g. the current node ID).
- Pass multiple contextual arguments to a view display in one call.
- Display the view's configured title as an `<h2>` heading automatically above the results.
- Reuse the same Views display in several templates with different arguments.
- Render a block display of a view without exposing it as a placeable block.
- Embed a slider/carousel view (rendered by a Views style) inside a hero template.
- Show a "latest news" view in a footer or sidebar component template.
- Render a view of child pages inside a book/section template using the parent ID as argument.
- Build a decoupled-looking landing page by composing multiple `render_view()` calls in one template.
- Render a user-specific view (e.g. "my content") by passing the current user ID as an argument.
- Add a view of comments or references beneath an entity in its display template.
- Render a menu-driven or media view inside a custom Twig component.
- Inline a view into an email or PDF template that is built with Twig.
- Provide themers a code-only way to place views, keeping placement in version-controlled templates.
- Render a view whose display is not meant to be a standalone page or block (embed display).
