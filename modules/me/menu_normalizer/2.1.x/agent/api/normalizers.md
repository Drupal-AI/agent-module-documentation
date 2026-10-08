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

So normalizing the array returned by `MenuLinkTreeInterface::load()`/`transform()` yields the full nested
tree in one call. There is no matching denormalizer for tree elements; `denormalize` is inherited from
`NormalizerBase` only where core provides it.
