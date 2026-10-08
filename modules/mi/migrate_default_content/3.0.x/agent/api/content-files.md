# Authoring content YAML files

Files live in `source_dir` (default `default_content/` beside the Drupal root). One file per
entity-type + bundle, named `ENTITY_TYPE.BUNDLE.yml`. Each file is a YAML **list** of records.

## Naming
- `node.article.yml`, `user.user.yml`, `taxonomy_term.tags.yml`, `paragraph.content.yml`,
  `menu_link_content.menu_link_content.yml`, `media.image.yml`, `file.file.yml`.
- Translations: `ENTITY_TYPE.BUNDLE.LANGCODE.yml` (e.g. `node.article.es.yml`).

## Identifier
The **first key** of each record is that record's migration identifier, used when other files
reference it. Any field works — commonly `name`, `title`, or `uuid`.

```yaml
# user.user.yml
-
  name: Ed I. Tor        # first key = identifier "Ed I. Tor"
  mail: ed@example.com
```

## Entity references
Reference fields are resolved by identifier against the other files. Dependencies are added
automatically (entity-reference and entity-reference-revision fields both work).

```yaml
# node.article.yml
-
  title: Example article
  uid: Ed I. Tor         # looked up in user.user.yml by its identifier
```

Use a UUID as the identifier when you want stable references:
```yaml
# user.user.yml
-
  uuid: 3ef9f089-dad2-4878-9da4-a12a56b568b5
  name: Ed I. Tor
# node.article.yml
-
  title: Example article
  uid: 3ef9f089-dad2-4878-9da4-a12a56b568b5
```

## Multi-component fields (formatted text, etc.)
Two equivalent forms:
```yaml
# camelCase subcomponents
-
  title: Example
  bodyValue: Body text
  bodyFormat: basic_html
  bodySummary: Summary text
```
```yaml
# nested
-
  title: Example
  body:
    value: Body text
    format: basic_html
    summary: Summary text
```

## Files / images
Drop files in `default_content/files/` and reference by filename; they migrate to `public://`.
```yaml
# node.article.yml
-
  title: Example article
  field_image: example-image.jpg
```
For more control (UUID, remote source) add a `file.file.yml` with `filename` + a source field,
then reference the file's UUID from the node.

## Menu links
```yaml
# menu_link_content.menu_link_content.yml
-
  title: Internal Link
  link: internal:/internal-link
  menu_name: main
  weight: 0
-
  title: External Link
  link: https://example.com
  menu_name: main
  weight: 1
```

## Translations
Create `ENTITY_TYPE.BUNDLE.LANGCODE.yml` and add a `translation_origin` pointing at the
original record's identifier:
```yaml
# node.article.es.yml
-
  title: Artículo de ejemplo
  translation_origin: Example article   # identifier from node.article.yml
```

## Passwords
Any password-type field value is hashed automatically on import (via the `password_hash`
process plugin) — store plaintext in the YAML.
