# masquerade — agent start

Privileged users switch into another account and back. Depends on core `user`. Switch UI:
`/masquerade` form + "Masquerade" block; profile tab `/user/{user}/masquerade`;
switch back at `/unmasquerade` (account-menu "Unmasquerade" link). No admin settings form
(`configure` = null); config is minimal.

- Permissions (static + dynamic per-role) → [permissions/permissions.md](permissions/permissions.md)
- Block, links & the two config keys → [configure/configure.md](configure/configure.md)
- Switch users in code (`masquerade` service) → [api/masquerade.md](api/masquerade.md)
- Veto/grant a target with `hook_masquerade_access()` → [hooks/hooks.md](hooks/hooks.md)
