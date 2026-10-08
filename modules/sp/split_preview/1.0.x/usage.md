<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
**Split Preview** turns the core *Preview* button on node add/edit forms into a live, side-by-side preview: the rendered preview loads in an iframe next to the form, with buttons to switch the iframe width between mobile, tablet and desktop so editors can check responsive layout without leaving the edit screen.

---

`hook_form_alter()` targets `ContentEntityForm`s for the `node` entity type: it attaches the `split_preview/split_preview-library` asset library, and where the form has (or, for Layout Builder forms, is given) a *Preview* action it relabels it *Live Preview* and wires an AJAX callback `_submit_ajax_form`. That callback builds the preview and returns a custom AJAX command `PreviewContentCommand` (`command: previewContent`) that the module's JS uses to inject the preview HTML into the split-pane iframe; device-toggle controls then resize the iframe. The module is presentation-only: it has **no routes, services, permissions, config or blocks**, and it operates strictly within the existing node-edit form, so access is governed entirely by the user's normal node create/edit permissions and core form CSRF/token handling. CSS/JS assets live under `css/` and `js/`; a `tests/` folder is included.

---

- Preview a node while editing it without navigating away.
- See the rendered node in a split pane beside the edit form.
- Toggle the preview between mobile, tablet and desktop widths.
- Check responsive layout of a page before publishing.
- Get a live preview button on Layout Builder-enabled node forms.
- Relabel the core Preview button to *Live Preview*.
- Load the preview via AJAX inside an iframe.
- Review styling changes on a draft in context.
- Preview any node bundle (article, page, custom types).
- Confirm image/embed rendering at different breakpoints.
- Keep editing and previewing on a single screen for efficiency.
- Speed up editorial QA of responsive content.
- Use the custom `previewContent` AJAX command for the split view.
- Rely on standard node permissions to gate preview access.
- Preview unsaved form changes as they will render.
- Help editors validate mobile-first designs.
- Reduce round-trips between edit and full-page preview.
