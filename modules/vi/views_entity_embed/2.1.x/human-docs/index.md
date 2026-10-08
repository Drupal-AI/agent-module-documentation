# Views Entity Embed — manual setup guide

**Views Entity Embed** (`views_entity_embed`) lets content editors drop a **View**
straight into a rich-text (CKEditor 5) field. Instead of hard-coding a listing or
building a separate block, an editor clicks a toolbar button, picks a View and one
of its displays, and the chosen listing renders inline right where they placed it
— a "Latest articles" list inside a landing-page body, a filtered product grid in
a description, a related-content block partway through an article.

It's built on Drupal's Embed / Entity Embed framework, so it works the same way
media and entity embeds do. Behind the scenes the embed is stored as a
`<drupal-views>` tag carrying the View name, the display, and a small JSON blob of
options. A text filter, **Display embedded views**, finds those tags when the
content renders, runs the referenced View, and swaps in the result. From the embed
dialog an editor can override the View's title for that placement and pass
contextual-filter arguments, so the same View can appear with different titles or
filtered differently on different pages.

You can create more than one embed button and scope each to a specific set of
Views or display types — handy if you want marketers to insert only an approved
handful of listings. There is no module settings page; you set it up entirely on
the text-format and embed-button side (enable the filter, allow the tag, place the
button on the toolbar), which is the standard Entity Embed workflow.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its Embed /
   Entity Embed dependencies) with Composer and enable it.

## Where it lives in the admin menu

There's no dedicated settings page. You work with it in two core places:
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`) for the filter and toolbar, and **Configuration
→ Content authoring → Embed buttons** (`/admin/config/content/embed`) for the
Views Embed button.

## How to use it

The module ships a **Views** embed button already, so setup is mostly wiring it
into a text format:

1. **Enable the filter.** Edit the text format your editors use (for example
   **Full HTML**) and, under **Enabled filters**, tick **Display embedded views**.
   This is the filter that actually renders embedded Views.
2. **Allow the tag (if you limit HTML).** If **Limit allowed HTML tags and correct
   faulty HTML** is on for that format, add the `<drupal-views>` element and its
   attributes to the **Allowed HTML tags** box, or Drupal strips them:

   ```
   <drupal-views data-view-name data-view-display data-view-arguments data-embed-button data-caption data-align>
   ```
3. **Add the button to the toolbar.** In the same format's **CKEditor 5 toolbar**
   configuration, drag the **Views Embed** button from the available items into the
   active toolbar.
4. **Save** the format.

Now an editor writing in that format can click the **Views Embed** button, choose
a View and display in the dialog, optionally set a custom title and contextual
arguments, and insert it. The listing renders inline. They can click an existing
embed to reopen the dialog and change the display or arguments later.

### Restricting which Views editors can embed

If you want to limit the choices, go to **Configuration → Content authoring →
Embed buttons**, edit (or create) a button whose **Embed type** is *Views*, and
use its options to **filter which Views** and/or **which display types** are
allowed. Leaving those unchecked allows every View and display. Create several
buttons scoped to different sets of Views if different editors need different
options, then place each on the appropriate text format's toolbar.
