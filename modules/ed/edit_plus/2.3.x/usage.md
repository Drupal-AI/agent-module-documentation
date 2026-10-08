Edit+ adds a "Change" tool to the Navigation+ / +Suite page-builder Edit Mode so site editors can click content directly on the rendered front-end page and change it in place, using the entity's normal edit form rendered in a right-hand sidebar.

---

Edit+ (machine name `edit_plus`, package *Page Building*) is part of the +Suite / Navigation+ ecosystem and depends on `navigation_plus`, `tempstore_plus`, `field_sample_value` and `twig_events`. It registers a Navigation+ tool plugin (id `edit_plus`, label "Change", hotkey `c`) that turns rendered fields into clickable, editable regions while Edit Mode is active. Clicking a field opens that entity's real Drupal form (`default` form mode) in the Navigation+ right sidebar, so any `hook_form_alter()`, widget, or field configuration you already use applies unchanged. Instead of writing every keystroke to the database, edits are buffered per user in a `tempstore_plus` entity tempstore and rendered back onto the page live via AJAX; the user explicitly saves (persisting all buffered entities and creating a single revision) or discards. Text fields become inline CKEditor 5 editors, and a small JS field-plugin system lets you build custom inline widgets (autocomplete, media, textfield) or fall back to the standard form item. Per-field settings on the *Manage fields* form let you disable inline editing or choose whether the whole wrapper or just the form item is swapped. The project ships eight optional submodules providing ready-made block types (CTA, heading, image, teaser, layout block), a landing-page content type, and Layout Builder / non-Layout-Builder node integrations. Note: as of this release the project is marked **deprecated** on drupal.org and superseded by `drupal/daedalus`.

---

- Let content editors edit body, title and other fields directly on the live page instead of going to `/node/{id}/edit`.
- Provide a "see a thing, click a thing, change a thing" WYSIWYG-style editing experience for marketing / non-technical authors.
- Edit inline block labels and inline-block content inside Layout Builder layouts without opening a modal.
- Inline-edit rich text fields with CKEditor 5 rendered directly over the rendered field markup.
- Buffer many edits across several entities on one page and commit them all in a single save (one revision, not one per keystroke).
- Discard all pending inline edits on a page and revert to the stored version.
- Add an empty/unset field to the page on the fly, auto-populated with a sample value, then edit it inline.
- Preview changes live: the rendered region updates via AJAX as you edit, in the correct view mode.
- Disable inline editing for specific fields via the *Manage fields* → *Edit+* settings (e.g. computed or sensitive fields).
- Choose per field whether inline editing replaces the entire field wrapper or just the form item markup.
- Keep using your existing entity forms, widgets, and `hook_form_alter()` logic — Edit+ reuses the normal `default` form.
- Extend the editing UI with custom inline field widgets through the JS field-plugin API (`field-plugin-base.js`).
- Integrate media selection inline via the Media Library, edited in place through Edit+'s media field plugin.
- Build a landing-page workflow: install `edit_plus_landing_page` for a Layout Builder-enabled Landing Page content type.
- Drop in prebuilt inline-editable block types (Call to action, Heading, Image, Teaser, Layout block) via the block submodules.
- Enable inline editing on standard nodes with or without Layout Builder using `edit_plus_non_lb_node` / `edit_plus_lb`.
- Give a role the "access inline editing" permission to grant it the inline-edit experience.
- Auto-generate sample content for empty fields (via `field_sample_value`) so authors have something to click and edit.
- Alter or react to the inline-edit form with the module's events (`FieldAttributes`, `AddEmptyField`, `NoChangeTool`, block/field property events).
- Keep CKEditor 5's bundled inline-editor build in sync with core using the provided Drush commands (`edit_plus:update-ckeditor-version`, `edit_plus:move-library`).
- Support editors working across multiple view modes, with view-mode-aware live re-rendering of the edited region.
- Provide inline editing that respects your existing entity form structure, including grouped/advanced field areas (auto-submitted).
