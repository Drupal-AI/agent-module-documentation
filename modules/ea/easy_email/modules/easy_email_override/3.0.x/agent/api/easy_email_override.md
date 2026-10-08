# API — declare an overridable email (`emails.yml` plugin)

To let site builders replace one of your module's emails with an Easy Email template, declare it
as a **declared-email plugin**. The plugin type is managed by
`plugin.manager.easy_email_override` (`DeclaredEmailManager`), which uses `YamlDiscovery` to read
`{module}.emails.yml` from every module.

## Declare an email — `my_module.emails.yml`
```yaml
my_module.some_email:
  id: 'my_module.some_email'
  label: 'My Module: Some email'
  module: 'my_module'        # module that sends the mail (matched against hook_mail key owner)
  key: 'some_email'          # the mail key passed to MailManager::mail()
  params:                    # named params your mail() call carries, exposed for mapping
    account:
      type: 'entity:user'    # entity type → becomes token-mappable in the override UI
      label: 'Account'
  weight: 0                  # optional, ordering in the UI
```
Required properties (enforced by `DeclaredEmailManager::processDefinition()`): `label`, `module`,
`key`. Definitions whose `module` isn't enabled are filtered out (use `module: '*'` to always
apply). `params` can be `entity:{type}` so the override can map that entity onto template fields.

## Derivatives
Emails can also be produced dynamically via a deriver. The submodule's own `emails.yml` uses
`easy_email_override.deriver` (`Drupal\easy_email_override\Plugin\Derivative\DeclaredEmailDeriver`)
to generate definitions. Point `deriver:` at your own class to declare emails programmatically.

## How the override fires
The `MailManager` decorator (decorates `plugin.manager.mail`) intercepts `MailManagerInterface::mail()`;
if an `easy_email_override` config entity matches the declared email's `module` + `key`, it renders
and sends the mapped `easy_email_type` template instead. You don't call anything yourself — just
declare the email and (as a site builder) create the override config entity.

## Read declared emails in code
```php
/** @var \Drupal\easy_email_override\Service\DeclaredEmailManagerInterface $manager */
$manager = \Drupal::service('plugin.manager.easy_email_override');
$definitions = $manager->getDefinitions();   // all declared, enabled-module emails
$one = $manager->getDefinition('user.password_reset');
```

Overridable emails ship in this submodule for core **user** mails and, via `easy_email_commerce`,
the Commerce `order_receipt`.
