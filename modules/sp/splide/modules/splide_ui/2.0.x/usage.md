<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Splide UI is the administrative interface for the Splide module: it lets site builders create, edit, duplicate, and delete Splide slider **optionsets** through forms, and exposes the module's global settings. It adds the `administer splide` permission that gates all of it.

---

The core Splide module defines the `splide` optionset config entity but ships no UI; Splide UI supplies it. It registers the optionset **collection** at `/admin/config/media/splide` (the module's `configure` route, `entity.splide.collection`), an **Add** form (`/admin/config/media/splide/add`), **edit**, **duplicate**, and **delete** forms per optionset, and a **Splide UI settings** form at `/admin/config/media/splide/ui` (route `splide.settings`) that writes `splide.settings` (`module_css`, `splide_css`, `sitewide`). All routes require the `administer splide` permission it declares. The forms (`SplideForm`, `SplideSettingsForm`, `SplideListBuilder`) let you configure every optionset field — type, perPage, autoplay, arrows, pagination, skin, group, and responsive breakpoints — without editing YAML. It depends on the Splide module and has no config or plugins of its own.

---

- Create a new Splide slider optionset through a form instead of writing config YAML.
- Edit an existing optionset's type, perPage, autoplay, arrows, and pagination.
- Duplicate an optionset as a starting point for a variant slider.
- Delete optionsets that are no longer used.
- Browse all optionsets on the collection page at `/admin/config/media/splide`.
- Toggle the module's bundled CSS via the Splide UI settings form.
- Grant the `administer splide` permission to a site-builder role.
- Configure responsive breakpoints for a slider in the UI.
- Assign a skin to an optionset from a dropdown.
- Set the optionset `group` (e.g. main/nav) to pair sliders for thumbnail navigation.
- Provide editors a point-and-click way to tune sliders without deployment.
- Review and adjust the shipped `default` optionset.
- Enable/disable loading Splide's own library CSS site-wide.
- Manage optionsets that formatters and the Views style reference by id.
- Export configured optionsets as config after building them in the UI.
- Restrict slider administration to trusted roles via the permission.
- Set the number of breakpoints exposed on the optionset edit form.
- Create purpose-specific optionsets (hero, logo wall, testimonials) from the UI.
