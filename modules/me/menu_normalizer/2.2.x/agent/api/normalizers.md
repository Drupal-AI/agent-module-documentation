# Menu normalizers

Two `NormalizerBase` subclasses in `src/Normalizer/`, registered as `normalizer`-tagged services. Use
them by calling the core serializer, e.g.
`\Drupal::service('serializer')->normalize($menuLink, 'json')`.

## `MenuLinkNormalizer` — supports `Drupal\Core\Menu\MenuLinkInterface`

`normalize()` returns:

```
id                 → getPluginId()
weight             → getWeight()
title              → getTitle()
description        → getDescription()
menu_name          → getMenuName()
provider           → getProvider()
parent             → getParent()
enabled            → isEnabled()
expanded           → isExpanded()
resettable         → isResettable()
translatable       → isTranslatable()
deletable          → isDeletable()
route_name         → getRouteName()
route_parameters   → getRouteParameters()
url                → getUrlObject()->toString()
options            → getOptions()
meta_data          → serializer->normalize(getMetaData(), …)
delete_route       → getDeleteRoute()
edit_route         → getEditRoute()
```

`getSupportedTypes()` returns `[MenuLinkInterface::class => TRUE]`.

## `MenuLinkTreeNormalizer` — supports `Drupal\Core\Menu\MenuLinkTreeElement`

`normalize()` returns:

```
link            → serializer->normalize($object->link, …)   # a MenuLinkInterface, uses the normalizer above
has_children    → $object->hasChildren
depth           → $object->depth
in_active_trail → $object->inActiveTrail
subtree         → serializer->normalize($object->subtree, …) # recurses over child tree elements
count           → $object->count()
```

`getSupportedTypes()` returns `[MenuLinkTreeElement::class => TRUE]`.

So normalizing the array returned by `MenuLinkTreeInterface::load()`/`transform()` yields the full nested
tree in one call. There is no matching denormalizer for tree elements; `denormalize` is inherited from
`NormalizerBase` only where core provides it.

The caller is responsible for how the tree is built and which links it contains — these normalizers
serialize exactly the object graph they are handed and add no filtering of their own.

## Unchanged in 2.2.x

Both classes are byte-for-byte equivalent in behaviour to 2.1.x: same field set, same order, same
supported types. The only 2.2.x change is the module's Drupal core requirement (`^11.3 || ^12`); see
[../start.md](../start.md).
