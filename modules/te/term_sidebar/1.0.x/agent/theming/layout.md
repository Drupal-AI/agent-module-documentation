# Term form layout (theming)

All logic is in `term_sidebar.module`. There is nothing to configure; behavior is automatic on
taxonomy term forms.

## When it runs

`term_sidebar_form_alter()` (a `hook_form_alter`) acts only when:
- the form object is an `EntityFormInterface`, and
- its form-display mode is not `delete`, and
- the entity's type id is `taxonomy_term`.

`term_sidebar_module_implements_alter()` moves this module's `form_alter` to the end of the
implementation list so it can regroup other modules' additions (e.g. path, translation) reliably.

## Regions/groups it builds

- `main_wrapper` — a `layout-form clearfix` container holding everything.
- `main` (`layout-region--main`) with a `term_main` content group; **every** field definition for the
  bundle that exists in the form is reassigned `#group => term_main`.
- `advanced` (`layout-region--secondary`, `#accordion => TRUE`) — the sidebar. Into it go:
  - a `meta` "Status" block with `published` (Published / Not published) and `changed`
    (last-saved, via `date.formatter` `short`) items;
  - the `path` group (converted to a `details` element titled from the path widget);
  - the `relations` group;
  - the `content_translation` group.
- `footer` (`layout-region--footer`) — receives the action buttons depending on theme.

## Theme handling

The active theme is resolved; if it is not `gin`/`claro`, the first base-theme extension is used
(so Gin/Claro subthemes are detected). Then:

- **claro**: adds body class `layout-node-form`, moves `status` and `actions` into a `term_footer`
  content group, hides the default actions (`display:none`), attaches `claro/node-form` +
  `claro/form-two-columns`.
- **gin**: reorders Save vs Preview / "save and add another", adds a `gin_sidebar_toggle` link,
  builds a sticky `gin_actions` container, moves `status` + `actions` into it, hides default actions,
  attaches `claro/node-form` + `gin/edit_form` + `gin/sidebar`, and adds classes
  `gin-node-edit-form` / `page-wrapper__node-edit-form` so Gin's `edit_form.js` treats it like a node
  edit form. `term_sidebar_preprocess_html()` additionally adds the `gin--edit-form` body class on
  the `entity.taxonomy_term.add_form` / `.edit_form` routes.
- **default / other**: regions are created but no theme-specific action relocation or library
  attachment happens.

## Notes

- No override template ships; the layout relies on core Claro/Gin form-layout CSS libraries.
- Because it reassigns `#group` for every bundle field, custom term fields are included automatically.
