# flexslider — agent start

Integrates the FlexSlider 2 jQuery slider/carousel library. Core concept: reusable
**optionset** config entities (`flexslider.optionset.{id}`, type id `flexslider`) that hold
every library setting. A bundled **image field formatter** (`flexslider`) and a **Views style**
(`flexslider`) render content through a chosen optionset. Depends on core `image`. Config UI:
**Admin → Config → Media → FlexSlider** (`/admin/config/media/flexslider`); route
`entity.flexslider.collection`. Single permission `administer flexslider`.

- Create/manage optionsets, apply the image formatter or Views style, and install the JS library → [configure/flexslider.md](configure/flexslider.md)
- Permissions → [permissions/flexslider.md](permissions/flexslider.md)
