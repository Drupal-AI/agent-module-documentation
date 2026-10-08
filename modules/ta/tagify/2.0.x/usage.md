Tagify replaces Drupal's default entity-reference autocomplete and select widgets with the Tagify JavaScript library, turning tags into removable "chips" with rich, image- and info-aware autocomplete suggestions.

---

Out of the box, referencing taxonomy terms, users, or other entities in Drupal uses a plain comma-separated autocomplete textfield that is easy to get wrong. Tagify provides two field widgets — an entity-reference autocomplete widget and a select widget — that render each reference as a visual tag chip with an "x" to remove it, drag-to-reorder support, and a dropdown of matching suggestions. Each widget is configurable per field: match operator (contains vs. starts-with), maximum number of suggestions, placeholder text, whether to expose the entity ID, an optional token-based "info label" shown beside each suggestion, and whether parent terms may be selected in hierarchical vocabularies. A global settings form can make Tagify the default widget for every entity-reference field on the site. Tagify integrates with Better Exposed Filters so Views exposed filters can use the same tag UI, and it ships submodules for Facets integration, UI/Iconify icon pickers, and a user-list widget with avatars. Developers can adjust matches with `hook_tagify_autocomplete_match_alter()` and reuse the `entity_autocomplete_tagify` / `select_tagify` render elements, the autocomplete matcher service, and a hierarchical-term manager service. Theming adapts automatically to Claro and Gin admin themes.

---

- Replace the default taxonomy term reference field with visual tag chips.
- Let editors remove a referenced entity by clicking an "x" on its chip.
- Reorder multi-value references by dragging tags into order.
- Show a starts-with or contains autocomplete match as the editor types.
- Limit the number of autocomplete suggestions shown in the dropdown.
- Display a token-driven "info label" (e.g. term description) beside each suggestion.
- Expose or hide the entity ID within each tag.
- Set custom placeholder text prompting editors what to type.
- Make Tagify the default widget for all entity-reference fields site-wide.
- Prevent selection of parent terms in a hierarchical vocabulary.
- Use a Tagify-styled select widget for fixed option lists.
- Provide a tag-style exposed filter in Views via Better Exposed Filters.
- Offer a Facets widget that renders facet values as clickable tags.
- Build a user picker showing avatars via the Tagify User List submodule.
- Add an icon picker for UI Icons fields with the Tagify Icons submodule.
- Add an Iconify icon picker with the Tagify Iconify Icons submodule.
- Reference users, nodes, or media with a consistent chip-based UI.
- Enforce field cardinality visually as editors add tags.
- Adjust or exclude autocomplete matches in custom code via a hook.
- Reuse the `entity_autocomplete_tagify` render element in custom forms.
- Programmatically fetch matching entities via the autocomplete matcher service.
- Resolve hierarchical term trees and parents via the term manager service.
- Match the widget styling to Claro or Gin admin themes automatically.
- Give content editors a modern, app-like tagging experience.
- Speed up tagging by showing suggestions on the first typed character.
