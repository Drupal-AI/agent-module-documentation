# Permissions

Defined in `flush_single_image.permissions.yml`.

| Permission | `restrict access` | Gates |
|---|---|---|
| `administer flush_single_image` | `true` | The settings form (`flush_single_image.settings.form`) and the interactive flush form (`flush_single_image.flush`). This is the surface that accepts an arbitrary source-image path, so it is marked restricted (trusted administrators only). |
| `flush media image` | — | The bulk **Action** plugin `flush_single_image_action`. In addition, the action's `access()` requires the user to have `update` access on the specific media entity. |

Notes:
- The `hook_form_alter` widget added to media edit forms (see
  [hooks/form-alter.md](../hooks/form-alter.md)) is not gated by its own permission — it appears
  whenever the user can edit a configured media type, and only ever touches that media's own image
  derivatives.
- Grant `flush media image` to editors so they can refresh an image they just replaced without
  holding `administer flush_single_image`.
