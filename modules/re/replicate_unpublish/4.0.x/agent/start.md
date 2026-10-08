# Replicate Unpublished — agent index

Zero-config module that unpublishes a **node** (and every translation) when it is cloned by the
[Replicate](https://www.drupal.org/project/replicate) module. No UI, no settings, no permissions,
no Drush, no config schema. Depends on `replicate` + `replicate_ui`.

- **How the unpublish-on-clone behavior works and how to extend/replace it** →
  [extend/unpublish-on-replicate.md](extend/unpublish-on-replicate.md)

Key facts:
- Service `replicate_unpublish.replicate_node` = `ReplicateUnpublishNode` (event subscriber),
  arg `@language_manager`.
- Subscribes to `ReplicatorEvents::REPLICATE_ALTER` → method `setUnpublished()`.
- Acts only if the cloned entity `instanceof \Drupal\node\Entity\Node`; skips all other entity
  types. Sets `status = Node::NOT_PUBLISHED` on each existing translation.
