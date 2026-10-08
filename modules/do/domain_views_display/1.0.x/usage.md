<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Domain Views Display lets a Views display hand off to a different display of the same view on specific domains of a Domain (Domain Access) multi-site.

---

Domain Views Display adds one Views display-extender plugin that makes any display domain-aware. When editing a view you get a **Domain overrides** section where, for each configured domain, you pick which display of that view should render instead of the current one. At request time the module reads the active domain from the Domain module's negotiator and swaps in the mapped display — for page routes (by decorating core's Views page controller), for pre-rendered view elements, and for embedded views (via `hook_views_pre_view`). It is meant as a simpler, in-view alternative to domain-specific configuration overrides, useful because Domain Config UI does not currently work with Views. It requires core Views and the contributed Domain module (>= 2.0), stores its mapping inside the view's own display-extender config, and adds no settings form and no permissions of its own. The override only takes effect when the visitor already has access to the target display, so it never widens who can see a view.

---

- Serve a different Views page on `b.example.com` than on `a.example.com` from a single view.
- Tailor an RSS/feed display per domain (e.g. a domain-specific feed on one affiliate site).
- Show a domain-specific block display of a view while the default display serves all other domains.
- Keep one canonical view but branch its listing layout per domain without cloning the whole view.
- Override a page display on a subset of domains and leave the rest on the default.
- Provide domain-specific promotional or landing listings driven by the same underlying query.
- Map several domains each to their own display within one view's configuration.
- Give site builders a per-domain display switch without writing config overrides by hand.
- Vary a view's title per domain (the module also switches the page's title callback).
- Configure everything from inside the Views UI rather than in exported config overrides.
- Run a shared multi-domain content listing while customizing presentation per affiliate.
- Fall back automatically to the original display on domains you did not map.
- Fall back to the original display when a visitor lacks access to the mapped display.
- Set up domain-aware displays for pages, feeds, blocks, and embedded views alike.
- Add domain-specific displays as config dependencies of the view (best-effort; see known issues).
- Migrate away from ad-hoc Domain config overrides for Views into an in-view mapping.
- Prototype per-domain presentation quickly on a Domain Access development site.
- Present the same content with different exposed styling or fields per domain via separate displays.
- Reconfigure the target display in one place when a domain's presentation needs change.
- Reduce the number of standalone views needed to support many affiliate domains.
