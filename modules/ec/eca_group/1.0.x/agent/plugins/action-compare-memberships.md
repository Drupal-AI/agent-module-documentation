<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Action: List — compare members in memberships

- **Plugin ID:** `eca_group_list_compare_memberships`
- **Label:** "List: compare members in memberships"
- **Class:** `Drupal\eca_group\Plugin\Action\ListCompareMemberships`
- **File:** `src/Plugin/Action/ListCompareMemberships.php`
- **Extends:** `Drupal\eca_base\Plugin\Action\ListCompare` (from the `eca_base` submodule of ECA)
- **Attributes:** core `#[Action(...)]` + ECA `#[EcaAction(description: 'Compares the members in two lists of memberships.', version_introduced: '1.0.0')]`

## What it does

A thin subclass of ECA Base's generic `ListCompare` action, specialised for Group
memberships. The parent action takes two ECA token lists and produces either their
diff or their intersection; this subclass makes the comparison work on
`Drupal\group\Entity\GroupMembershipInterface` items and match them by the
underlying **member entity** (the user), not by object identity. All list-token
inputs/outputs and the diff-vs-intersect operation are inherited from `ListCompare`
— see ECA Base for those settings; this class only overrides how items are
filtered and matched.

## Overridden methods (source)

- `cleanupList(iterable $list): array` — filters an input list to only group
  memberships. Keeps a value if it `instanceof GroupMembershipInterface`, or if it
  is a `TypedDataInterface` whose `getValue()` is a `GroupMembershipInterface`
  (so ECA-wrapped tokens are unwrapped). Anything else is dropped.
- `getDiff(iterable $list1, iterable $list2): array` — after cleanup, returns the
  memberships in `$list1` whose member is **not** present in `$list2`. Membership
  equality is `$m1->getEntity()->id() === $m2->getEntity()->id()` — i.e. same
  member entity id.
- `getIntersect(iterable $list1, iterable $list2): array` — after cleanup, returns
  the memberships in `$list1` whose member **is** also present in `$list2`, by the
  same `getEntity()->id()` match.

Note: matching is by the membership's member entity id via `getEntity()`, so two
different `GroupMembership` objects for the same user count as equal.

## Configuration schema

`config/schema/eca_group.schema.yml` maps
`action.configuration.eca_group_list_compare_memberships` to type
`action.configuration.eca_list_compare` — it reuses ECA Base's list-compare
config (list tokens, result token, operation) unchanged; ECA Group adds no extra
config keys for this action.

## Usage in an ECA model

Produce two membership lists elsewhere in the model (e.g. from group queries or
events), reference them as the two list tokens, choose diff or intersect on the
inherited settings, and read the resulting membership list from the result token
in later plugins.
