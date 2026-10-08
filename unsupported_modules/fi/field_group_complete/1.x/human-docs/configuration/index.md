# Configuration

Field Group Complete works out of the box with sensible defaults — everything on
this page is **optional tuning** of how the completion badge looks and behaves.
If you never open this form, the module still adds "Complete" badges to your
Field Group tabs.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Content authoring → Field Group Complete**, or
   navigate directly to `/admin/config/content/field-group-complete`.

## Settings

The form gives you a handful of options:

- **Complete badge text** (`badge_text_complete`) — the label shown on a group
  once all of its required fields are satisfied. Defaults to "Complete". Change it
  to match your site's wording or language.
- **Incomplete badge text** (`badge_text_incomplete`) — the label shown while a
  group still has unmet required fields (for example "Incomplete").
- **Badge visibility** (`badge_visibility`) — controls whether the badge is shown
  at all. Turn it off if you prefer to rely only on the CSS class (and your own
  styling) rather than a visible badge.
- **Custom complete classes** (`custom_complete_classes`) — additional CSS
  classes applied to a group once it is complete. Use this to hook the completion
  state into your theme or a design system (for example a class like
  `usa-check` or `my-lib--complete`).
- **Custom required classes** (`custom_required_classes`) — additional CSS classes
  applied to groups that contain required fields, again so you can target them
  from your own styles.

## Save

Click **Save configuration**. Because the badge and classes are applied by
JavaScript on the edit form, reload an entity edit form to see your changes take
effect. The badges use `aria-live="polite"` so screen readers announce completion
changes accessibly.
