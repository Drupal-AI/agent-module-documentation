<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A Views row plugin that renders each result entity as an editable form in a chosen form mode.

---

Views Entity Form Row provides a Views **row** plugin (Format → Show) that renders each result row as the entity's editable form instead of a rendered view. A deriver exposes one row option per Views-enabled content entity type (anything whose base table appears in Views data), labelled "<Entity type> - Entity form". The only option is the **Form mode** to render; which fields appear is controlled by that entity type's Manage form display. Each row's form is built with a unique form ID (`ENTITY_TYPE_BUNDLE[_FORM_MODE]_ENTITY_ID_form`, e.g. `node_page_12_form`), so several forms submit independently on one page; after saving, the user stays on the same page keeping pager and exposed-filter query. A row is only rendered as a form when the current user has `update` access to that entity. Requires Drupal core 11.3+ (or 12) and the core Views module.

---

- Render each Views result as an editable entity form.
- Pick the form mode per display (defaults to the default form mode).
- Works for any content entity type exposed to Views (not just nodes), via a deriver.
- Only renders the form for entities the current user may update.
- Gives each row form a unique, entity-ID-based form ID so submissions are independent.
- Returns the user to the same page after saving, preserving the Views query.
- 2.x no longer overrides site-wide entity form classes; normal edit forms are unaffected.
- The former `views_entity_form_row` theme hook and template were removed; alter the form instead (e.g. `hook_form_node_form_alter()`).
- Depends on core Views; supports Drupal 11.3+ and 12.
