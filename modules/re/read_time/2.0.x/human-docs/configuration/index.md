# Configuration

Read time is configured **per content type, on its display** — there is no global
settings page. The read-time value is a pseudo-field you place on **Manage
display**, and its behavior is set from that field's own settings.

## Open the settings

1. Log in as a user who can administer content types / display.
2. Go to **Structure → Content types → *(your type)* → Manage display**
   (repeat per view mode — Default, Teaser, etc. — if you want read time in more
   than one).
3. If the **Read time** pseudo-field is in the *Disabled* section, drag it up into
   a visible region so it renders.
4. Click the gear/settings icon at the right of the **Read time** row to open its
   settings.

## Settings, field by field

- **Fields used to calculate the read time** — choose which of the content type's
  fields contribute their text to the word count. Include the fields that hold the
  actual reading content (for example the body and any long-text fields) and leave
  out fields that aren't really "reading". Remember that whether you include
  image-heavy or caption fields changes the estimate noticeably.

- **Average reading speed** — the assumed words-per-minute for your audience. This
  is the single biggest lever on the result. The common 200–250 wpm figures come
  from studies of adults reading prose; if your content is technical, tabular, or
  code-heavy, a lower figure gives more honest estimates.

- **Display format** — how the read time is presented (for example the wording and
  format of the "X min read" string). Set this to match your site's tone and the
  place the field appears.

- **Additional information** — extra text to show alongside the figure, such as a
  label. Use it to add a prefix/suffix like "read" or an icon-friendly label so
  the number reads naturally in context.

## Save

Save the field settings, then click **Save** on the **Manage display** page.
Reload a piece of that content type to confirm the read-time line appears as you
configured it. Repeat for other content types or view modes as needed.
