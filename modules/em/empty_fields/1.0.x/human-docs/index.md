# Empty Fields — manual setup guide

**Empty Fields** (`empty_fields`) lets you render something in place of a field
that has no value, instead of that field simply disappearing. By default Drupal
just omits an empty field, which can leave table rows collapsed, grid and card
layouts uneven, or a "missing data" gap where a consistent placeholder would read
better. Empty Fields lets you fill that gap with a non-breaking space, a dash, or
custom (token-aware) text — while still emitting the field's normal label and
wrapper markup so your CSS and layout stay intact.

There is no central settings page. Instead the module adds an **"Empty value
behavior"** option to every field formatter's settings on the *Manage display*
screen. For each field, per view mode, you choose a handler and (if it takes
settings) fill them in. Two handlers ship out of the box: **nbsp**, which renders
a non-breaking space (handy for keeping table and grid cells aligned), and
**text**, which renders custom text run through Drupal's token system — so your
placeholder can include values like the node title or author, or read something
like "N/A", "Not provided", or "Contact us". The choice is saved as part of the
entity's view-display configuration, so it is exportable and can differ between,
say, teaser and full view modes.

Because empty-field rendering is a **plugin type**, developers can add their own
handler to produce any placeholder logic they like — an em dash, a computed value,
or bespoke markup. The module works on Drupal 9, 10, and 11, has no dependencies,
no configure route, no permissions, and no Drush commands.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

(There is no separate configuration page — the module has no settings form. You
configure it per field on *Manage display*, described below.)

## Where it lives in the admin menu

There is no admin page. You set the empty-value behavior on a field at **Structure
→ Content types → [your type] → Manage display**
(`/admin/structure/types/manage/<type>/display`), or the equivalent *Manage
display* screen for any fieldable entity type.

## How to use it

1. Go to the *Manage display* screen of the content type (or other entity) whose
   fields you want placeholders for, choosing the relevant view mode (e.g.
   *Default* or *Teaser*).
2. Click the settings cog for the field you want to handle.
3. Set **Empty value behavior** to one of:
   - **- Default -** — the standard Drupal behavior (field is hidden when empty).
   - The **non-breaking space** handler — renders a `&nbsp;` to hold the field's
     space open.
   - The **custom text** handler — reveals a text box where you enter the
     placeholder text. This text is run through the token system, so you can
     include entity or user tokens (for example the node title) as well as plain
     strings like "N/A".
4. Click **Update**, then **Save**.

The placeholder now appears whenever that field is empty on an entity of this
type, in this view mode — while fields that do have a value render as normal.
Repeat per field and per view mode as needed; the settings are exported with your
`entity_view_display` configuration.

### For developers

Empty Fields defines an `empty_fields` plugin type (annotation `@EmptyField`,
plugin namespace `Plugin/EmptyFields`, base class `EmptyFieldPluginBase`). To add
your own placeholder handler, create a plugin implementing `react()` (return the
render array shown for an empty field) and `settingsSummary()`, optionally with a
`settingsForm()`. After a cache clear it appears in the **Empty value behavior**
select on every field's formatter settings. See the sibling
[`agent/plugins/empty-field.md`](../agent/plugins/empty-field.md) doc for the full
plugin contract.
