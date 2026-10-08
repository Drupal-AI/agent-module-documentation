# Hooks & cron

## Hook it invokes for you

`hook_sms_gateway_info_alter(array &$gateways)` — alter discovered `@SmsGateway` plugin definitions
after discovery (keyed by plugin id). Example:

```php
function my_module_sms_gateway_info_alter(array &$gateways): void {
  $gateways['log']['label'] = new \Drupal\Core\StringTranslation\TranslatableMarkup('The Logger');
}
```

## Hooks it implements (integration behaviour to know)

- `hook_cron` (`sms_cron`): purges expired phone-number verifications
  (`PhoneNumberVerification::purgeExpiredVerifications()`), pushes due stored messages into the queue
  worker (`SmsQueueProcessor::processUnqueued()`), and garbage-collects processed messages past their
  retention (`garbageCollection()`). Outgoing messages are actually dispatched by cron unless the
  gateway has `skip_queue`.
- `hook_entity_insert` / `hook_entity_update` (`_sms_entity_postsave`): for any content entity whose
  bundle has phone-number settings, syncs `sms_phone_number_verification` records — creating a new
  verification (and texting a code) for each new number, deleting records for removed numbers.
- `hook_entity_delete`: deletes the entity's phone-number verifications.
- `hook_requirements` (`sms.install`, runtime): reports incoming/outgoing queue backlog counts on the
  status report.
- `hook_token_info` / `hook_tokens` (`sms.tokens.inc`): `[sms:verification-url]`,
  `[sms-message:phone-number]`, `[sms-message:message]`, `[sms-message:verification-code]`.

Submodule `sms_user` also implements `hook_entity_presave` to delay outgoing messages into a
recipient's active hours — see the sms_user docs.
