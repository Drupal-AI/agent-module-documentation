# Configuration

Style Switcher needs a small amount of setup before visitors see anything: you
define the alternate styles on the admin page, then place the switcher block so
visitors can pick between them.

## Open the settings page

1. Log in as a user with the **Administer Style Switcher** permission (an
   administrator by default). You can grant it to other roles at **People →
   Permissions** (`/admin/people/permissions`).
2. Go to **Configuration → User interface → Style Switcher**, or navigate directly
   to `/admin/config/user-interface/styleswitcher`.

## Define your styles — per theme

Styles are configured **per theme**. Two sources feed the list a visitor sees:

- **Theme-provided alternate stylesheets** — if your theme ships alternate
  stylesheets, they are picked up automatically for that theme.
- **Styles you add here** — as a site builder you can add further alternate
  stylesheets from the admin section, giving each one a name and pointing it at a
  CSS file.

Each style you add is stored as a configuration entity, so it exports and deploys
with your site configuration (`drush config:export` / `config:import`) like any
other config. The per-theme configuration page only lets you configure real,
installed themes — you cannot point it at an arbitrary or uninstalled theme.

Use the add/edit links on the admin page to create and adjust individual styles.
Give each a clear, visitor-friendly name (for example *High contrast*, *Large
text*, *Print friendly*), since that name is what appears in the switcher.

## Place the switcher block

Visitors change styles through the **Style Switcher** block:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** in the region where you want the switcher to appear (a
   sidebar is common).
3. Find and place the **Style Switcher** block, and configure its visibility as you
   would any block.

The block renders your defined styles as a list of links. A visitor clicks one and
the site re-renders with that stylesheet; a small overlay stylesheet
(`styleswitcher-overlay.css`) backs the preview. The choice is stored in a cookie,
so it persists as the visitor moves between pages and when they return.

## Who can do what

- **Choosing a style** needs no permission — it is available to every visitor,
  because selecting an appearance is not a privileged action.
- **Administering styles** (adding, editing, deleting) is gated entirely by the
  single **Administer Style Switcher** permission. Grant it only to trusted roles.

## A note on accessibility

Offering an opt-in high-contrast, large-text, or dyslexia-friendly stylesheet is a
recognised accessibility accommodation and a legitimate reason to use this module.
Bear in mind, though, that it does not replace accessible defaults, and each
alternate look is only as accessible as the CSS you write for it — so treat the
variants as a complement to good baseline design, not a substitute.
