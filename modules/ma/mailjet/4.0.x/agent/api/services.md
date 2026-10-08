# Services, API wrapper, mail plugin, queue worker, contact sync

## Services (`mailjet.services.yml`)

| Service id | Class | Args | Role |
|---|---|---|---|
| `mailjet.factory` | `MailjetFactory` | `@config.factory` | Builds a configured `\Mailjet\Client` from `mailjet.settings` (`create(bool $skip_active_status = FALSE)`; returns `NULL` when inactive or credentials empty). |
| `mailjet.handler` | `MailjetHandler` (impl `MailjetHandlerInterface`) | `@mailjet.factory` | OO API wrapper: `getMailjetDefaultList()`, `getMailjetContactLists()`, `getMailjetContactListByName()`, `getMailjetContactProperties()`, `createMailjetContactList()`, `createMailjetContactProperty()`, `updateMailjetContactProperty()`, `syncMailjetContacts()`, `syncMailjetContact()`, `createApiToken()`. |
| `mailjet.properties_sync` | `MailjetPropertiesSync` (impl `MailjetPropertiesSyncInterface`) | `@mailjet.handler`, `@current_user`, `@entity_type.manager` | Reconciles Drupal user `field_*` definitions with Mailjet contact metadata. |
| `mailjet.access_check` | `Access\MailjetConfigurationAccessCheck` | `@current_user` | Named access check `_mailjet_access_check`. |
| `mailjet.breadcrumb` | `MailjetBreadcrumbBuilder` | router/access/config/title/user/menu services | Breadcrumb builder (priority 1003). |
| `init_subscriber` | `EventSubscriber\InitSubscriber` | — | Subscribes to `KernelEvents::REQUEST` with an empty `onEvent()` (no-op). |

`MailjetHandlerInterface::CONFIG_NAME` is `mailjet.settings`; `DEFAULT_CONTACT_LIST_NAME` is the
default "Drupal contact list".

## Static API wrapper — `Drupal\mailjet\MailjetApi`

A static/singleton wrapper over `\Mailjet\Client` used across the procedural code. Key methods:

```php
MailjetApi::getApiClient($apiKey, $apiSecret);   // memoised \Mailjet\Client; throws if creds empty
MailjetApi::getMailjetContactLists($limit = 0);
MailjetApi::getMailjetContactListByName($name);
MailjetApi::getContactProperties();  MailjetApi::createMailjetContactProperty($name, $type);
MailjetApi::updateMailjetContactProperty($id, $name, $type);
MailjetApi::syncMailjetContact($listId, $contact, $action = 'addforce');   // add / 'remove' / 'unsub'
MailjetApi::syncMailjetContacts($listId, $contacts, $action = 'addforce'); // batch
MailjetApi::createApiToken(array $params);  MailjetApi::getApiToken($id);
MailjetApi::isValidAPICredentials();  MailjetApi::getMailjetIframe($username, $password);
```

`$contact` shape: `['Email' => '…', 'Properties' => ['propName' => value, …]]`. Both the static wrapper
and `MailjetHandler` post to the same Mailjet v3 resources (`Contactslist`,
`ContactslistManagecontact`, `ContactslistManagemanycontacts`, `Contactmetadata`, `Apitoken`,
`Eventcallbackurl`, `Sender`, `Myprofile`, …).

## Mail plugin — `mailjet_mail`

`Plugin\Mail\MailjetMail` (`@Mail(id = "mailjet_mail")`) implements `MailInterface`. When
`system.mail:interface.default = mailjet_mail`, Drupal routes all outbound mail here.
- `format()`: joins the body; if `mail_headers_allow_html_mailjet` is off, converts HTML→plain text.
- `mail()`: builds a **PHPMailer** message (recipients, CC/BCC, reply-to, MIME multipart handling,
  attachments), sets SMTP auth from `mailjet_username`/`mailjet_password`, host `in-v3.mailjet.com`,
  and `SMTPSecure` from the stored `mailjet_protocol`, then `$mailer->send()`. Debug logging is gated
  behind `\Drupal::state()->get('mailjet_debug')`.

`hook_mail()` (`mailjet.module`) defines two keys: `test_mail` (used by `MailjetTestEmailForm`) and
`activation_mail` (subscription confirmation email).

## Contact sync (users ⇄ Mailjet)

Base `mailjet.module` implements `hook_user_insert` / `hook_user_update` / `hook_user_delete`, which
call `mailjet_sync_single_user($user, 'add'|'update'|'remove')`. That resolves the default list
(`mailjet_get_default_list_id()` → "Drupal contact list", auto-created if absent), maps the user's
`field_*` values to Mailjet contact properties (`processCustomFields()` / `mailjet_properties_sync()`),
and calls `MailjetApi::syncMailjetContact()`. Logs go to the `mailjet_messages` channel.

### Queue worker — `sync_mailjet_contact`

`Plugin\QueueWorker\MailjetSyncContactQueueWorker` (`cron = {"time" = 60}`) does the same work
asynchronously. `processItem($data)` expects `['contact' => [...], 'action' => 'add'|'update'|'remove']`,
resolves the default list via `mailjet.handler`, syncs properties via `mailjet.properties_sync`, then
`syncMailjetContact($listId, $data['contact'], $action == 'remove' ? 'remove' : 'addforce')`. Enqueue:

```php
\Drupal::queue('sync_mailjet_contact')->createItem([
  'contact' => ['Email' => $user->getEmail(), 'Properties' => [...]],
  'action'  => 'add',
]);
```

## `MailjetFactory::create()` notes

Returns `NULL` unless `mailjet.settings` has `mailjet_active` + `mailjet_username` + `mailjet_password`
(pass `TRUE` to skip the active check). It sets a 10s connection timeout and a `drupal-mailjet-module`
user agent. See [../configure/settings.md](../configure/settings.md) for how credentials get there.
