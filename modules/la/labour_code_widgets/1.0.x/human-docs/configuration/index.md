# Configuration

Setting up Labour code widgets has two parts: deciding which government widgets are
available site‑wide, and adding the field that actually displays a widget on your
content.

## Choose which widgets are available

1. Log in as a user with the **administer labour_code_widgets** permission.
2. Go to **Structure → Labour code widgets → Status**
   (`/admin/structure/labour-code-widgets/status`).
3. The form lists every available government widget — the labour‑code search
   engine, dismissal and departure/retirement notices, severance and precariousness
   calculators, the collective‑agreement finder, document templates, and so on.
   **All widgets are enabled by default.** Untick any you don't want editors to be
   able to choose, then save.

Your choices are stored in the module's configuration and control which widgets
appear as options when someone configures a field instance.

## Add the field to a content type

1. Go to **Structure → Content types → *(your type)* → Manage fields** (or the
   Manage fields screen of any other fieldable entity, such as a paragraph or
   custom entity).
2. Add a new field of type **Labour code widgets field**.
3. If you want more than one widget on a single entity, set the field's
   **cardinality** (number of values) accordingly.
4. On the same content type's **Manage display**, the field's formatter renders the
   selected government widget. Each field instance displays the widget you pick from
   the enabled list.

## The external script and your CSP

The widgets are drawn by `https://code.travail.gouv.fr/widget.js`, loaded
asynchronously in the **visitor's browser** — the module does not call the service
from your server. If you enforce a Content‑Security‑Policy, add
`code.travail.gouv.fr` to your `script-src` directive so the widgets are allowed to
load. This is also worth noting in your site's privacy documentation, since pages
carrying the field make a request to an external government domain.
