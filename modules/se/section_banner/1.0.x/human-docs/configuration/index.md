# Configuration

Section Banner is configured in two steps: define your banners and their display
rules on the settings screen, then place the block that renders them.

## Open the banner settings

1. Log in as an administrator.
2. Go to **Configuration → Content authoring → Section Banner**, or navigate
   directly to `/admin/config/content/section-banner`.

## Create or edit a banner

On the settings screen:

1. **Select the language** you want to configure. Section Banner is multilingual,
   and each banner can be set per language, with automatic fallback when a
   translation is missing.
2. **Enter the banner title and description.** Both support **tokens**, so you can
   include dynamic content such as the node title or the current user's name.
3. **Upload a banner image.** The image is shared across languages, so you set it
   once rather than per translation.
4. **Define the display rules** — this is how the banner knows where to appear.
   You can target by:
   - a **path** or **wildcard path pattern**,
   - a **content type** (bundle),
   - a **View** (by its machine name), or
   - a **route name**.
5. **Add optional CSS classes** to style the banner to match your design.

Save your changes.

## Place the Section Banner block

Go to **Structure → Block layout** and place the **Section Banner block** into the
region where banners should appear (typically a header or a section-top region).
On any page that matches a banner's display rules, the block will render that
banner.

## Theming

The banner markup is produced by a Twig template,
`section-banner-block.html.twig`. Copy it into your theme and override it to fully
control the HTML and match your design. The module is built with proper cache
contexts and tags for performance.

## Clear caches

After creating or changing banners, **clear the site cache** (Drush `cr` or
**Configuration → Performance → Clear all caches**) so the banners display
correctly.
