# Define meta tags & groups (plugins)

Metatag defines two plugin types (managers in `metatag.services.yml`):

| Plugin type | Manager service | Annotation | Base class | Directory |
|---|---|---|---|---|
| `MetatagTag` | `plugin.manager.metatag.tag` | `@MetatagTag` | `MetaNameBase` / `MetaPropertyBase` / `LinkRelBase` / `MetaHttpEquivBase` / `MetaItempropBase` | `src/Plugin/metatag/Tag/` |
| `MetatagGroup` | `plugin.manager.metatag.group` | `@MetatagGroup` | `GroupBase` | `src/Plugin/metatag/Group/` |

## Add a tag
```php
namespace Drupal\my_module\Plugin\metatag\Tag;

use Drupal\metatag\Plugin\metatag\Tag\MetaNameBase;

/**
 * @MetatagTag(
 *   id = "my_tag",
 *   label = @Translation("My tag"),
 *   description = @Translation("What it does."),
 *   name = "my-tag",
 *   group = "advanced",
 *   weight = 5,
 *   type = "label",
 *   secure = FALSE,
 *   multiple = FALSE
 * )
 */
class MyTag extends MetaNameBase {}
```

Key `@MetatagTag` properties: `id`, `label`, `description`, `name` (the emitted
`<meta name="…">`), `group` (a MetatagGroup id), `weight`, `type` (label/uri/image/…),
`secure`, `multiple`, `long`, `trimmable`. Pick the base class by output shape:
`MetaNameBase` (`<meta name>`), `MetaPropertyBase` (`<meta property>`, Open Graph),
`LinkRelBase` (`<link rel>`), `MetaHttpEquivBase` (`<meta http-equiv>`),
`MetaItempropBase` (`<meta itemprop>`).

## Add a group
```php
/**
 * @MetatagGroup(
 *   id = "my_group",
 *   label = @Translation("My group"),
 *   description = @Translation("Grouping of related tags."),
 *   weight = 10
 * )
 */
class MyGroup extends GroupBase {}
```

Core ships the `basic` and `advanced` groups; submodules add `open_graph`,
`twitter_cards`, `dublin_core`, etc. For code-free custom tags use the
**metatag_custom_tags** submodule instead of writing a plugin.
