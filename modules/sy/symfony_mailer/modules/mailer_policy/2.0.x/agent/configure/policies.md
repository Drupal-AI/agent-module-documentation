# Configure Mailer policies

## Where
`/admin/config/system/mailer/policy` — list (route `entity.mailer_policy.collection`,
`MailerPolicyListBuilder`). Add: `entity.mailer_policy.add_form` /
`entity.mailer_policy.add_id_form`; edit: `entity.mailer_policy.edit_form`; delete:
`entity.mailer_policy.delete_form`. All gated by `administer mailer`.

## The config entity
`@ConfigEntityType(id = "mailer_policy")`, class
`Drupal\mailer_policy\Entity\MailerPolicy`. The entity **id is the email type tag** it
targets; the special id `_` is the site-wide default. It holds `adjusters` — a keyed map of
EmailAdjuster plugin id → configuration, managed via `AdjusterPluginCollection`
(`adjusters()->sort()` runs them by weight per phase).

```yaml
# mailer_policy.mailer_policy.user__password_reset.yml
langcode: en
id: user__password_reset
adjusters:
  email_subject:
    id: email_subject
    value: 'Reset your password at [site:name]'
  email_from:
    id: email_from
    value: { display: '[site:name]', address: 'noreply@example.com' }
  email_theme:
    id: email_theme
    theme: my_email_theme
```

## Targeting / resolution
Policies resolve from broad to specific: `_` (all mail) → `TYPE` (e.g. `user`) →
`TYPE__SUBTYPE` (e.g. `user__password_reset`). A more specific policy's adjusters override the
broader ones. The `metadata_key` on a component mailer lets a policy be selected per parameter
(e.g. per contact form).

The edit form (`PolicyEditForm`) lets you add adjusters from the available
`#[EmailAdjuster]` plugins and configure each — see
[../plugins/email-adjuster.md](../plugins/email-adjuster.md).
