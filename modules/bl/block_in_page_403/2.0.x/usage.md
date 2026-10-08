Block In Page 403 adds a block-visibility condition ("Show in page 403") so a chosen block appears on the 403 access-denied page.

---

Block In Page 403 ships a single core Condition plugin (`page_403`, class `Page403Request`) that becomes a "Show in page 403" checkbox in every block's *Visibility* settings under Structure → Block layout. When checked, the condition returns TRUE only when the current request carries a 403 exception (it reads the request `exception` attribute and compares `getStatusCode() == 403`); when unchecked the condition is inert (always TRUE) so it never restricts the block. Because it is an ordinary block visibility condition, it is additive — it can only narrow where a block shows, layered on top of the block's normal access checks — and it depends only on core Block. There are no routes, permissions, services, or settings form of its own; you configure it entirely through the core block placement/configuration UI.

---

- Show a custom login/help block on the 403 access-denied page.
- Present a "you need to sign in to view this" message on 403.
- Add a contact or support link block to access-denied responses.
- Display a themed access-denied notice instead of the bare default 403.
- Place a search block on the 403 page so users can find allowed content.
- Show a menu block of public sections on the denial page.
- Combine "Show in page 403" with other visibility conditions (pages, roles) on the same block.
- Restrict a block so it appears ONLY on 403 responses (check the box; leave it as the only positive context).
- Add a "request access" call-to-action block on denied pages.
- Show an anonymous-only login prompt block on 403 (pair with the core role/user condition).
- Explain to editors why a page is restricted via a custom block on 403.
- Provide a branded error experience for access-denied without a custom theme template.
- Direct denied users to a public homepage or landing block from the 403 page.
- Surface a language switcher or region block on the 403 page.
- Show promotional or membership-signup content on access-denied pages.
- Pair with Block In Page 404 to cover both error pages with blocks.
- Add a feedback form block so users can report an unexpected 403.
- Keep a block hidden on normal pages but revealed only on the denial page.
- Improve the 403 UX site-wide without editing controllers or templates.
- Use the negate option to explicitly exclude a block from the 403 page.
