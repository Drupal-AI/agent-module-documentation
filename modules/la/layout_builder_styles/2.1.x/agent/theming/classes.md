# How styles reach the markup

The module has no plugin/API surface — it wires selected classes into Layout Builder output
via hooks and an event subscriber (all in `layout_builder_styles.module` +
`src/EventSubscriber/BlockComponentRenderArraySubscriber.php`).

- **Form injection** — `hook_form_alter` / `hook_form_layout_builder_configure_section_alter`
  add the style selectors to the block-configure and section-configure forms in Layout
  Builder. Chosen style ids are saved into the component/section third-party settings.
- **Blocks** — `BlockComponentRenderArraySubscriber` (subscribes to the Layout Builder block
  render-array event) attaches the style's `classes` to the block's `#attributes` when it is
  rendered.
- **Sections** — `hook_preprocess_layout()` adds the section-level style classes to the
  layout's attributes.
- **Theme suggestions** — `hook_theme_suggestions_block_alter()` adds suggestions like
  `block__<style-id>` so themers can provide dedicated block templates per applied style.

Practical notes:
- The classes you type into a style's `classes` field are output verbatim — put your theme's
  utility/BEM classes there.
- To template a styled block, create a template matching the added suggestion (check the
  Twig debug output for the exact suggestion name for your style id).
- Nothing is added to the `<head>`; supplying the actual CSS for those classes is the
  theme's job.
