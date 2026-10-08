# Configuration

Everything is set on one form at **Configuration → Web services → Share Everywhere**
(`/admin/config/services/share_everywhere`), gated by the **Administer share
everywhere** permission (`administer share everywhere`). There is no per‑viewer
permission — whether buttons appear is controlled entirely by the settings below.

## Choosing and styling the buttons

- **Buttons** — enable the networks you want (Facebook like, Facebook share,
  X/Twitter, LinkedIn, Messenger, Viber, WhatsApp, Copy URL). For each button you
  can set its **title**/tooltip, its **image** (icon), and a **weight** to control
  the order they appear in.
- **Title** and **Display title** — a heading shown above the buttons, and whether
  to show it.
- **Share icon** — the icon used in collapsible mode.
- **Collapsible** — when on, the buttons stay hidden behind the share icon until
  clicked.
- **Alignment** — align the button row **left** or **right**.
- **Include CSS / Include JS** — leave ticked to use the module's bundled styling
  and behaviour; untick to turn them off and style the buttons entirely in your own
  theme.

## Where the buttons appear — four options

1. **Extra field** (Location = *content*) — the module exposes a `share_everywhere`
   display component on node and Commerce product displays. Choose which **content
   types** and **view modes** it may show on (and the same for Commerce product
   types and their view modes), then place the *Share Everywhere* field on the
   relevant *Manage display* page. A common choice is to show it only on the *full*
   view mode, not teasers.
2. **Links area** (Location = *links*) — instead of the content region, the buttons
   are injected into the node's links area (near the "Read more"/comment links).
3. **Block** — place the **"Share Everywhere Block"** in any region; it shares the
   current page's URL and respects normal block visibility settings.
4. **Views field** — add the *Share Everywhere* field to any View.

Set **Location** on the settings form to switch between the extra‑field and
links‑area placements; the block and Views field are always available once the
module is enabled.

## Per‑entity opt‑in

Turn on **per‑entity** mode and each node/product edit form gains a *Share
Everywhere Settings → Show social share buttons* checkbox. Only the entities you
tick then show the buttons — useful when you want sharing on some items but not all.

## Restricting by path

Use the **restricted pages** setting to show or hide the buttons on specific paths,
the same way core block visibility works.

## Theming and custom icons

Because each network renders through its own Twig template (`se-x.html.twig`,
`se-whatsapp.html.twig`, and so on), you can override a single button in your theme
without affecting the rest, or swap the SVG icons for your own branding. To take
full control of the styling, untick **Include CSS**/**Include JS** above and provide
your own — the module ships a SASS source you can adapt as a starting point.
