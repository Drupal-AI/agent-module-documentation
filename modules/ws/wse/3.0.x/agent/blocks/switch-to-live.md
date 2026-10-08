# Block: Switch To Live (`wse_switch_to_live`)

`Drupal\wse\Plugin\Block\SwitchToLiveBlock` — category *Workspaces*, admin label
"Switch To Live".

- **Visibility:** `blockAccess()` allows the block only when a workspace is active
  (`WorkspaceManagerInterface::hasActiveWorkspace()`).
- **Output:** a message — *"You are viewing the &lt;name&gt; workspace, switch to the Live
  version of the site."* — linking to the `wse.switch_to_live` route.
- Place it via Block Layout (`/admin/structure/block`) or any block-placing mechanism.

## The route it links to

`wse.switch_to_live` → `/wse/switch-to-live`
(`SwitchToLiveController::switchToLive`). Calls
`WorkspaceManagerInterface::switchToLive()` — this clears the requester's own active workspace
so they see Live — adds a status message, and redirects to `<front>`. It changes only the
requester's own view state (no content is modified), which is why the route uses
`_access: 'TRUE'`.
