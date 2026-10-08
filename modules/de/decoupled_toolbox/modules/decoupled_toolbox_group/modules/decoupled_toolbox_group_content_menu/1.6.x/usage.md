Decoupled Toolbox for Group Content Menu exposes Group Content Menu menu trees in the decoupled JSON output.

---

It subscribes to the parent renderer's `EVENT__RENDERER__OUTPUT__RENDERED__PREFIX . 'group_content_menu'` event with `MenuLinkTreeBuilder` (`onOutputRendered()`), which loads and sorts the menu link tree for the `group_content_menu` entity and writes a structured, weight-ordered menu array into that entity's decoupled output. Requires the contrib Group Content Menu module.

---

- Expose a group's content menu as a nested JSON tree for headless navigation.
- Serve group menu links (title, url, children) to a decoupled frontend.
- Combine with the Group collection endpoint to deliver both content and navigation.
- Keep menu ordering (weight) intact in the JSON output.
- Render `group_content_menu` entities on the Decoupled display and enrich them automatically.
