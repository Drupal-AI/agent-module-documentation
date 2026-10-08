Block Renderer provides a `block_renderer` service that renders a block plugin or a block_content entity to a render array wrapped in a themed container DIV, so blocks can be reused in code without placing them in a region.

---

Block Renderer is a small developer utility (package "3sign", no dependencies, no UI, no config, no permissions, no routes). It exposes one service, `block_renderer` (class `Drupal\block_renderer\BlockRenderer`), with two public methods: `renderPluginBlock($id, $config)` instantiates a block plugin by its plugin id and returns its built output, and `renderContentBlock($id, $config)` loads a `block_content` entity by numeric id and renders it through the block_content view builder. Both wrap the result in a `block_renderer` theme hook (twig template `templates/block-renderer.html.twig`, based on core's block template) so you keep the outer `<div>`, optional `<h2>` label, and contextual links you would otherwise lose when rendering a raw plugin. You can pass a `$config` array with `#attributes` (e.g. extra CSS classes) that get merged onto the wrapper. The methods return a render array — return it from a controller/hook or run it through the renderer to get markup. Works on Drupal 8 through 11; not covered by the security advisory policy.

---

- Render a block plugin in code: `\Drupal::service('block_renderer')->renderPluginBlock('system_powered_by_block')`.
- Render a custom block_content entity by its integer id: `renderContentBlock(5)` (simpler than resolving the block plugin's UUID-based derivative id).
- Embed a block's output inside a custom controller's render array.
- Reuse a block inside a node/entity via a preprocess or hook without adding a placed block instance to a region.
- Return a block's render array from a form or AJAX response builder.
- Compose several blocks together into one page section programmatically.
- Add a custom CSS class to the wrapper: pass `['#attributes' => ['class' => ['my-block']]]` as the second argument.
- Keep the theming wrapper DIV and `block-<id>` class that raw `$plugin->build()` would omit.
- Preserve contextual links and the label `<h2>` that come from the block template.
- Render a block plugin only when the current user passes its own access check (plugin path calls `$block->access()`).
- Inject the `block_renderer` service into your own service via `arguments: ['@block_renderer']` instead of using `\Drupal::service()`.
- Render a "Powered by Drupal", menu, or views block plugin into a themed container.
- Build a dashboard region by rendering multiple block plugins in a loop.
- Render a marketing/CTA custom block in several templates without duplicating its content.
- Override the theme output by supplying your own `templates/block-renderer.html.twig` in your theme.
- Use it as a lightweight alternative to layout builder or block placement for one-off programmatic block output.
- Pass block-instance configuration positionally is not supported — the plugin is created with empty config (`createInstance($id, [])`); use configured block_content entities when you need stored settings.
- Render a block into an email or PDF build pipeline that consumes render arrays.
- Add block output to a REST/JSON response by rendering the returned array server-side.
- Provide a helper in a distribution/profile that lets site builders embed named blocks in code.
- Migrate away from hidden "parking" block instances previously placed only to be rendered elsewhere.
