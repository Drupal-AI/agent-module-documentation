# Configuration

Setting up Access Policy has two sides: an **administrator** defines the reusable
rules and policies and decides who may assign them, and an **author** then applies
a policy to individual content from its Access tab.

## The permissions, and why they are layered

Grant these at **People → Permissions** (`/admin/people/permissions`):

- **Administer access policy entities** — lets a user define access rules and
  build them into policies. This is a restricted, trusted-admin permission; keep
  it to site administrators.
- **Set entity access policy** — lets a user open the **Access** tab on an entity
  and assign a policy to it. Grant this to the editors who should manage per-item
  access.
- **A per-policy permission for each policy** — every policy you create generates
  its own permission, so you can control *which* policies a given role may assign.
  This is the safeguard that stops an author applying a restriction they should
  not control: grant only the policies each editorial role should be allowed to
  use.

## Define rules and build policies

As an administrator (with *Administer access policy entities*):

1. Create the reusable **access rules** — each rule expresses one condition that
   contributes to an access decision.
2. Combine rules into a named **policy**. A policy is what an author will
   eventually pick, so give it a clear, recognisable name (for example
   *Finance only* or *Restricted until launch*).

Both rules and policies are stored as configuration, so they export and deploy
between environments like any other config.

## Assign a policy to content

As an author (with *Set entity access policy* and the per-policy permission):

1. Open the entity (for example a node) and go to its **Access** tab.
2. Choose the policy to apply.
3. Save. From then on, the policy governs who may view or edit that entity.

## Extending and verifying

- Developers can add custom access rules — the rule and handler systems are
  pluggable.
- A tailored **access-denied** page is shown to a user who has just been denied
  (the module's denial route is intentionally reachable so that page can render).
- Before relying on it, **test the behaviour through JSON:API, REST, Views and
  search**, not just normal page views — those are the channels where
  entity-access rules most commonly leak. Remember the module is at release
  candidate stage.
