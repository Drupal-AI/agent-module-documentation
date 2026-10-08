# Configuration

Group Actions has no settings page — you configure each **action** at the point where you use
it (in a VBO view's bulk operations, or an ECA action step). This page explains the six
actions and the options on their configuration form.

## The six actions

| Action | Operates on | What it does |
|---|---|---|
| **Add group content** | content (e.g. nodes) | Adds the selected content to a group. |
| **Remove group content** | content | Removes the selected content from a group. |
| **Update group content** | content | Updates the group relationship fields of the selected content. |
| **Add group member** | users | Adds the selected users as members of a group. |
| **Remove group member** | users | Removes the selected users from a group's membership. |
| **Update group member** | users | Updates existing memberships (for example changing group roles). |

The three "content" actions also produce per-entity-type variants automatically, so a view of
a specific entity type only offers the relevant ones.

## Options on the action form

When you add one of these actions, you configure:

- **Operation** — create / update / delete. This is usually preset by the action you chose
  (for example "Add…" presets create), so you rarely change it.
- **Content plugin** — the Group relation/content plugin the action targets (for example
  `group_membership` for members, or a group node plugin for content). The member actions
  preset this to membership for you. If the entity is bundle-aware, the correct bundle variant
  is appended automatically at run time.
- **Group** — which group to act on. Enter a **numeric group ID or a UUID**. This field is
  **token-aware**, so you can resolve the group dynamically — for example from a field on the
  content being processed (`[node:field_group:target_id]`). In most contexts it's an
  autocomplete; inside the ECA BPMN.io modeller it falls back to a plain text box.
- **Entity** *(optional)* — the entity to operate on. Leave it blank to use the entity the
  action is running against (the normal case); set it (also token-aware) to target a different
  entity.
- **Values** — a textarea of relationship field values, **one `key: value` per line** (repeat
  a key for multiple values). These set fields on the relationship when adding or updating —
  for example `group_roles: mygroup-editor` to assign a group role when adding a member.
  Tokens are supported, and values are ignored for delete operations.
- **Add method** *(create only)* — how to handle an item that's already related:
  - **Skip existing** *(default)* — don't add a duplicate.
  - **Always add** — allow another relationship of the same content.
  - **Update existing** — upsert: update the existing relationship instead of adding a new one.

## Access — no bypass

Each action's access check delegates to Group's own permissions. For Group v2/v3 it checks the
relevant `create` / `update` / `delete` relationship permission (including `any`/`own` and the
group's admin permission, with site super-user and admin roles allowed); for Group v1 it checks
the equivalent `"<operation> <plugin> content"` permission on the group. If the group doesn't
exist, or the content plugin isn't installed on that group type, the action is forbidden. In
short: a user can only run an action where Group already permits that change — Group Actions
never grants extra access.

## Typical setups

- **Bulk move content into a group:** build a VBO view of the content, add the *Add group
  content* operation, and set the target group.
- **Automate membership with ECA:** in an ECA model, add an *Add group member* action on an
  event like "user login" or "user created," setting the group (often via a token) and any
  `group_roles` values.
