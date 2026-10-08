# Group roles management — manual setup guide

**Group roles management** (`group_roles_management`) extends the
[Group](https://www.drupal.org/project/group) module so you can grant someone
permission to manage the members who hold a *specific* group role — rather than
the all‑or‑nothing "manage all members" that Group offers on its own. It turns
member administration into something you can delegate role by role.

The point is fine‑grained delegation. A group manager could be allowed to add,
remove, and change the members holding the "editor" role, while being kept away
from the "admin" members. That's exactly the kind of boundary communities, teams,
and membership sites need when they want to hand out responsibility without
handing over the keys.

Because it defines a delegation boundary, it is access‑control‑adjacent and worth
configuring with care. Granting management of a role effectively lets that person
control who holds it — so make sure the per‑role management permissions match your
intended trust model, and never let a lower‑privileged role manage a
higher‑privileged one, or delegation could be used to escalate.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Group.

There is **no central settings page**. The module adds new permissions that you
assign on each group type's permissions screen, described below.

## How to use it

Group roles management works through Group's own permission system. For each group
type, the module adds new permissions for managing the members of specific group
roles. To use it:

1. Go to a group type's **permissions** page in the Group administration UI.
2. Find the new per‑role member‑management permissions the module has added.
3. Grant each one to the group roles you trust to manage that particular role's
   members.

Review the result against your trust model before you rely on it: whoever can
manage a role controls who holds it, so keep delegation flowing downward (higher
roles managing lower ones), never the reverse.

Note the module requires **PHP 8.3**. Use Group roles management **1.0** with
Group 1.0, and this **2.0** release with Group 2.0 and Group 3.0.
