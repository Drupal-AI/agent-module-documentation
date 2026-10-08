# Configuration

Editor Advanced Link is configured **per text format**, not from a single settings
page. You decide which advanced link attributes each format's editors are allowed to
use. A format meant for trusted staff (say *Full HTML*) might expose all of them,
while a locked‑down format for comments might expose none.

## Open a text format's editor settings

1. Log in as a user who can administer filters (an administrator by default).
2. Go to **Configuration → Content authoring → Text formats and editors**, or
   navigate directly to `/admin/config/content/formats`.
3. Click **Configure** next to a text format that uses **CKEditor 5** (for example
   *Full HTML* or *Basic HTML*). Formats using a different editor won't show the
   CKEditor 5 settings described here.

## Find the Advanced links panel

The **Advanced links** settings appear automatically whenever the format's toolbar
includes CKEditor's core **Link** button — you don't add a separate button for this
module. Scroll down to the **CKEditor 5 plugin settings** area (a set of vertical
tabs beneath the toolbar configurator) and select the **Advanced links** tab.

If you don't see it, make sure the **Link** button is present in the toolbar: drag it
from the *Available buttons* row into the *Active toolbar* row in the toolbar
configurator above.

## Choose the enabled attributes

The Advanced links panel is a list of checkboxes — one per `<a>` attribute the module
can manage. Nothing is enabled by default, so tick only the ones you want editors of
this format to be able to set:

- **ARIA label** — adds an `aria-label` field. Lets an author give a link an accessible
  name distinct from its visible text — handy for icon‑only or repeated "read more"
  links.
- **Title** — adds a `title` field, the tooltip text shown on hover.
- **CSS classes** — adds a `class` field so authors can style a link (for example turn
  it into a button, or add tracking/utility classes) without custom code.
- **ID** — adds an `id` field, so the link can be targeted by a URL fragment anchor
  (in‑page navigation).
- **Open in new window** — adds a checkbox that writes `target="_blank"`. Enabling this
  one also registers CKEditor's link decorator behind the scenes so the attribute is
  applied cleanly.
- **Link relationship** — adds a `rel` field for values such as `nofollow`,
  `noopener noreferrer`, or `sponsored` — useful for SEO and for the security of links
  that open in a new tab.

Only the attributes you check will appear in the editor's link dialog for this format.
Repeat the process for each format that needs them; formats are configured
independently.

## How it interacts with allowed HTML

If the format also uses **Limit allowed HTML tags and correct faulty HTML**, an
attribute will only actually work if it is permitted on the `<a>` tag. The good news is
that ticking an attribute here automatically contributes the matching allowed‑HTML
fragment (for instance `<a title>`, `<a class>`, `<a rel>`, or `<a target="_blank">`),
so you normally don't have to hand‑edit the *Allowed HTML tags* field. If you have
tightly locked that field down elsewhere, double‑check the `<a>` entry still allows the
attributes you enabled.

## Save

Click **Save configuration** at the bottom of the text format form. Open any content
form that uses this format, insert or edit a link, and the extra fields you enabled will
be waiting in the link dialog. The settings are plain, exportable configuration, so they
travel with the text format when you deploy config between environments.
