# webform_node — agent start

Adds a `webform` content type + Webform entity-reference field so forms live as nodes
(own URL, alias, menu, per-node submissions). Depends on `webform` + core node/field/path.
Per-node results under `/node/{node}/webform/results/*`; references report at
`/admin/structure/webform/manage/{webform}/references`.

- Webform field & node integration → [configure/webform_node.md](configure/webform_node.md)
- Per-node submission permissions → [permissions/webform_node.md](permissions/webform_node.md)
