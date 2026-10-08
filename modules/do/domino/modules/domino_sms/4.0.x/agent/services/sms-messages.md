<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domino SMS — displaying SMS as Drupal messages

## Install & enable

```bash
drush en domino_sms -y   # requires domino + sms (SMS Framework)
```

Installs `config/install/domino_sms.settings.yml` with `display_sms_as_messages: 1`. There is no
settings form; set the flag per environment in `settings.php`:

```php
$config['domino_sms.settings']['display_sms_as_messages'] = TRUE;
```

## The subscriber

`src/EventSubscriber/DominoSmsSubscriber.php` (service `domino_sms.event_subscriber`,
constructor args `@messenger`, `@config.factory`) subscribes to
`SmsEvents::MESSAGE_PRE_PROCESS` (`getSubscribedEvents()`).

`onMessagePreprocess(SmsMessageEvent $event)`:

1. Reads `domino.settings` (parent) and `domino_sms.settings`.
2. **Returns early** — leaving SMS to be sent normally — if
   `domino.settings.application_mode === ApplicationInterface::MODE_PRODUCTION`
   **or** `domino_sms.settings.display_sms_as_messages` is falsy.
3. Otherwise, for each message in `$event->getMessages()`:
   - takes `$message->getMessage()`,
   - wraps every 6-digit run in `<span class="otp-code">$0</span>`
     (`preg_replace('/\d{6}/', ...)`) to highlight OTP codes,
   - wraps it with `Markup::create()` and adds it via `messenger->addStatus()`.
4. Calls `$event->setMessages([])` so the SMS Framework has nothing left to dispatch — no SMS is
   sent to the gateway.

## Operating notes

- **No gateway credentials here.** The submodule reads only two config objects and the messenger;
  it never opens an HTTP connection or reads an API key. Gateway/provider credentials are configured
  in the SMS Framework module and are irrelevant while this feature is active (nothing is dispatched).
- Behaviour is strictly non-production: with `application_mode: production` (Domino's default) SMS is
  always sent normally, regardless of `display_sms_as_messages`.
- Style the highlighted codes with the `.otp-code` CSS class in your theme.
