# Forms Steps theming

## Theme hook
`forms_steps_theme()` registers **`item_list__forms_steps`** — a specialized `item_list`
theme hook used to render the progress bar / steps list. Variables: `items`, `title`,
`list_type`, `wrapper_attributes`, `attributes`, `empty`, `context`; preprocess reuses core
`template_preprocess_item_list`.

Template: `templates/item-list--forms-steps.html.twig` (override it in your theme as
`item-list--forms-steps.html.twig` to restyle the progress list).

## Progress bar block
The progress bar is rendered by the derivative Block plugin
`\Drupal\forms_steps\Plugin\Block\FormsStepsProgressBarBlock` (deriver
`Plugin\Derivative\FormsStepsProgressBarBlock`) — one block per workflow. Place it in a region
via Block layout. Which progress-step links are shown/linked is governed by the workflow's
`progress_steps_links_saved_only` / `progress_steps_links_saved_only_next` flags.

## Related behavior
- `forms_steps_entity_predelete()` cleans up `forms_steps_workflow` instance entities when the
  underlying content entity is deleted.
