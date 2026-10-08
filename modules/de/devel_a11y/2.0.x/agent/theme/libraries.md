# Libraries (front-end aids)

Declared in `devel_a11y.libraries.yml`. Each is attached conditionally by
`Hook\Attachments::pageAttachments()` when both its config flag is on and the user
holds `access devel information` (see [../configure/settings.md](../configure/settings.md)).
None load on their own — there is no block, toolbar item, or theme hook; they ride
on core's a11y JS.

| Library | Assets | Core deps | Behavior |
|---|---|---|---|
| `devel_a11y/announce.log` | `js/announce.log.js` | `core/drupal.announce` | Monkey-patches `Drupal.announce`: before delegating to the original, `console.info`s the message and its resolved priority (`assertive` vs `polite`). |
| `devel_a11y/tabbingmanager.log` | `js/tabbingmanager.log.js` | `core/drupal.tabbingmanager`, `core/jquery` | Binds `drupalTabbingContextActivated`/`Deactivated`; `console.info`s the constraint level plus the count of tabbable and disabled elements on activate, and the level on deactivate. |
| `devel_a11y/tabbingmanager.visualize` | `js/tabbingmanager.visualize.js`, `css/tabbingmanager.visualize.css` (theme) | `core/drupal.tabbingmanager`, `core/jquery` | On the same tabbing events, adds/removes class `tabbingmanager-visualize-tabbable` on the currently tabbable elements. |

## Console output shapes

- announce: `"<priority> Drupal announcement: \"<text>\""` — priority is `assertive`
  only when passed `'assertive'`, otherwise `polite`.
- tabbing activate: `"TabbingManager: tabbing constraint activated, level <n>, <n> tabbable elements, <n> disabled elements."`
- tabbing deactivate: `"TabbingManager: tabbing constraint deactivated, level <n>."`

## Visualization styling

`css/tabbingmanager.visualize.css` styles `.tabbingmanager-visualize-tabbable`
with a red inset box-shadow and a one-second `tabbingmanager-visualize-pulse`
keyframe animation; the `:focus` state switches to a blue inset + outer glow. This
is purely a developer overlay — it does not alter markup or the tab order, only
paints the elements the tabbing manager has constrained focus to.

## Notes

- All three events (`drupalTabbingContextActivated`/`Deactivated`) are namespaced
  `.devel_a11y`; the announce override wraps, not replaces, core behavior, so the
  live-region announcement still fires.
- Logging is console-only — nothing is written server-side or persisted.
