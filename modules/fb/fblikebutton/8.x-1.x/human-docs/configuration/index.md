# Configuration

Facebook Like Button is configured on its settings form (route
`fblikebutton.settings`, reached from the module's **Configure** link on the
**Extend** page or under **Configuration**). A separate permission controls who can
*see* the button.

## The settings form

The form lets you decide where the button appears and how it looks:

- **Content types** — choose which content type(s) the Like button is automatically
  added to. Types you do not select never show the button.
- **Display location** — by default the button appears only on a node's **full page**
  view; you can also enable it on **teasers**.
- **Button type** — a **dynamic** button that likes the current page's URL, and/or a
  **static** button that always likes one fixed URL (for example your homepage).
- **Appearance** — layout style (standard, box count, button count, button), size
  (small/large), the verb ("Like"/"Recommend"), colour scheme (light/dark), language
  (a Facebook locale code such as `fr_FR`), and width are all adjustable.

Set these to taste and save.

## The optional Like box block

Beyond the per‑node button, the module provides an optional **block** containing a
Facebook Like box whose target URL does not change — a site‑wide "like our site on
Facebook" element to sit alongside each node's "like this page" button. Place it at
**Structure → Block layout** (`/admin/structure/block`) in whatever region you want,
and set its visibility as usual.

## Who can see the button — permissions

Grant the **Access FB Like button** permission at **People → Permissions**
(`/admin/people/permissions`) to the roles that should see the button. This governs
visibility regardless of whether the visitor is logged into Facebook. Note that
authors do **not** need any extra text‑format/input permission for the button to be
added to their content.

## Privacy and consent

The Like button embeds Facebook's third‑party script, which can set cookies and let
Facebook observe visitors even before they click. Integrate the button with your
cookie‑consent flow and disclose the third‑party tracking per your jurisdiction
(for example GDPR).

## Save

Save the settings form, and save the permissions page after assigning roles. Changes
apply to newly rendered pages immediately (clear caches if a change does not appear).
