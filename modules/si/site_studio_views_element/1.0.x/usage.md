<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Site Studio Views Element adds a "Drupal View" element to the Acquia Site Studio (Cohesion) builder that lets an author pick a View block display from a dropdown and render it inside a component or template.

---

Site Studio is Acquia's commercial visual page builder with its own element vocabulary; Views is where a Drupal site's listings live. Without a bridge, embedding a View in a Site Studio layout means creating a block instance for each View block display, placing it in the theme's hidden region, and re-placing it in every environment — brittle, and prone to the "Undefined block" errors Site Studio shows when a referenced block goes missing. This module removes that chore: it registers a single Cohesion custom element (plugin id `site_studio_views_element`, label "Drupal View") whose only setting is a `view_id` select. That select is built at runtime from every View, listing only displays whose `display_plugin` is `block`, keyed as `view_id:display_id`; page, feed, attachment and other display types are deliberately excluded. Choosing one and rendering the element runs `Views::getView()`, sets the chosen display, and returns the display's `buildRenderable()` render array wrapped in the module's own `site-studio-views-element` theme hook.

The practical value is that listings stop being a block-management task. An author drops the element onto a component, picks "Latest news – Block", and the listing appears wherever that component is placed — no hidden-region blocks, no per-environment block placement, and no extra rows loaded on every page just because a block sits in a region. Because the output is a normal Views render array built through core's `#type => 'view'` element, the View's access plugin, filters, sorts, pager, and cache metadata all still apply — the module does not re-implement any of that, it just hands core the display to build.

Two constraints shape where this is useful. First, only **block** displays appear in the dropdown; a listing you want to embed must have a Block display on its View. Second, the element passes **no arguments** to the View — it calls `buildRenderable($display)` with no `$args`, so a display with contextual filters resolves them only from its own "Provide default value" settings, not from anything the element or the surrounding Site Studio context supplies. Plan contextual filters accordingly.

This is an add-on to a commercial stack: the `cohesion` module (Site Studio's Drupal side) and Acquia's Site Studio licence are hard requirements, and `views` is the other dependency. The core range `^8 || ^9 || ^10 || ^11` spans four majors and reflects intent more than test coverage — the element API belongs to Site Studio, which versions on its own schedule, so verify against the installed Site Studio version.

---

- Embed a View listing inside a Site Studio component.
- Add a "Drupal View" element to a Site Studio template.
- Let an author place a listing without creating a hidden-region block.
- Show a "latest news, N items" block display in a landing page.
- Render a category or tag listing inside a designed component.
- Pick the View block display from the Site Studio element settings dropdown.
- Reuse an existing View block display across several Site Studio components.
- Keep Views filters, sorts and pager in a page-builder layout.
- Preserve the View's own access checks when embedded (access is enforced at render).
- Stop maintaining per-environment block placements for embedded Views.
- Avoid "Undefined block" errors from missing block instances in components.
- Reduce hidden-region block bloat that renders on every page load.
- Give a marketing team self-service listings inside Site Studio.
- Expose only block displays for embedding, hiding page/feed/attachment displays.
- Add a Block display to a View specifically so it becomes embeddable here.
- Design contextual-filter default values on the display (the element passes no args).
- Override the `site-studio-views-element` template to wrap or restyle the embed.
- Audit which View block displays are embedded across Site Studio components.
- Confirm the Acquia Site Studio licence and `cohesion` module are in place before relying on this.
- Verify the element against the installed Site Studio / Cohesion version after an upgrade.
- Pair with Views Minimum Condition to hide a component when its View has no results.
