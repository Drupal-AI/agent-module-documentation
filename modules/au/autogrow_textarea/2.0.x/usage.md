Autogrow Textarea grows and shrinks every textarea on the page to fit its content as the user types.

---

Autogrow Textarea is a front-end UX enhancement that automatically resizes `<textarea>` fields to match their content height, removing the need to scroll inside a small fixed box. It works by attaching a single JavaScript behavior to every textarea rendered by Drupal's Form API. On page load and on each `input` event, the behavior resets the element's height and sets it to the scroll height plus a small padding, so the field grows as text is added and shrinks as text is removed. CKEditor already auto-sizes its own editors; this module fills the gap for plain non-CKEditor textareas.

It ships as one hook (`hook_element_info_alter`) that attaches one JS asset library to the core `textarea` render element, plus one behavior file. There is no configuration, no admin UI, no routes, no permissions, no services, no config schema, and no PHP dependency beyond Drupal core. Supports Drupal 9, 10, and 11.

---

- Auto-resize plain textareas to fit their content.
- Grow a textarea as the user types more text.
- Shrink a textarea when content is deleted.
- Remove in-box scrolling on long-text fields.
- Improve the editing experience on node/entity add/edit forms.
- Enhance comment body textareas.
- Enhance webform textarea elements.
- Enhance block description and body textareas.
- Enhance user profile bio/about textareas.
- Enhance configuration and settings-form textareas.
- Give non-CKEditor "Plain text" format fields comfortable auto-height.
- Apply automatically to every textarea site-wide with zero setup.
- Keep the front end lightweight (a single small, unminified JS file).
- Avoid any server-side processing or stored configuration.
- Work alongside CKEditor without conflicting with its own auto-grow.
- Support long-form text entry without a cramped input box.
- Reduce editor friction and scrolling fatigue.
- Provide a drop-in usability win requiring no theme changes.
- Run on both admin and front-end forms.
- Re-apply correctly to textareas added via AJAX (uses `once()` and `context`).
