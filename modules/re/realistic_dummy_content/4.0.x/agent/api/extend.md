# The API — file convention, entity_presave flow, and extending

All machine names below live in the **`realistic_dummy_content_api`** submodule
(`web/modules/contrib/realistic_dummy_content/api/`). The parent `realistic_dummy_content` module
adds no code — it only bundles example data under `realistic_dummy_content/realistic_dummy_content/`.

## How generation is intercepted

There is no route or service to call. The whole mechanism hangs off one hook:

1. `realistic_dummy_content_api_entity_presave($entity)` (`realistic_dummy_content_api.module:112`)
   implements `hook_entity_presave` and forwards to
   `Framework::instance()->hookEntityPresave($entity)`.
2. `Drupal8::hookEntityPresave()` (`api/src/Framework/Drupal8.php:23`) checks
   `realistic_dummy_content_api_is_dummy($entity, $type)`. **Default test** is
   `isset($entity->devel_generate)` (`Drupal8::entityIsDummy`) — i.e. the entity was produced by
   `devel_generate`. If not dummy, nothing happens.
3. If dummy, `realistic_dummy_content_api_improve_dummy_content($entity, $type)` collects modifier
   classes via `hook_realistic_dummy_content_api_class` and runs each: `new $class($entity, $type,
   $filter)`, `->modify()`, `->getEntity()`. The default modifier is
   `RealisticDummyContentFieldModifier`.

Exceptions in the flow are swallowed (`catch (\Throwable)`), so a bad file never breaks a save.
`realistic_dummy_content_api_argcheck_entitytype()` rejects the string `'article'` as an entity type
(guard against passing a bundle where an entity type is expected).

## The file-directory convention (the normal way to customise)

`RealisticDummyContentFieldModifier` builds one `RealisticDummyContentAttribute` per field/property
of the entity's bundle, then each attribute's `change()`
(`api/src/includes/RealisticDummyContentAttribute.php:140`) does:

- `getCandidateFiles()` — for **every enabled module**, scan
  `DRUPAL_ROOT/<module path>/realistic_dummy_content/fields/{entity_type}/{bundle}/{field_name}/`
  (`RealisticDummyContentAttribute.php:181`). Files from all modules are merged, so several modules
  can contribute values for the same field.
- Filter by extension: text attributes accept `txt`; image attributes accept `gif|png|jpg`
  (`getExtensions()` / `RealisticDummyContentImageField::getExtensions()`).
- Pick one file with `rand(0, count-1)` (see the random/sequential toggle below), read its trimmed
  contents, and `Framework::setEntityProperty()` writes it into the field. Images are first copied
  to `public://dummyfile<radical>.<ext>` (`RealisticDummyContentAttribute::fileSave()`) and owned by
  the entity's uid.

Directory shape (mirror this in `MYMODULE/realistic_dummy_content/fields/...`):

```
MYMODULE/realistic_dummy_content/fields/node/article/
  body/
    lorem.txt                 # a candidate body value
    ipsum.txt                 # another candidate
    ipsum.txt.format.txt      # metadata: text format for ipsum.txt (e.g. "full_html")
  field_image/
    photo1.jpg                # candidate image
    photo1.jpg.alt.txt        # metadata: alt text for photo1.jpg
  title/
    a.txt
    b.txt
MYMODULE/realistic_dummy_content/fields/user/user/user_picture/
  1.png
  2.jpg
```

- Value file = `<name>.<ext>`. Metadata file = `<name>.<ext>.<attribute>.txt`
  (`RealisticDummyContentEnvironment::getFileParts()` groups them by "radical"). Known attributes:
  `format` (body/text_with_summary; falls back to `basic_html` = `Framework::filteredHtml()`) and
  `alt` (image fields). Metadata is never required.
- `README*` files in these directories are skipped (`validCandidateFilename()`).
- `{bundle}` for the `user` entity type is `user`.

## Random vs. sequential (deterministic) selection

`realistic_dummy_content_api_rand($start, $end, $hash)` (`realistic_dummy_content_api.module:302`)
returns `rand()` when config `realistic_dummy_content_api.realistic_dummy_content_api_rand` is truthy
(the install default is `1`), otherwise a **deterministic** value from `Math::sequential()` keyed by
the entity hash. Set it falsy (e.g. in a test or recipe) for reproducible content. Constants:
`REALISTIC_DUMMY_CONTENT_API_RANDOM` (TRUE), `REALISTIC_DUMMY_CONTENT_API_SEQUENTIAL` (FALSE), plus a
legacy `REALISTIC_DUMMY_CONTENT_SEQUENTIAL` kept for old recipes.

## Integrator hooks (documented in `api/realistic_dummy_content_api.api.php`)

- **`hook_realistic_dummy_content_api_dummy($entity, $type)`** → return `TRUE` if the entity should
  be treated as dummy content. Use this if you generate content without `devel_generate`, or need a
  custom "is this dummy?" rule. Any module returning TRUE wins
  (`realistic_dummy_content_api_is_dummy` OR-combines all implementations).
- **`hook_realistic_dummy_content_api_class($entity, $type, array $filter = [])`** → return an array
  of modifier class names (each must be a subclass of `RealisticDummyContentBase`). Default returns
  `[RealisticDummyContentFieldModifier]`. `$filter` may carry `include`/`exclude` field lists.
- **`hook_realistic_dummy_content_attribute_manipulator_alter(&$class, array &$info)`** → choose the
  manipulator class for one field. `$info` = `['type', 'machine_name', 'entity', 'field_name']`;
  `Framework::fieldTypeMachineName($info)` normalises `entity_reference`→`taxonomy_term_reference`.
  The module's own implementation maps: `text_with_summary` → `RealisticDummyContentTextWithSummaryField`,
  `taxonomy_term_reference` → `RealisticDummyContentTermReferenceField`, `image` →
  `RealisticDummyContentImageField`. **Implement this hook to add a custom field type**: set `$class`
  to your own subclass of `RealisticDummyContentField` (override `getExtensions()` and
  `implementValueFromFile($file)` to turn a file into the field's structured value).

## Class hierarchy (for writing a custom manipulator)

- `RealisticDummyContentBase` → `RealisticDummyContentEntityBase` (holds entity/type/filter/hash) →
  `RealisticDummyContentFieldModifier` (builds attributes, `modify()`).
- `RealisticDummyContentAttribute` (`change()`, `valueFromFiles()`, `imageSave()`, `fileSave()`) →
  `RealisticDummyContentField` (`getType()='field'`) → `RealisticDummyContentValueField`,
  `RealisticDummyContentImageField`, `RealisticDummyContentTextWithSummaryField`,
  `RealisticDummyContentTermReferenceField`; and `RealisticDummyContentProperty` /
  `RealisticDummyContentTextProperty` for non-field properties (e.g. node title).
- Framework abstraction: `Framework::instance()` delegates to `Drupal8` (chosen by
  `realistic_dummy_content_api_version()`), which wraps `\Drupal::*` calls (config, state,
  entity field map, devel_generate plugin manager, file repository, logger). This indirection is a
  historical Drupal 7/8 portability layer — new code should just read it as "the Drupal API".
