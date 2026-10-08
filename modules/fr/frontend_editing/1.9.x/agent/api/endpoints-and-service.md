<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, endpoints & the paragraphs_helper service

Frontend Editing has no plugin types and no public "call me" API in the usual sense; its
surface is a set of controller routes (`FrontendEditingController`) plus one service. Useful
when you build custom front-end editing UIs or extend paragraph behavior.

## Routes / endpoints (`frontend_editing.routing.yml`)

| Route | Path | Purpose |
|---|---|---|
| `frontend_editing.settings_form` | `/admin/config/frontend-editing` | main settings form |
| `frontend_editing.entity_bundle_restrictions` | `/admin/config/frontend-editing/entity-bundle-restrictions` | choose editable bundles |
| `frontend_editing.ui_settings` | `/admin/config/frontend-editing/ui-settings` | toggle/color/filter settings |
| `frontend_editing.form` | `/frontend-editing/form/{type}/{id}/{display}` | returns the entity edit form for the sidebar (perm: `access frontend editing`) |
| `frontend_editing.toggle` | `/frontend-editing/toggle` | flip the per-user on/off state (stored via `user.data`) |
| `frontend_editing.update_content` | `/frontend-editing/update-content/{entity_type_id}/{entity_id}/{field_name}/{view_mode}` | re-render a field/entity region after save (AJAX) |
| `frontend_editing.paragraph_add` | `/frontend-editing/paragraphs/{paragraphs_type}/add/{parent_type}/{parent}/{parent_field_name}/{current_paragraph}/{before}` | add a paragraph of a type |
| `frontend_editing.paragraph_add_page` | `/frontend-editing/paragraphs/add/{parent_type}/{parent}/{parent_field_name}/{current_paragraph}/{before}` | "choose a type" add page |
| `frontend_editing.paragraph_delete` | `/frontend-editing/paragraphs/{paragraph}/delete` | delete a paragraph |
| `frontend_editing.paragraph_up` / `frontend_editing.paragraph_down` | `/frontend-editing/paragraphs/{paragraph}/up`\|`/down` | move a paragraph |

Paragraph routes use `_custom_access` callbacks on the controller
(`accessUp/accessDown/accessAdd/accessAddType/accessDelete/accessUpdateContent`) which combine
the module's permissions, `paragraphs_edit` lineage access, and the access **events**.

## Service: `frontend_editing.paragraphs_helper`

Class `Drupal\frontend_editing\ParagraphsHelper` (interface `ParagraphsHelperInterface`).
Lineage-aware helper for paragraph operations. Public methods:

- `allowUp($paragraph)` / `allowDown($paragraph)` / `allowDelete($paragraph)` — access checks.
- `move($paragraph, $operation)` — move a paragraph up/down within its parent field.
- `delete($paragraph)` — remove a paragraph and save the lineage.
- `getRedirectUrl($paragraph)` — canonical URL of the paragraph's root host entity.
- `getParagraphRootParent($paragraph)` — walk the lineage to the top-level host entity.
- `allowAddType($paragraphs_type, $parent_type, $parent, $parent_field_name)` — may this type be added here.
- `allowAdd($parent_type, $parent, $parent_field_name)` — may anything be added here.

```php
$helper = \Drupal::service('frontend_editing.paragraphs_helper');
$helper->move($paragraph, 'up');
$root = $helper->getParagraphRootParent($paragraph);   // e.g. the host node
```

It is constructed with the `paragraphs_edit` lineage inspector/revisioner, the entity type
manager, entity repository, current user, and the event dispatcher.

## AJAX commands (`src/Ajax/`)

Custom commands the controllers return: `CloseSidePanelCommand`, `EntityPreviewCommand`,
`ReloadWindowCommand`, `ScrollTopCommand` — paired with JS behaviors in `js/`. Reuse them if
you return responses that should drive the sidebar (close panel, show preview, reload, scroll).

## Event subscribers

`PreviewSubscriber` (renders previews via the paragraphs_edit lineage inspector) and
`RouteSubscriber` (route alterations) are wired in `frontend_editing.services.yml`.
