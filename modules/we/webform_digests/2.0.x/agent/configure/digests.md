# Creating and configuring a digest (configure)

A digest is a **`webform_digest` config entity**. Manage them at
`/admin/structure/webform_digests` (route `entity.webform_digest.collection`, menu link under
*Structure*). "Add Webform digest" → `entity.webform_digest.add_form`
(`/admin/structure/webform_digests/add`). All of the collection/add/edit/delete/view routes require
core permission **`administer site configuration`** (the entity's `admin_permission`).

## Digest fields — `Form\WebformDigestForm`

Built in `WebformDigestForm::form()`. Every stored value maps to a property/config key on
`Entity\WebformDigest` (config schema `webform_digests.webform_digest.*`).

| Form field | Config key | `#type` | Meaning |
|---|---|---|---|
| Label | `label` | textfield (required) | Human name of the digest. |
| Machine name | `id` | machine_name | Config entity id (`WebformDigest::load` uniqueness). |
| Digest recipient | `recipient` | textfield (required) | The **To** address. Token-replaced. May be a token like `[node:author:mail]`. |
| Digest from | `originator` | textfield (required) | The **From** address. Token-replaced. |
| Digest subject | `subject` | textfield (required) | Email subject. Token-replaced. |
| Digest body | `body` | text_format (required) | Email body. Token-replaced, then flattened to plain text on send (see [../api/services.md](../api/services.md)). |
| Webform | `webform` | select (required) | Machine id of the target webform (options = `Webform::loadMultiple()`). Only submissions of this webform are digested. |

`WebformDigestForm::save()` writes the entity and redirects to the collection. Note `body` is a
`text_format` element but `WebformDigest::preSave()` **discards the chosen text format** and stores
only `$body['value']` (the raw string) — the format is not persisted and is not applied on output.

A `token_tree_link` (`#token_types: ['node', 'webform_digest']`) is rendered on the form so editors
can browse available tokens. Tokens available in every field come from the `webform_digest` token
type plus whatever token type the submission's **source entity** provides (usually `node`); see
the token table in [../api/services.md](../api/services.md).

## Conditional digests — filter which submissions are included

Each digest row has a **Conditions** operation (`hook_entity_operation`) linking to
`webform_digests.conditions_form` (`/admin/structure/webform_digests/{webform_digest}/conditions`),
which requires permission **`edit any webform digest`**. The form
(`Form\WebformDigestConditionsForm` → `WebformDigestConditionsFormBase`) renders a
`webform_element_states` element seeded with the target webform's
`getElementsSelectorOptions()` (state options: *Enabled* / *Disabled*, single group,
`#multiple: FALSE`). On submit it stores `$form_state->getValue('conditions')` into the entity's
`conditions` key.

At send time (`WebformDigestQueue::loadRelevantSubmissions()`), a digest is "conditional" when
`conditions` is a non-empty array (`WebformDigest::isConditional()`). The worker takes the first
state group (`key($conditions)`) and keeps only submissions for which
`webform_submission.conditions_validator->validateConditions()` returns TRUE. A digest with no
conditions includes **every** submission of the webform in the window.

## What the recipient actually receives

The body is whatever you author, with tokens replaced. The `webform_digest` token type gives you:

- `[webform_digest:label]`, `[webform_digest:subject]`, `[webform_digest:id]`
- `[webform_digest:submissions]` — a bulleted `item_list` of each included submission's **label**
  (`$submission->label()`), not its field values.
- `[webform_digest:submissions_count]` — the number of included submissions.

So a digest is a summary of submission *labels* and a *count*, plus any source-entity/site tokens
you add — it does not, by itself, print the submitted field values. One email is sent **per source
entity** that the matched submissions belong to (submissions with no source entity are dropped).

## Set / create a digest from code

```php
$digest = \Drupal::entityTypeManager()->getStorage('webform_digest')->create([
  'id' => 'daily_contact',
  'label' => 'Daily contact digest',
  'recipient' => 'team@example.com',
  'originator' => 'site@example.com',
  'subject' => 'Daily contact submissions',
  'body' => "You received [webform_digest:submissions_count] submissions:\n[webform_digest:submissions]",
  'webform' => 'contact',
]);
$digest->save();
```
