# Add a Schema.org type (Group + Tag + PropertyType plugins)

A per-type submodule = one Metatag **Group** (the `@type` container) + one Metatag **Tag** per
Schema.org property. Values are shaped by **PropertyType** plugins that this base module defines.

## 1. Group (defines the type)
`src/Plugin/metatag/Group/SchemaArticle.php` extends `SchemaGroupBase`:
```php
/** @MetatagGroup(id="schema_article", label=@Translation("Schema.org: Article"), weight=10) */
class SchemaArticle extends SchemaGroupBase {}
```

## 2. Tag per property
`src/Plugin/metatag/Tag/SchemaArticleType.php` extends `SchemaNameBase`:
```php
/**
 * @MetatagTag(
 *   id = "schema_article_type",           // globally unique
 *   label = @Translation("@type"),
 *   name = "@type",                        // Schema.org element name
 *   group = "schema_article",              // matches the Group id
 *   property_type = "type",                // a SchemaPropertyType plugin id
 *   tree_parent = {"Article"},             // @type option tree root
 *   tree_depth = -1,
 *   multiple = FALSE,
 * )
 */
class SchemaArticleType extends SchemaNameBase {}
```
Most tags are just an empty subclass of `SchemaNameBase`; behavior comes from the annotation.
For image properties extend `SchemaImageObjectBase` instead.

## 3. PropertyType plugins (the plugin type THIS module defines)
`@SchemaPropertyType` (annotation `Drupal\schema_metatag\Annotation\SchemaPropertyType`,
manager `plugin.manager.schema_property_type`, namespace `Plugin/schema_metatag/PropertyType`).
They convert a tag's tokenized value into the correct JSON-LD sub-structure. Built-ins include
`Text`, `URL`, `Type`, `ImageObject`, `Person`, `Organization`, `PostalAddress`,
`GeoCoordinates`, `Duration`, `Date`, `DateTime`, `Rating`, `QuantitativeValue`,
`MonetaryAmount`, `ItemListElement`, `BreadcrumbList`, `Question`/`Answer`, `HowToStep`, etc.
Add your own by creating a class in `src/Plugin/schema_metatag/PropertyType/` with a
`@SchemaPropertyType` annotation and a `form()` / `outputValue()` implementation
(extend `PropertyTypeBase`).

Enable the submodule; the group and tags appear under the site's Metatag configuration.
