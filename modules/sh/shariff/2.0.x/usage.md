Shariff Sharing Buttons integrates the privacy-friendly Shariff (heise online) social share widget into Drupal, exposing share buttons as a **block** and as a per-node **display field**, configured from one global settings form.

---

Shariff renders share buttons that do not phone home to the networks until clicked, so no
tracking cookies are set on page load. The module provides a global settings form at
`/admin/config/services/shariff` (route `shariff.settings_form`, config object
`shariff.settings`) where you pick the active services (Twitter, Facebook, WhatsApp, Mail,
etc.), the theme (`colored`/`grey`/`white`), CSS variant (`complete`/`min`/`naked`), button
style, orientation, and optional backend URL for share counts. It ships two ways to place the
buttons: a **block plugin** `shariff_block` ("Shariff share buttons") that can either use the
global defaults or override them per block instance, and an **extra display field**
`shariff_field` added to every node type (enable it under *Manage display*), which shares the
node's canonical URL and title. Output is themed through `shariff.html.twig` (theme hook
`block_shariff`), and the correct `shariff/shariff-<variant>` asset library is attached. The
module depends on the external **Shariff JavaScript library** (heise online, ≥ v1.4.6) placed
under `/libraries/shariff/`; `hook_requirements` reports an error until it is installed. It
requires no other Drupal modules; access to the settings form is gated by the core
*administer site configuration* permission.

---

- Add privacy-compliant social share buttons (no tracking until clicked) to a site.
- Place a Shariff block in a sidebar or footer region via *Block layout*.
- Show share buttons on every article by enabling the `shariff_field` on the node display.
- Choose which networks appear (e.g. only Twitter, Facebook, WhatsApp) globally.
- Override the service list or theme for a single block instance.
- Present buttons in a vertical stack in a narrow sidebar (`shariff_orientation: vertical`).
- Switch button appearance between colored, grey, and white themes.
- Use the minimal CSS variant when Font Awesome is already loaded by the theme.
- Use the "naked" variant to style the buttons entirely from the theme.
- Show share counts by pointing `shariff_backend_url` at a Shariff backend.
- Configure a Twitter "via" handle to attribute shared tweets.
- Preset the mail button subject/body for the E-Mail share option.
- Hide the buttons automatically where the browser Web Share API is available (`shariff_hidden`).
- Set a fixed canonical URL or share title instead of the auto-detected page values.
- Add a WhatsApp share button for mobile visitors.
- Add an Info button linking to an explanation of the Shariff privacy approach.
- Enable a Print button as one of the "services".
- Deploy consistent share settings across environments via exported `shariff.settings` config.
- Comply with GDPR by avoiding third-party tracking scripts on page load.
- Reorder the services (button order) with the drag-and-drop table on the settings form.
- Share the node title via the Metatag title token when the Metatag module is installed.
- Add share buttons only to specific content types by enabling `shariff_field` per type.
- Provide a Pinterest media URL for image sharing.
- Localize the buttons: the widget language follows the current interface language when supported.
