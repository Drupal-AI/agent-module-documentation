Page Manager UI adds the administrative wizard (Structure → Pages) that lets site builders create and edit Page Manager pages, variants, contexts, access rules and selection criteria without writing configuration by hand.

---

The core Page Manager module is engine-only: it defines the `page` and `page_variant` config entities and the routing that renders them, but ships no editing interface. Page Manager UI supplies that interface — a multi-step CTools entity wizard mounted at `/admin/structure/page_manager`. From the Pages list you add a page (administrative title, path, admin-theme toggle), define typed URL parameters, configure access conditions, then add one or more variants choosing a variant type (block display, HTTP status code, Layout Builder, or Panels if installed). For each variant the wizard walks you through selection criteria, static contexts, and — for block variants — placing blocks into layout regions. Edits are held in tempstore until you save, so changes are staged and can be cancelled. It also provides list builders, reorder and delete forms, and config-translation mappers for translating page and variant labels. It depends on the main Page Manager module and reuses its `administer pages` permission. Everything it creates is standard exportable configuration.

---

- Add a new custom page through a guided wizard.
- Set a page's path, administrative title and description in the UI.
- Toggle whether a page uses the admin theme.
- Define typed URL parameters (e.g. `{node}`) for a page.
- Add access conditions and choose AND/OR logic visually.
- Add a block-display variant and place blocks into layout regions.
- Add an HTTP status code variant (403/404/…) without code.
- Add a Layout Builder variant to a page.
- Configure per-variant selection criteria in the wizard.
- Attach static contexts to a variant.
- Reorder variants to control match precedence.
- Edit an existing page's general settings.
- Delete a page or an individual variant safely.
- Stage edits in tempstore and cancel before saving.
- Browse all managed pages in an admin list.
- Translate page and variant labels via config translation.
- Duplicate the behavior of legacy CTools page editing in Drupal 9/10/11.
- Give non-developers a way to build custom pages.
- Configure block settings for a placed block inside a variant.
- Add the "Add page" action link under Structure.
