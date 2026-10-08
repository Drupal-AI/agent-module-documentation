Adds Pinterest-specific meta tags (Rich Pins description/id/media/url and site verification) for better Pinterest sharing.

---

Pinterest reads its own `pin:*` meta tags plus a verification tag to enable Rich Pins and confirm site ownership. This submodule registers those tags as Metatag plugins so they can be set as defaults or per entity with token support. Depends on the main Metatag module. Useful for recipe, product, DIY, and visual-content sites that get significant Pinterest traffic.

---

- Provide a Rich Pin description with `pin:description`.
- Set a Rich Pin id with `pin:id`.
- Specify the pinnable media with `pin:media`.
- Set the canonical `pin:url`.
- Verify site ownership with the `pinterest` verification tag.
- Enable Rich Pins for articles/recipes/products.
- Improve how content saves to Pinterest boards.
- Set Pinterest defaults globally.
- Override Pinterest tags per content type.
- Populate the pinnable image from an image field via tokens.
- Increase referral traffic from Pinterest.
- Keep Pinterest config exportable.
- Provide accurate descriptions on saved pins.
- Standardize Pinterest tagging across a site.
- Confirm domain ownership in the Pinterest dashboard.
- Combine with Open Graph for complete social coverage.
