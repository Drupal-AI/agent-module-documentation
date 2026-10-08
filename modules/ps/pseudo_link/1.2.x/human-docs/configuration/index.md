# Configuration

Setting up a pseudo link is two steps: configure it for an entity and bundle, then
place the pseudo field on that bundle's display.

## 1. Enable and configure pseudo links

1. Log in as an administrator and go to **Configuration → Pseudo Link**
   (`/admin/pseudo-link-configurations`).
2. **Enable** pseudo links for the entity types and bundles you want.
3. For each enabled bundle, set:
   - **Link text** — the text displayed for the pseudo link.
   - **CSS classes** — classes applied to the link, for styling.
   - **Wrapper classes** — classes applied to a wrapper element around the link, for
     layout.
   - **Open in new tab** — toggle whether the link opens in a new browser tab.
4. **Save.**

## 2. Place the field on the display

1. Go to the bundle's **Manage display** page (for example, **Structure → Content types
   → *(type)* → Manage display**).
2. Enable the pseudo link field and drag it up or down to position it among the other
   fields.
3. **Save.**

The pseudo link then appears automatically on the selected entities — on their detail
pages and in view blocks or pages — according to your configuration.

> **Tip:** if a change doesn't show up immediately, flush the caches. New
> configurations and display changes sometimes need a cache clear before they appear on
> the Manage display page or on the rendered pages.

## Troubleshooting

- **Links not appearing?** Check that pseudo links are enabled for that specific entity
  and bundle, and that the field is placed on the display.
- **CSS not applied?** Make sure the CSS classes are valid and that your theme includes
  the relevant styles.
- **Links not opening in a new tab?** Verify the "Open in New Tab" option is enabled for
  that bundle.
