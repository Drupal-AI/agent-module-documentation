# ds_switch_view_mode — agent start

Display Suite submodule: adds a per-node control on the node edit form to pick which entity
view mode Display Suite renders that node with. Requires `ds`. No admin config page — the
switcher appears on the node form; access is permission-gated (`src/Permissions.php`, dynamic
per-bundle permissions). Enable the module, grant the switch permission to a role, then choose
a view mode when editing a node. The chosen view mode is stored per node (content, not config).
