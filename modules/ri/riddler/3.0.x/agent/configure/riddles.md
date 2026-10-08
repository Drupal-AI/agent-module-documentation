# Manage riddles & wire the Riddler challenge

## The `riddle` config entity

Config entity type `riddle` (class `Drupal\riddler\Entity\Riddle`, config prefix `riddle`, so config
names are `riddler.riddle.<id>`). Exported fields:

| Field | Notes |
|---|---|
| `id` | machine name (also the config-entity id) |
| `question` | shown as the CAPTCHA field's title |
| `solution` | **comma-separated** list of allowed answers |
| `hint` | optional, shown as the field description |
| `status` | enabled/disabled (only enabled riddles are used) |

Schema: `riddler.riddle.*` in `config/schema/riddler.schema.yml`. The module ships one example
riddle (`riddler.riddle.example`).

## Admin UI

Routes (permission `administer CAPTCHA settings`, provided by CAPTCHA):

- Collection: `/admin/config/people/captcha/riddler-riddle` (route `entity.riddle.collection`)
- Add: `.../riddler-riddle/add` — Edit: `.../riddler-riddle/{riddle}` — Delete: `.../{riddle}/delete`

The collection list shows question / solution / hint / status and warns that page caching is only
compatible with a single riddle.

## Wire the challenge onto a form

Riddler only *provides* the challenge; you attach it in the **CAPTCHA** settings
(`/admin/config/people/captcha`) by adding a CAPTCHA point for the target `form_id` and choosing the
**`Riddler`** challenge type (or set the default challenge to Riddler). CAPTCHA then renders a random
enabled riddle on that form.

## Create a riddle by script (drush php:eval)

```php
$storage = \Drupal::entityTypeManager()->getStorage('riddle');
$storage->create([
  'id' => 'town_name',
  'question' => "What is our town's name?",
  'solution' => 'Springfield,springfield',   // comma-separated = several accepted answers
  'hint' => 'It is where the Simpsons live.',
  'status' => TRUE,
])->save();
```

Read it back:
```bash
drush cget riddler.riddle.town_name
```
Load in PHP: `\Drupal\riddler\Entity\Riddle::load('town_name')` → `->getSolution()`, `->getQuestion()`,
`->getHint()`, `->status()`.

## How answers are validated

`riddler_captcha()` (`hook_captcha`) picks `array_rand()` of the enabled riddles and sets a required
textfield titled with the question. `riddler_captcha_validate()` splits `solution` on commas, trims,
and matches the response using `captcha.settings: default_validation`
(`CAPTCHA_DEFAULT_VALIDATION_CASE_SENSITIVE` vs `..._CASE_INSENSITIVE`).

## Caching caveat

- **Exactly one** enabled riddle → the challenge is marked cacheable (`result['cacheable'] = TRUE`).
- **Two or more** enabled riddles → Riddler sets `max-age = 0` and triggers the
  `page_cache_kill_switch` for those forms so a new random riddle is shown each request. Keep a single
  enabled riddle if page cache on protected forms matters.
