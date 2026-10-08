# Configuration

Read More Extra Field has **no central settings page**. Everything is configured
per view mode on a bundle's **Manage display**, right where you position the link.
That means each view mode (Teaser, Full, a custom "Card" mode, and so on) can have
its own label, styling, and attributes.

## Open the settings

1. Log in as a user who can administer display settings (an administrator by
   default, via the **Administer display modes / Manage display** permissions).
2. Go to **Structure → Content types → *(your type)* → Manage display**
   (`/admin/structure/types/manage/{type}/display`), then pick the view mode you
   want to change.
3. In the **Extra fields** area, drag the **Read more** row out of **Disabled**
   into the position you want.
4. Click the **gear icon** on the Read more row to open its settings.

The same steps work on any fieldable entity type's **Manage display** tab, not
just content types.

## The settings, field by field

- **Label** — the anchor text of the link. Defaults to **Read more**; set it to
  something like *Continue reading* or *View full article*. If you leave it blank,
  the translated "Read more" is used.
- **Link classes** — extra CSS classes, separated by spaces, appended to the
  link. The link always keeps its base `readmore-extrafield-link` class; anything
  you add here is applied on top, so you can hook your theme's button styles onto
  it.
- **Link "title" attribute** — the value of the anchor's `title` attribute, shown
  as a tooltip on hover and read by assistive technology. Useful for a longer,
  descriptive hint than the visible label.
- **Link "rel" attribute** — the value of the anchor's `rel` attribute, for
  example `nofollow` or `noopener`.
- **Link "target" attribute** — the value of the anchor's `target` attribute; set
  it to `_blank` to open the article in a new tab.

## Using tokens (optional)

If the **Token** module is enabled, the **Label**, **Link classes**, and **Link
"title" attribute** fields accept tokens, resolved against the host entity, and a
token browser appears on the form. For example, a label of
`Read more about [node:title]` produces a per‑node label. The `rel` and `target`
fields are **not** token‑processed — enter literal values there. Without the Token
module, all fields are used exactly as typed.

## Save

Click **Save** at the bottom of the Manage display form. The settings are stored
in that view display's configuration, so they export with `drush config:export`
and can differ per view mode and per bundle.

> **Upgrading from 1.x?** If you had overridden the module's
> `readmore-extrafield.html.twig` template, update your override — the available
> Twig variables changed in 3.x.
