<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks & events

## Hooks (`forward.api.php`)
| Hook | Signature | Use |
|---|---|---|
| `hook_forward_token($form_state)` | returns a token array | Add tokens for the email; pair with your `*.tokens.inc` to define replacements. `$form_state` may be NULL. |
| `hook_forward_mail_pre_render_alter(array &$render_array, FormStateInterface &$form_state)` | alter | Change the email render array before it is rendered (invoked via `hook_alter('forward_mail_pre_render')`). |
| `hook_forward_mail_post_render_alter(&$message_body, FormStateInterface &$form_state)` | alter | Change the final rendered body string (`hook_alter('forward_mail_post_render')`). |
| `hook_forward_entity(UserInterface $account, EntityInterface $entity, FormStateInterface $form_state)` | invokeAll | Post-process after a forward, e.g. set a redirect. |

## Symfony/Rules events (`src/Event`, `forward.rules.events.yml`)
| Event constant | Rules id | When |
|---|---|---|
| `EntityPreforwardEvent::EVENT_NAME` | `forward_entity_preforward` | Before the mail is sent. |
| `EntityForwardEvent::EVENT_NAME` | `forward_entity_forward` | After the mail is sent. |
Both carry `account` (user who forwarded) and `entity` (the forwarded entity) as context — usable as
Rules "reaction" events.

Example token hook:
```php
function my_module_forward_token($form_state) {
  return ['my_module' => ['ref' => 'ABC123']];
}
// plus my_module_tokens() defining [my_module:ref]
```
