# mailer_storage entity, auto-capture & resend

## Auto-capture
No code needed. When `mailer_storage` is enabled, `Drupal\mailer\Plugin\MailerMailPluginBase::send()`
calls `saveEmail()`, creating a `mailer_storage` entity (bundle `default`) with the mail's
`to`, `subject`, and `message` (format `full_html`) each time any MailerMail plugin sends.
Disable the module to stop archiving.

## Entity type `mailer_storage` (content, revisionable)
`RevisionableContentEntityBase`, uses `EntityOwnerTrait`. Base table `mailer_storage`,
revision table `mailer_storage_revision`, `show_revision_ui = TRUE`.
Base fields: `label` (string, required), `to` (email, required), `subject` (string, required),
`message` (text_long, required), `uid` (author entity_reference, defaults to current/anon),
`created` (timestamp). Bundle field: `bundle`. Field UI base route is the type edit form, so
extra fields can be attached per bundle.

Links: collection `/admin/content/mailer-storage`; add-page `/admin/content/mailer/add`;
add-form `/admin/content/mailer/add/{type}`; canonical `/admin/content/mailer/{id}`;
edit `/admin/content/mailer/{id}/edit`; delete `/admin/content/mailer/{id}/delete`;
resend `/admin/content/mailer-storage/{id}/resend`; delete-multiple
`/admin/content/mailer-storage/delete-multiple`.

Programmatic:
```php
$store = \Drupal::entityTypeManager()->getStorage('mailer_storage');
$store->create(['bundle' => 'default', 'label' => '…', 'to' => 'a@b.com',
  'subject' => 'Hi', 'message' => ['value' => '<p>…</p>', 'format' => 'full_html']])->save();
```
Has `views_data` (`EntityViewsData`) so records are available to Views.

## Bundle `mailer_storage_type` (config entity)
`ConfigEntityBundleBase`, `bundle_of = mailer_storage`, config prefix
`mailer_storage_type`, `config_export` = id/label/uuid. Collection
`/admin/structure/mailer_storage_types`. A `default` bundle ships in config/install.

## Resend
- MailerMail plugin `resend_email` (id `resend_email`, template
  `mailer_storage/src/Plugin/MailerMail/ResendMail/ResendMail`, config `MailerMailConfigBase`).
- `MailerStorageResendForm` (`resend` entity form; route
  `entity.mailer_storage.resend_form`, gated by `_entity_access mailer_storage.update`)
  loads the record's To/Subject/Message into the `resend_email` plugin config and calls
  `send()`, then redirects to the collection. This send is itself auto-captured (new record).

## Permissions & access
Permissions (mailer_storage.permissions.yml): `view mailer_storage`, `edit mailer_storage`,
`delete mailer_storage`, `create mailer_storage`, `administer mailer_storage types`
(admin_permission of both entity types; `restrict access: true`).
`MailerStorageAccessControlHandler`: view/update/delete each require the matching
per-op permission OR `administer mailer_storage types`; create requires
`create mailer_storage` OR admin. Resend requires update access.

## Config schema
`mailer_storage.mailer_storage_type.*` (config_entity: id, label, uuid, to, message,
subject). Also ships `system.action.mailer_storage_delete_action` (bulk delete action).

## Caveat
`info.yml` declares `configure: mailer_storage.send_mail_form`, but no such route exists in
2.0.x (there is no routing.yml defining it and no matching form) — treat it as a broken
reference; use the entity/type collections and Field UI instead.
