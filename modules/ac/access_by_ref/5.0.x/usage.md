Access by Reference dynamically grants a logged-in user view/update/delete access to a node when the node references that user (or a value the user shares), turning entity-reference relationships into node-access rules. Rules are defined per node bundle + field in `abrconfig` config entities and applied through a `hook_node_access` implementation.

---

The module adds no fields of its own; instead an administrator creates one or more *Access by ref config* entities (`abrconfig`, at `/admin/config/content/access_by_ref`) that each bind a node **bundle**, a **field** on that bundle, a **reference type**, and which of read/update/delete to grant. On every node access check the module's `AccessByRefHooks::nodeAccess()` runs — but only for authenticated users who hold the non-restricted `access node by reference` permission and only for the configured bundles. Four reference types decide the match: `user` (the field references the current user's uid), `user_mail` (an email field on the node matches the user's account email, case-insensitive), `shared` (a node field value equals a value in one of the user's own profile/user fields, chosen via the *Extra field*), and `inherit` (the node references another node/user that the user already has the configured operation access on, chaining access transitively). When a rule matches, the hook returns `AccessResult::allowed()` for the operation whose rights checkbox is enabled; otherwise it returns `AccessResult::neutral()` (it never denies, so it only ever widens access). Grants are cached per-user and per-permissions. Access is "chainable" through `inherit`, and the module ships with no loop protection, so careless configuration can recurse. A Drupal 7 migration (`d7_access_by_ref`) is provided to import legacy configuration.

---

- Give a node's referenced editor (a `user` entity-reference field) update rights on that node without a custom module.
- Let a user listed in a node's "Owners" reference field view or edit that node.
- Grant an assignee update access to a task node that references their user account.
- Allow a user whose email appears in a node's email field to view that node (`user_mail` type).
- Share edit access to a document with everyone whose profile "department" value matches the document's department field (`shared` type).
- Cascade access: give a user edit rights on a child node because they can already edit the parent node it references (`inherit` type).
- Extend view access to project members referenced from a project node.
- Grant delete rights only (not view/update) to a referenced moderator role member.
- Apply access rules to specific node types only, leaving other content untouched.
- Match on a multi-value reference field so any of several referenced users gets access.
- Chain permissions across several reference hops (parent → grandparent) for hierarchical content.
- Give editors of a referenced `node` access to nodes that point at it via an entity-reference or Views-based reference field.
- Restrict the reference-based grant to logged-in users who hold the `access node by reference` permission, leaving anonymous unaffected.
- Roll out reference-based access gradually by toggling the `access node by reference` permission per role.
- Grant view access to a node whose reference field points at a user entity the current user already has view access to (`inherit` with a `default:user` handler).
- Import Access by Reference configuration from a Drupal 7 site using the bundled migration.
- Model "author plus named collaborators can edit" without writing node grant code.
- Provide record-level access for structured content (e.g. contracts, applications) keyed off a person reference.
- Layer additional access on top of core permissions without ever revoking existing access (rules only add).
- Configure separate read/update/delete grants per rule so viewers and editors get different rights on the same content.
