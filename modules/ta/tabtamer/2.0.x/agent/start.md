# Tab tamer — agent index

Reorder / rename / hide local-task tabs on a route via a per-route `tab_tamer` config entity.
One permission (`administer tab_tamer`); `configure` route `entity.tab_tamer.collection`
(`/admin/structure/tab-tamer`). Config schema provided; no plugins, no Drush.

- **The `tab_tamer` entity, the form, per-tab settings, and the render-time alter that applies them** →
  [configure/tab-tamer.md](configure/tab-tamer.md)

Key facts:
- Entity `tab_tamer` (`tabtamer.tab_tamer.<id>`); `config_export` = `id`, `label`, `tabs` **only**
  (the `status` on/off flag is NOT exported — it does not persist through config sync).
- `label` **is** the route machine name the entity controls; `TabTamer::getByRoute()` matches on it.
- `tabtamer_menu_local_tasks_alter()` applies it: overrides tab `#weight` + link title, and sets
  `#access` = `AccessResultForbidden` for tabs whose Display is unchecked. It can only hide/relabel/
  reorder — never grant access to a tab.
- Injects an "Add/Edit tabtamer" local task for users with `administer tab_tamer`.
