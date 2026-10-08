<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entityqueue Form Widget — agent index

Zero-config add-on to **Entityqueue**. Implements `hook_form_node_form_alter()` to add an
**"Entityqueues settings"** panel to the node form's `advanced` (sidebar) group, with one
checkbox per matching subqueue; on submit it adds/removes the node from the checked
subqueues. No settings form, no `configure` route, no own permissions, no plugins, no Drush.
Config schema is an empty `entityqueue_form_widget.settings` object.

- **When/where the widget appears, what it shows, submit behavior, permissions** →
  [api/behavior.md](api/behavior.md)

Key facts:
- The whole module is one hook-service class:
  `Drupal\entityqueue_form_widget\Hook\EntityqueueFormWidgetHooks` (autowired service).
- A subqueue's checkbox appears only when its queue's `target_type` == the node's entity type
  **and** the node's bundle is in `handler_settings.target_bundles` (or no bundle restriction).
- Each checkbox is permission-gated: the user needs `update <queue_id> entityqueue` **or**
  `manipulate all entityqueues` (both are **Entityqueue's** permissions — this module defines none).
- On save: checked → `EntitySubqueue::addItem()`; unchecked → `removeItem()`; unpublished/
  unscheduled nodes are not added.
- Form element tree: `$form['entityqueue_form_widget']['entityqueues'][<queue_id>]`.
