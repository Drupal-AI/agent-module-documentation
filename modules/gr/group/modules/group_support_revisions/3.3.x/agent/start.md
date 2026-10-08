# group_support_revisions — agent start

Submodule of **group**. Makes **revision access over grouped entities** depend on the group by
adding per-group revision permissions to every relation whose target entity is revisionable.
No config, no UI, no settings — enabling the module is the whole setup. Requires `group`.

It works purely by **decorating** Group's permission provider handler. See:

- How the decorator adds revision permissions → [permissions/group_support_revisions.md](permissions/group_support_revisions.md)
- The decoration pattern (extend point) → [extend/group_support_revisions.md](extend/group_support_revisions.md)

Parent module: [../../../../3.3.x/agent/start.md](../../../../3.3.x/agent/start.md).
