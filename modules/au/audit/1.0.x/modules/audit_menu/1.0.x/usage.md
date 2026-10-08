Scores menu architecture: structure, depth, and navigation issues per menu.

---

Registers the `menu` analyzer (`MenuAnalyzer`, weight 3). It walks each menu, reporting structure and depth and flagging menus nested deeper than `max_menu_depth` (default 4) along with other navigation issues (orphaned links, disabled links, external links). Results are grouped per menu under a single Menu Analysis check.

---

- Flag menus nested deeper than `max_menu_depth` (4).
- Report per-menu structure and link counts.
- Detect navigation issues (orphaned, disabled, or broken links).
- Tune the acceptable depth for your IA.
- Run headless: `drush audit:run menu --format=json`.
- Weight 3 by default in the Project Score.
