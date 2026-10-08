# Configuration

## Permissions

Two permissions, granted under **People → Permissions**:

- **Administer access_by_ref settings** (restricted, trusted admins) — full control
  of the rules UI (create/edit/delete). This is the real gate on the configuration.
- **Access node by reference** (not restricted, meant to be granted broadly) — the
  runtime toggle. The reference-based rules apply only to roles that hold this
  permission; roles without it are unaffected. Grant it to the roles that should be
  able to *gain* access through your rules.

## Creating a rule

Go to **Configuration → Content authoring → Access by Reference**
(`/admin/config/content/access_by_ref`) and add an **Access by ref config** rule.
Each rule has these fields:

| Field | What it means |
|---|---|
| **Machine name / Label** | Identifies the rule. |
| **Bundle** | The node type the rule applies to. |
| **Field** | The field on that bundle whose value is examined (any field except the body). |
| **Reference type** | How the match is made — `user`, `user_mail`, `shared`, or `inherit` (explained below). |
| **Extra field** | A **user** field, used only by the `shared` type — the profile value to match against. |
| **Rights type field** | For the `inherit` type only: which operation (`view`/`update`/`delete`) is checked on the referenced parent. |
| **Assign read rights?** | Grant **view** when the rule matches. |
| **Assign update rights?** | Grant **update** when the rule matches. |
| **Assign delete rights?** | Grant **delete** when the rule matches. |

You can enable any combination of read/update/delete, and you can create several
rules on the same bundle — they are all evaluated, and the first matching allowed
operation wins.

## The four reference types

- **user** — the chosen field is an entity reference to users. Access is granted if
  any referenced user is the current user. (This is the safest type: someone with
  edit rights must deliberately add the user to the node's reference field.)
- **user_mail** — the chosen field holds email addresses. Access is granted if any
  of them matches the current user's **account email** (case-insensitive).
- **shared** — access is granted if a value in the node's field equals a value in
  one of the current user's **own profile/user fields** (the one named in *Extra
  field*).
- **inherit** — for each entity the node's field references, the module checks
  whether the current user already has the configured *Rights type* operation on
  that referenced entity; if so, the rule's rights are granted on this node. This
  chains access transitively (parent → child), and is handler-aware for referenced
  nodes, users, and paragraphs.

## Important cautions

- **inherit** checks a single operation on the parent but then grants whichever of
  read/update/delete you enabled — the checked operation and the granted operations
  are independent, so a "view on parent" rule can grant "update on child" if you
  tick it. There is also **no loop protection** on chained inherit rules, so
  configure them carefully.

Saving a rule clears the render cache so the new access takes effect immediately.

## Setting a rule with Drush

Rules are `abrconfig` config entities, so you can also create them in code:

```php
\Drupal::entityTypeManager()->getStorage('abrconfig')->create([
  'id' => 'article_owner', 'label' => 'Article owner edit',
  'bundle' => 'article', 'field' => 'field_owner', 'reference_type' => 'user',
  'rights_read' => TRUE, 'rights_update' => TRUE, 'rights_delete' => FALSE,
])->save();
```
