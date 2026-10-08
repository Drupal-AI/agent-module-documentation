# Configuration

Social Simple has no single settings page. There are two independent ways to display
the share links — per content type, and as a block — and you can use either or both.

## A) Per content type

The share settings live on the content-type edit form, in a **"Social simple share"**
vertical-tab section. It is only visible to users with the **Administer social
simple** or **Administer content types** permission.

1. Go to **Structure → Content types → *(your type)*** (for example *Article*).
2. Open the **Social simple share** section and set:
   - **Display social network share links** — the master on/off switch for this
     content type.
   - **Title** — the heading shown above the buttons (for example "Share on").
   - **Networks** — checkboxes for which networks to show (Twitter/X, Facebook,
     LinkedIn, Google+, Mail, Print, Print to PDF).
   - **Twitter hashtags** — optionally pick an entity-reference field on the bundle
     (such as *Tags*); the labels it references become Twitter hashtags.
   - **Forward integration** — appears only if the Forward module is installed;
     integrates Forward with the Mail button.
3. Save the content type.

### Show the buttons in a view mode

Turning sharing on exposes a **Social simple share** pseudo-field, but it is hidden by
default. To place it, go to the content type's **Manage display** tab
(**Structure → Content types → *(your type)* → Manage display**), move the
**Social simple share** component out of *Disabled* into the region and position you
want, and save. Do this for each view mode where you want the buttons (for example the
full page but not the teaser).

## B) As a block

If you would rather place the share links in a region:

1. Go to **Structure → Block layout** and place the **Social simple block** in a
   region.
2. In the block settings, set:
   - **Title** — the heading above the links.
   - **Networks** — checkboxes for which networks to show.
3. Save the block. It automatically shares the entity for the current page (node or
   taxonomy term), so it works across the pages where it is placed.

## Networks available

Twitter/X, Facebook, LinkedIn, Google+, Mail (mailto), Print (opens the browser print
dialog), and Print to PDF (requires the **Entity Print** module — otherwise that
button does nothing). Twitter hashtags are read from the field you configure on the
content type.

## Per-node hiding (submodule)

If you enabled **Social Simple Per Node**, each node's edit form gains a **Social
share links enabled** checkbox (inside the same "Social share" group). Editors need
the **Disable social links per node** or *Administer content* permission to see it;
everyone else gets the content type's default. Unticking it hides the share buttons on
that specific node.

## Permissions

The module provides one permission, **Administer social simple**, which controls who
can see and change the per-content-type share settings (core's *Administer content
types* also grants access to that section). The per-node submodule adds **Disable
social links per node**. Set these under **People → Permissions**.

## Theming

The buttons render through a `social_simple_buttons` theme hook. To restyle them,
override `templates/social-simple-buttons.html.twig` in your theme; a per-content-type
suggestion (`social_simple_buttons__<type>`) is available on node pages.
