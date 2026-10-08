Layout Builder Tabs adds a single "Tabs" layout (section type) to Drupal's core Layout Builder; every block you place in that section renders as its own tab, with an accessible tab list and tab panes generated automatically.

---

The module registers one layout plugin, `tabs`, through `layout_builder_tabs.layouts.yml` (using core `layout_discovery`, so there is no plugin manager, config form, or settings of its own). The layout has a single region, `tabs`, and its class `TabsLayout` extends `LayoutDefault`; when the active theme is Olivero it additionally attaches the `olivero/tabs` library so the markup inherits the theme's tab styling. The Twig template `templates/tabs.html.twig` builds a `<ul class="tabs">` nav plus a `.tab-content` set of panes, ordering the blocks with the module's custom Twig filter `sortbyweight` (registered by the `SortByWeight` Twig extension service). Each block's tab label comes from the block's rendered `#title` markup, falling back to the block's configured label. Inside the Layout Builder editing UI the template renders a simplified stacked preview (labels above each block) because the tabbed markup would otherwise break the editor. The module ships CSS/JS (`layout_builder_tabs/tabs`, depending on `core/jquery`) to drive the client-side tab switching on the rendered page. There are no permissions, no Drush commands, and no configure route — you use it entirely by adding a Tabs section in Layout Builder.

---

- Turn a stack of Layout Builder blocks into a tabbed interface on a node's layout.
- Present product specs, reviews, and shipping info as three tabs on a product page.
- Build an FAQ or documentation page where each section is a separate tab.
- Group related fields/blocks into tabs to shorten a long landing page.
- Create a "Details / Gallery / Map" tab set for a venue or event entity.
- Add tabbed content to a content type's default layout so every node of that type gets tabs.
- Override a single node's layout to show its blocks as tabs (per-entity Layout Builder override).
- Provide an accessible tabbed UI without writing any custom layout plugin or JS.
- Use block titles as tab labels automatically, or fall back to each block's configured label.
- Order tabs by adjusting the weight of blocks within the section (uses the `sortbyweight` filter).
- Combine core and custom blocks (views blocks, inline blocks) in one tab set.
- Get Olivero-themed tabs automatically when the site runs the Olivero theme.
- Reduce vertical scrolling on dashboard-style pages by collapsing content into tabs.
- Present multilingual or multi-audience content variants side by side as tabs.
- Show "Overview / Pricing / Comparison" marketing sections as tabs in a landing layout.
- Add a tabbed "related resources" area at the bottom of an article layout.
- Use the stacked in-editor preview to arrange tab content, then see real tabs on the live page.
- Build step-by-step or category browsing UIs where each tab is a distinct block.
- Wrap a media gallery block and a description block into a compact tabbed card.
- Deploy tab layouts as configuration (they are stored in the entity view display's Layout Builder sections).
