# API — entity, routes, Ajax, Views, assignee selection

## Entity `moderation_note`
`Drupal\moderation_note\Entity\ModerationNote` (ContentEntityBase, publishable, `fieldable = FALSE`,
base_table `moderation_note`). Key fields:
- `uid` (author, set to current user on create), `parent` (entity_reference to `moderation_note` —
  a reply), `assignee` (entity_reference to `user`).
- Target locator: `entity_type`, `entity_id`, `entity_field_name`, `entity_langcode`,
  `entity_view_mode_id`.
- Content: `quote` (selected text), `quote_offset` (int), `text` (note body), `created`, `changed`,
  `published`.
Interface `ModerationNoteInterface` exposes `getModeratedEntity()`, `getChildren()` (replies,
`accessCheck(FALSE)` query by `parent`), `hasParent()/getParent()`, `getQuote()/getQuoteOffset()`,
`getText()`, `getAssignee()/setAssignee()`, owner accessors. `toUrl()` points at the moderated
entity's canonical URL with `?open-moderation-note=<id>`. Cache tag
`moderation_note:<type>:<id>:<field>:<langcode>` (+ `moderation_note:user:<assignee>`).

## Routes / controller (`ModerationNoteController`)
| Route | Path | Access |
|---|---|---|
| `moderation_note.new` | `/moderation-note/add/{entity_type}/{entity}/{field_name}/{langcode}/{view_mode_id}` | custom `createNoteAccess` |
| `moderation_note.view` | `/moderation-note/{moderation_note}` | entity `view` |
| `moderation_note.edit` | `/moderation-note/{moderation_note}/edit` | entity `update` |
| `moderation_note.delete` | `/moderation-note/{moderation_note}/delete` | entity `delete` |
| `moderation_note.resolve` | `/moderation-note/{moderation_note}/resolve` | entity `resolve` |
| `moderation_note.reply` | `/moderation-note/{moderation_note}/reply` | entity `reply` |
| `moderation_note.list` | `/moderation-note/list/{entity_type}/{entity}` | `access moderation notes` + entity `view` |
| `moderation_note.assigned_list` | `/user/{user}/moderation-notes` | `access moderation notes` + user `view` |

The controller returns render arrays / AJAX responses; note view + reply form render in an
off-canvas dialog. Custom Ajax commands: `AddModerationNoteCommand`, `ReplyModerationNoteCommand`,
`RemoveModerationNoteCommand` (JS in `js/moderation_note.js`, library `moderation_note/*`).

## Entity forms
Form handlers on the entity: `create`/`edit`/`reply` → `ModerationNoteForm`;
`delete` → `ModerationNoteDeleteForm`; `resolve` → `ModerationNoteResolveForm`.

## Other integrations
- **Views**: `ModerationNoteViewsData` + field plugin `Plugin/views/field/ModerationNoteLink`
  (a link to the note).
- **Assignee selection**: `Plugin/EntityReferenceSelection/ModerationNoteUserSelection`.
- **Toolbar count**: service `moderation_note.menu_count` (`MenuCountService`) + local task
  `Plugin/Menu/LocalTask/AssignedNotes` showing the current user's assigned-note count.
- **Mail**: `Plugin/Mail/NoteMail` with `templates/mail-moderation-note.html.twig`.
- Templates `moderation-note.html.twig` / `moderation-note--preview.html.twig`.

## Notes
- No `*.api.php` hooks and no Drush commands are provided. The only public service is the menu-count
  service; most interaction is through the entity + routes above.
