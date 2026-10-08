# Enable uniqueness on a vocabulary

There is **no global settings page** (`configure: null`). Uniqueness is turned on per
vocabulary and stored as third-party settings on that vocabulary's config entity.

## Where it is stored

Config entity: `taxonomy.vocabulary.<vid>`
```yaml
third_party_settings:
  taxonomy_unique:
    enabled: true
    message: 'Term "%term" already exists in vocabulary "%vocabulary".'
```
- `enabled` (boolean) — turns the constraint on for this vocabulary.
- `message` (string) — error shown on a duplicate. Placeholders: `%term`, `%vocabulary`.
  If left empty in the form it is stored as the default message (see below).

Config schema: `taxonomy.vocabulary.*.third_party.taxonomy_unique` (`enabled`, `message`).

## Via the UI

The module adds a collapsed **"Taxonomy unique"** fieldset to the vocabulary edit form
(`/admin/structure/taxonomy/manage/<vid>`):
1. Tick **Terms should be unique.**
2. Optionally fill **Message to show if term already exists** (supports `%term`,
   `%vocabulary`; empty ⇒ default message).
3. **Save**. A submit handler writes the two third-party settings on the vocabulary.

## Via drush php:eval (scriptable)

```php
$v = \Drupal::entityTypeManager()->getStorage('taxonomy_vocabulary')->load('tags');
$v->setThirdPartySetting('taxonomy_unique', 'enabled', TRUE)
  ->setThirdPartySetting('taxonomy_unique', 'message', 'Term "%term" already exists in "%vocabulary".')
  ->save();
```

Turn it off: `$v->setThirdPartySetting('taxonomy_unique', 'enabled', FALSE)->save();`

## Read it back

```bash
drush cget taxonomy.vocabulary.tags third_party_settings.taxonomy_unique
# enabled: true / message: '...'
```
Or in PHP: `$v->getThirdPartySetting('taxonomy_unique', 'enabled')`.

## Behavior notes

- Uniqueness is per **vocabulary + name + langcode**. The same name may exist in another
  vocabulary, or in the same vocabulary in a different language.
- Enforcement happens on **entity validation at save** (UI form, JSON:API/REST, and any code
  that calls `$term->validate()` / saves through a validated flow).
- Default message constant:
  `Term "%term" already exists in vocabulary "%vocabulary".`
